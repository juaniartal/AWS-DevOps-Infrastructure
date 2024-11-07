resource "aws_network_interface" "eni_ec2_runner" {
  security_groups = [aws_security_group.sg_ec2_runner.id]
  subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnet_id
  private_ips     = [var.private_ip_eni]

  tags = merge({ Name = "${var.customer}-${var.project}-${var.environment}-ENI-EC2-RUNNER" }, local.tags)
}
