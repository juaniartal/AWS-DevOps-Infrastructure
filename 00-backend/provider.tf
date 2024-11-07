terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    bitbucket = {
      source  = "terraform-providers/bitbucket"
      version = "~> 1.0" 
    }
  }
}

provider "aws" {
  profile = var.sso_profile
  region = var.region
}

