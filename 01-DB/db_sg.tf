resource "aws_security_group" "db_sg" {
  name        = "${var.customer}-${var.environment}-db-sg"
  description = "sg para la db"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = "${var.customer}-${var.environment}-db-sg" },
    local.tags
  )
}



resource "aws_eip" "bastion_eip" {
  
  tags = merge(
    { Name = "${var.customer}-${var.environment}-bastion-eip" },
    local.tags
  )
}