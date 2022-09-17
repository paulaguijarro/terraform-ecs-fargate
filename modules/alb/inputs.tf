variable "name" {
  type        = string
  description = "The name of the ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnets" {
  type        = list(any)
  description = "The list of subnets"
}

variable "alb_sg" {
  type        = list(any)
  description = "The list of security groups"
}

variable "healthcheck" {
  type        = string
  description = "The path to check if the service is healthy"
  default     = "/"
}

# variable "tls_cert_arn" {
#   description = "The ARN of the certificate that the ALB uses for https"
# }
