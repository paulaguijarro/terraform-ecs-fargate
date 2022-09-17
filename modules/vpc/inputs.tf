variable "name" {
  type        = string
  description = "The name of the VPC"
}

variable "vpc_cidr" {
  description = "CIDR range of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The list of AZs, defaults to all AZ of the region"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "private_subnets" {
  description = "The list of CIDRs for private subnets, must have as many elements as there are availability zones"
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
}

variable "public_subnets" {
  description = "The list of CIDRs for public subnets in your VPC, must have as many elements as there are availability zones"
  type        = list(string)
  default     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
}

