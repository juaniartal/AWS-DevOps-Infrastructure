output "ec2_runner_ip" {
  value = aws_instance.runner.public_ip
}
