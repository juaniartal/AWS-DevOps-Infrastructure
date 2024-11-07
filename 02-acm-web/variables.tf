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

variable "timeout" {
  type    = string
  default = "60s"
}

variable "domain_name" {
  description = "Main domain name for the ACM certificate"
  type        = string
  default     = "academybox1.academy.kopiustech.com"
}

variable "zone_id" {
  description = "Route 53 zone ID"
  type        = string
  default     = "Z024291439V5XQWR1V5EE"
}

variable "subject_alternative_names" {
  description = "List of subdomains to include in the ACM certificate"
  type        = list(string)
  default = [
    "webserver1.academybox1.academy.kopiustech.com",
    "webserver2.academybox1.academy.kopiustech.com",
    "webserver.academybox1.academy.kopiustech.com"
  ]
}

variable "ttl" {
  description = "Time-to-live (TTL) in seconds for DNS records"
  type        = number
  default     = 300 # You can reduce it if you're in a testing phase
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "academybox"
  }
}
