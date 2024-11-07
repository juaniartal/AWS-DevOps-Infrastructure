
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  provider   = aws.virginia
  key_name   = "${var.customer}-${var.environment}-ec2-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-key" },
    local.tags
  )
}


resource "aws_ssm_parameter" "ec2_private_key" {
  provider = aws.virginia
  name     = "${var.customer}-${var.environment}-ec2-ssh-private-key"
  type     = "SecureString"
  value    = tls_private_key.ssh_key.private_key_pem

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-private-key" },
    local.tags
  )
}

resource "aws_ssm_parameter" "ec2_public_key" {
  provider = aws.virginia
  name     = "${var.customer}-${var.environment}-ec2-ssh-public-key"
  type     = "String"
  value    = tls_private_key.ssh_key.public_key_openssh

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-public-key" },
    local.tags
  )
}


resource "tls_private_key" "ssh_key_oregon" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair_oregon" {
  provider   = aws.oregon
  key_name   = "${var.customer}-${var.environment}-ec2-ssh-key-oregon"
  public_key = tls_private_key.ssh_key_oregon.public_key_openssh

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-key-oregon" },
    local.tags
  )
}

resource "aws_ssm_parameter" "ec2_private_key_oregon" {
  provider = aws.oregon
  name     = "${var.customer}-${var.environment}-ec2-ssh-private-key-oregon"
  type     = "SecureString"
  value    = tls_private_key.ssh_key_oregon.private_key_pem

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-private-key-oregon" },
    local.tags
  )
}

resource "aws_ssm_parameter" "ec2_public_key_oregon" {
  provider = aws.oregon
  name     = "${var.customer}-${var.environment}-ec2-ssh-public-key-oregon"
  type     = "String"
  value    = tls_private_key.ssh_key_oregon.public_key_openssh

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-public-key-oregon" },
    local.tags
  )
}


resource "tls_private_key" "ssh_key_ohio" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair_ohio" {
  provider   = aws.ohio
  key_name   = "${var.customer}-${var.environment}-ec2-ssh-key-ohio"
  public_key = tls_private_key.ssh_key_ohio.public_key_openssh

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-key-ohio" },
    local.tags
  )
}

resource "aws_ssm_parameter" "ec2_private_key_ohio" {
  provider = aws.ohio
  name     = "${var.customer}-${var.environment}-ec2-ssh-private-key-ohio"
  type     = "SecureString"
  value    = tls_private_key.ssh_key_ohio.private_key_pem

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-private-key-ohio" },
    local.tags
  )
}

resource "aws_ssm_parameter" "ec2_public_key_ohio" {
  provider = aws.ohio
  name     = "${var.customer}-${var.environment}-ec2-ssh-public-key-ohio"
  type     = "String"
  value    = tls_private_key.ssh_key_ohio.public_key_openssh

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ec2-ssh-public-key-ohio" },
    local.tags
  )
}