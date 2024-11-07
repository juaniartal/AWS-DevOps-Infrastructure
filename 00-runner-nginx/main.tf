resource "aws_instance" "runner" {
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.ec2_key_pair.key_name
  availability_zone = "${var.region}a"

  user_data = templatefile("scripts/runner.sh", {})

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.eni_ec2_runner.id
  }

  tags = merge({ Name = "${var.customer}-${var.project}-${var.environment}-EC2-RUNNER" }, local.tags)

}
