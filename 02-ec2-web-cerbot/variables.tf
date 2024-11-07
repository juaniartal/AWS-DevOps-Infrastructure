variable "region" {}
variable "sso_profile" {}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "customer" {
  description = "Customer name"
  type        = string
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  default = "ami-06b21ccaeff8cd686"
}

variable "private_ip" {}


variable "domain_name" {
  type        = string
  description = "Main domain for DNS record"
  default     = "academybox1.academy.kopiustech.com"
}

variable "zone_id" {
  type        = string
  description = "Route 53 Zone ID for the domain"
  default     = "Z024291439V5XQWR1V5EE"
}

variable "ttl" {
  description = "Time to live (TTL) in seconds for DNS records"
  type        = number
  default     = 30
}

variable "name_dns_ec2" {
  description = "DNS name for EC2 instance"
  type        = string
  default     = "webserverec2.academybox1.academy.kopiustech.com"
}

variable "timeout" {
  type    = string
  default = "60s"
}
