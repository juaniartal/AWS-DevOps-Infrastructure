resource "aws_instance" "ec2_monitored" {
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.ec2_key_pair.key_name
  availability_zone = "${var.region}a"

  network_interface {
    network_interface_id = aws_network_interface.monitored_eni.id
    device_index         = 0
  }

  user_data = templatefile("scripts/ec2_monitored.sh", {
  })
  

  tags = merge(
    { Name = "${var.customer}-${var.environment}-EC2-Monitored" },
    local.tags
  )
}



resource "aws_instance" "ec2_monitoring" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2_key_pair.key_name
  availability_zone           = "${var.region}a"

  network_interface {
    network_interface_id = aws_network_interface.monitoring_eni.id
    device_index         = 0
  }

  user_data = templatefile("scripts/ec2_monitoring.sh", {
    monitored_ip = var.private_ip_monitored
    monitoring_ip = var.private_ip_monitoring
  })

  depends_on = [
    aws_instance.ec2_monitored
  ]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-EC2-Monitoring" },
    local.tags
  )
}
