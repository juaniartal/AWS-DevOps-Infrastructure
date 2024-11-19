resource "aws_instance" "load_tester" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_id
  security_groups             = [aws_security_group.load_test_sg.id]
  key_name                    = aws_key_pair.ec2_key_pair.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_instance_profile.name


  user_data = templatefile("scripts/load_test.sh", {
    public_ip     = var.private_ip_webserver
    monitoring_ip = var.private_ip_monitoring
    dnsname       = var.dnsname
  })
  depends_on = [aws_instance.monitoring_server, aws_instance.monitoring_server]
  tags = merge(
    { Name = "${var.customer}-${var.environment}-Load-Tester" },
  local.tags)
}
