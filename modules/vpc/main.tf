# VPC and attached internet gateway
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-apigateway"
  }
}

# public and private subnets per AZ
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.private_subnets)

  tags = {
    Name = "${var.name}-private-subnet-${format("%03d", count.index + 1)}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-${format("%03d", count.index + 1)}"
  }
}

# routing table for the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
  count          = length(var.public_subnets)
}

# NAT gateways and EIP for the private subnets
resource "aws_nat_gateway" "this" {
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  depends_on    = [aws_internet_gateway.this]
  count         = length(var.private_subnets)

  tags = {
    Name = "${var.name}-nat-${format("%03d", count.index + 1)}"
  }
}

resource "aws_eip" "nat" {
  count = length(var.private_subnets)
  vpc   = true

  tags = {
    Name = "${var.name}-eip-${format("%03d", count.index + 1)}"
  }
}

# routing table for the private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  count  = length(var.private_subnets)

  tags = {
    Name = "${var.name}-route-table-private-${format("%03d", count.index + 1)}"
  }
}

resource "aws_route" "private" {
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)
  count                  = length(compact(var.private_subnets))
}

resource "aws_route_table_association" "private" {
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
  count          = length(var.private_subnets)
}
