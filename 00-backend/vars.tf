variable "environment" {
  description = "The deployment environment, such as dev, prod, etc."
  type        = string
  default     = "dev"
}

variable "customer" {
  description = "Customer name."
  type        = string
  default     = "my-customer"
}

variable "project" {
  description = "Project name."
  type        = string
  default     = "my-project"
}

variable "region" {
  description = "The AWS region where resources will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for storing the Terraform state."
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for Terraform locks."
  type        = string
  default     = "tfstatelocks"
}

variable "iam_user_name" {
  description = "Name of the IAM user who will deploy Terraform."
  type        = string
  default     = "terraform_deployer"
}

variable "iam_user_path" {
  description = "Path for the IAM user."
  type        = string
  default     = "/user/"
}

variable "policy_arn" {
  description = "ARN of the policy to attach to the IAM user."
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "terraform_version" {
  description = "The version of the Terraform provider to use."
  type        = string
  default     = ">= 0.13"
}

variable "sso_profile" {
  description = "SSO login profile."
  type        = string
  default     = "academy-box-1"
}
