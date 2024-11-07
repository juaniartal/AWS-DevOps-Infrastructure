resource "random_password" "db_password" {
  length           = 16
  special          = false
}


resource "aws_ssm_parameter" "db_password" {
  name  = "${var.customer}-${var.environment}-db_password"
  type  = "SecureString"
  value = random_password.db_password.result

  tags = merge(
    { Name = "${var.customer}-${var.environment}-db-password" },
    local.tags
  )
}



module "key_pair" {
  source      = "../modules/key-pair-jumper"
  customer    = var.customer
  environment = var.environment
  tags        = local.tags
}