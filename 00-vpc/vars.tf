variable "region" {
  description = "The region where AWS resources will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "public_subnet_b_cidr" {}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for storing the Terraform state."
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for locking the Terraform state."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "environment" {
  description = "The environment where the resources will be deployed."
  type        = string
}

variable "customer" {
  description = "The customer's name."
  type        = string
}

variable "app_name_dashed" {
  description = "The application name in dashed format."
  type        = string
  default     = "my-app"
}

variable "project" {
  description = "The project name."
  type        = string
  default     = "project-name"
}

variable "from_port" {
  description = "The starting port for the ACL rule."
  type        = number
  default     = 0
}

variable "to_port" {
  description = "The ending port for the ACL rule."
  type        = number
  default     = 0
}

variable "protocol" {
  description = "The protocol for the ACL rule. -1 allows all protocols."
  type        = string
  default     = "-1"
}

variable "terraform_version" {
  description = "The version of the Terraform provider to use."
  type        = string
  default     = ">= 0.13"
}

variable "sso_profile" {}

variable "cidr_block" {}