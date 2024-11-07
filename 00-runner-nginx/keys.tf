resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${var.customer}-${var.environment}-ec2-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-key" },
    local.tags
  )
}

resource "aws_ssm_parameter" "ec2_private_key" {
  name  = "${var.customer}-${var.environment}-ec2-ssh-private-key"
  type  = "SecureString"
  value = tls_private_key.ssh_key.private_key_pem

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-private-key" },
    local.tags
  )
}