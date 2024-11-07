# Base Line Deployment

## Description

This repository contains infrastructure code that deploys a Nexus server on AWS using Terraform. The server is launched as an EC2 instance and configured to run Docker with Nexus installed. Additionally, it includes a Helm chart for Kubernetes deployment.

The infrastructure will create the following resources:
- An EC2 instance with Docker installed.
- A Nexus container running on the EC2 instance.
- A volume for Nexus data persistence.
- A public IP address for the EC2 instance.

### Terraform Script for Nexus EC2 Instance

```hcl
resource "aws_instance" "nexus" {
  ami                         = var.instance.ami
  instance_type               = var.instance.instance_type
  key_name                    = aws_key_pair.ssh_key_nexus.id
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.nexus.id]
  associate_public_ip_address = var.instance.associate_public_ip_address
  
  root_block_device {
    delete_on_termination = true
    volume_size           = var.instance.volume_size
    volume_type           = var.instance.volume_type
    iops                  = var.instance.iops
    encrypted             = var.instance.encrypted
  }

  user_data = <<-EOF
  #! /bin/bash
  yum update -y
  yum install docker -y
  systemctl start docker
  systemctl enable docker
  usermod -aG docker ec2-user
  newgrp docker
  docker volume create --name nexus-data
  docker run --restart always -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
  EOF

  tags = merge(
    { Name = "${var.customer}-${var.environment}-NEXUS-SERVER" },
    local.tags
  )
}
