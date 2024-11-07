
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "clarin-dev-db-subnet-group"
   subnet_ids = [
    data.terraform_remote_state.vpc.outputs.public_subnet_id,
    data.terraform_remote_state.vpc.outputs.public_subnet_b
  ]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-db-subnet-group" },
    local.tags
  )
}

resource "aws_db_instance" "mysql_db" {
  db_name = "test"
  allocated_storage      = var.db_instance_config.allocated_storage
  storage_type           = var.db_instance_config.storage_type
  engine                 = var.db_instance_config.engine
  engine_version         = var.db_instance_config.engine_version
  instance_class         = var.db_instance_config.instance_class
  username               = var.db_username
  password               = aws_ssm_parameter.db_password.value  
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window


  deletion_protection     = false  
  skip_final_snapshot     = true   

  tags = merge(
    { Name = "${var.customer}-${var.environment}-mysql-db" },
    local.tags
  )
}