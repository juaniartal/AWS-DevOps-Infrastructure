#### terraform variables

variable "environment" {}
variable "customer" {}
variable "region" {}
variable "sso_profile" {
  type = string
}
variable "project" {
  type = string
}

variable "email_to" {
  description = "Recipient's email address"
  type        = string
  default     = "juanignacio.artal@gmail.com"
}

variable "email_from" {
  description = "Sender's email address"
  type        = string
  default     = "jartal@kopiustech.com"
}