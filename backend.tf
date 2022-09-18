# Using local backend for the time being

# terraform {
#   required_version = ">= 1.2.0"

#   backend "s3" {
#     bucket         = "example.terraform.bucket"
#     key            = "terraform/prod.tfstate"
#     region         = var.region
#     dynamodb_table = "terraform-tfstate-prod-lock"
#     encrypt        = true
#   }
# }
