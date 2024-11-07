resource "aws_instance" "web_server_a" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnet_id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.ec2_key_pair.key_name

  associate_public_ip_address = true

  user_data = templatefile("scripts/web_a.sh", {
  })

  tags = merge(
    { Name = "${local.app_name_dashed}-WEB-A" },
  local.tags)
}

resource "aws_eip" "eip_web_server_a" {
  instance = aws_instance.web_server_a.id
}

resource "aws_instance" "web_server_b" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnet_b
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.ec2_key_pair.key_name

  associate_public_ip_address = true

  user_data = templatefile("scripts/web_b.sh", {
  })


  tags = merge(
    { Name = "${local.app_name_dashed}-WEB-B" },
  local.tags)
}

resource "aws_eip" "eip_web_server_b" {
  instance = aws_instance.web_server_b.id
}