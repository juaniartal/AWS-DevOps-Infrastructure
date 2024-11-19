resource "aws_network_interface" "monitored_eni" {
  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnet_id
  security_groups = [aws_security_group.web_sg.id]
  private_ips     = [var.private_ip_webserver]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ENI-Monitored" },
    local.tags
  )
}


resource "aws_network_interface" "monitoring_eni" {
  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnet_id
  security_groups = [aws_security_group.monitoring_sg.id]
  private_ips     = [var.private_ip_monitoring]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ENI-Monitoring" },
    local.tags
  )
}