terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.43.0"
    }
  }
  required_version = ">1.7.0"
}

provider "aws" {
  # Configuration optio
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}
