resource "aws_instance" "web_server" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = aws_key_pair.ec2_key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name
  network_interface {
    network_interface_id = aws_network_interface.web_eni.id
    device_index         = 0
  }
  user_data = templatefile("scripts/install_apache_certbot.sh", {
    domain_name_dns = var.name_dns_ec2
    domain_name     = var.domain_name
    private_ip      = "${aws_network_interface.web_eni.private_ip}"
  })

  tags = merge(
    { Name = "${local.app_name_dashed}-WEB-Server" },
  local.tags)
  depends_on = [aws_route53_record.nlb_dns]
}



resource "aws_network_interface" "web_eni" {
  subnet_id       = data.terraform_remote_state.vpc.outputs.private_subnet_id
  security_groups = [aws_security_group.web_sg.id]
  private_ips     = ["${var.private_ip}"]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ENI-ec2" },
    local.tags
  )
}
