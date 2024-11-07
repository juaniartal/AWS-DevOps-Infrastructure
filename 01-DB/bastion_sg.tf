resource "aws_security_group" "bastion_sg" {
  name_prefix = "${var.customer}-${var.environment}-bastion-sg"
  description = "Security Group para la instancia bastion"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = "${var.customer}-${var.environment}-bastion-sg" },
    local.tags
  )
}