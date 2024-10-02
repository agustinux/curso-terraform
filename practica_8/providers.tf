terraform {
  required_providers {
    aws = { // Importamos el provider 'AWS'
      source  = "hashicorp/aws"
      version = ">=4.43.0"
    }
    random = { // Importamos el provider 'random'
      source = "hashicorp/random"
      version = ">=3.6.2"
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

provider "random" {
  # Configuration options
}