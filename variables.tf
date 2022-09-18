variable "aws-access-key" {
  description = "The AWS access key"
  type        = string
}

variable "aws-secret-key" {
  description = "The AWS secret key"
  type        = string
}

variable "region" {
  description = "The AWS resgion"
  type        = string
  default     = "eu-west-1"
}

variable "availability_zones" {
  description = "The list of AZs, defaults to all AZ of the region"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
