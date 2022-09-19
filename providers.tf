terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.31.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws-access-key
  secret_key = var.aws-secret-key
}
