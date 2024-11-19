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

variable "domain_name" {
  type        = string
  description = "Dominio principal para el registro DNS"
  default     = "academybox1.academy.kopiustech.com"
}

variable "dnsname" {
  type    = string
  default = "webserverjuan4.academybox1.academy.kopiustech.com"
}

variable "zone_id" {
  type        = string
  description = "Zone ID de Route 53 para el dominio"
  default     = "Z024291439V5XQWR1V5EE"
}


variable "ttl" {
  description = "Tiempo de vida (TTL) en segundos para los registros DNS"
  type        = number
  default     = 30
}


variable "private_ip_webserver" {
  default = "10.0.1.50"
}

variable "private_ip_monitoring" {
  default = "10.0.1.51"
}