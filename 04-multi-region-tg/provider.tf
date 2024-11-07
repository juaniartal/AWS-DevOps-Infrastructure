terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      configuration_aliases = [
        aws.virginia,
        aws.oregon,
        aws.ohio
      ]
    }
  }
}


provider "aws" {
  profile = var.sso_profile
  region  = var.region
}

provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  profile = var.sso_profile
}

provider "aws" {
  alias   = "oregon"
  region  = "us-west-2"
  profile = var.sso_profile
}


provider "aws" {
  alias   = "ohio"
  region  = "us-east-2"
  profile = var.sso_profile
}