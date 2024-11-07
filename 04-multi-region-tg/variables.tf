

variable "region" {
  description = "Región donde se desplegarán los recursos"
  default     = "us-east-1"
}

variable "cidr_block" {
  description = "Bloque CIDR para la VPC"
  default     = "10.0.0.0/16"
}

variable "environment" {}
variable "customer" {}
variable "sso_profile" {}
variable "project" {}


################### VPC ############################

variable "vpc_a_cidr" {
  type = string
}

variable "vpc_b_cidr" {
  type = string
}

variable "vpc_c_cidr" {
  type = string
}

variable "subnet_a_cidr" {
  type = string
}

variable "subnet_b_cidr" {
  type = string
}

variable "subnet_c_cidr" {
  type = string
}

variable "availability_zone_a" {
  type = string
}

variable "availability_zone_b" {
  type = string
}

variable "availability_zone_c" {
  type = string
}





################### EC2 ############################



variable "ami_virginia" {
  type = string
}

variable "ami_oregon" {
  type = string
}

variable "ami_ohio" {
  type = string
}

variable "instance_type" {
  type = string
}
