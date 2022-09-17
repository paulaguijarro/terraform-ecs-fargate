variable "name" {
  type        = string
  description = "The name of the ECR repository"
}

variable "tag_immutability" {
  type        = string
  description = "Tag immutability"
  default     = "MUTABLE" // set to MUTABLE in order to put a latest tag on the most recent image.
}
