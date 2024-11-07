variable "sso_profile" {}
variable "region" {}
variable "customer" {}

variable "environment" {}
variable "project" {}



variable "db_name" {}

variable "db_username" {}

variable "backup_retention_period" {}

variable "backup_window" {}

variable "maintenance_window" {}
variable "ami" {}
variable "instance_type" {}

variable "db_instance_config" {
  type = object({
    allocated_storage      = number
    storage_type           = string
    engine                 = string
    engine_version         = string
    instance_class         = string
  })
}
