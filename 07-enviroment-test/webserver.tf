resource "aws_instance" "web_server" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = aws_key_pair.ec2_key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name


  user_data = templatefile("scripts/install_apache.sh", {
    domain_name   = var.domain_name
    public_ip     = var.private_ip_webserver
    monitoring_ip = var.private_ip_monitoring
    dnsname       = var.dnsname
  })

  network_interface {
    network_interface_id = aws_network_interface.monitored_eni.id
    device_index         = 0
  }
  tags = merge(
    { Name = "${var.customer}-${var.environment}-WEB-Server" },
  local.tags)
}
