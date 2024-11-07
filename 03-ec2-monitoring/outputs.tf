output "monitoring_instance_public_ip" {
  description = "IP MONITORING"
  value       = aws_instance.ec2_monitoring.public_ip
}


output "monitored_instance_public_ip" {
  description = "IP MONITORED"
  value       = aws_instance.ec2_monitored.public_ip
}
