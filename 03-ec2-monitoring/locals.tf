# locals.tf
locals {
  app_name_dashed = "${var.customer}-${var.environment}"
  project         = var.project
  tags = {
    application_name = local.app_name_dashed
    environment      = var.environment
    customer         = var.customer
    team             = "devops"
    project          = local.project
    created_by       = "terraform" 
    code_repo        = "terraform-juan-a"
  }
}