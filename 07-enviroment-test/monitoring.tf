resource "aws_instance" "monitoring_server" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = aws_key_pair.ec2_key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name

  user_data = templatefile("scripts/monitoring_agent.sh", {
    monitored_ip      = var.private_ip_webserver
    monitoring_ip     = var.private_ip_monitoring
    dnsname           = var.dnsname
    dashboards_bucket = "${local.dashboards_bucket}"
  })
  network_interface {
    network_interface_id = aws_network_interface.monitoring_eni.id
    device_index         = 0
  }
  tags = merge(
    { Name = "${var.customer}-${var.environment}-Monitoring-Server" },
  local.tags)
  depends_on = [aws_instance.web_server]
}

