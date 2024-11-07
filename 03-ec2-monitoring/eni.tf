# monitoring
resource "aws_network_interface" "monitoring_eni" {
  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnet_id
  security_groups = [aws_security_group.sg_public.id]
  private_ips = ["${var.private_ip_monitoring}"]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ENI-Monitoring" },
    local.tags
  )
}

#  monitored
resource "aws_network_interface" "monitored_eni" {
  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnet_id
  security_groups = [aws_security_group.sg_public.id]
  private_ips = ["${var.private_ip_monitored}"]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-ENI-Monitored" },
    local.tags
  )
}


