terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.43.0, <4.47.0, !=4.43.0"
    }
  }
  required_version = "~>1.6.0"
}

provider "aws" {
  # Configuration optio
  region = "us-east-1"
}

provider "aws" {
  # Configuration optio
  region = "us-east-2"
  alias = "ohio"
}

