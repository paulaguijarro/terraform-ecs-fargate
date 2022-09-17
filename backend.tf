# Using local backend for the time being

# terraform {
#   required_version = ">= 1.2.0"

#   backend "s3" {
#     bucket         = "exercise.prod.terraform"
#     key            = "terraform/prod.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-tfstate-prod-lock"
#     encrypt        = true
#   }
# }
