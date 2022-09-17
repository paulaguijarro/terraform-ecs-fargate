variable "name" {
  type        = string
  description = "The name of the Security Group"
}

variable "vpc_id" {
  type        = string
  description = "The VPC id"
}

variable "http_port" {
  type        = number
  description = "The HTTP port number"
  default     = 80
}

variable "htts_port" {
  type        = number
  description = "The HTTPS port number"
  default     = 443
}

variable "container_port" {
  type        = number
  description = "The ECS task exposed port"
}


