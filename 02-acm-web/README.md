# 01-ACM - AWS ACM Certificates Creation

This folder contains Terraform configuration to create and manage **SSL/TLS certificates** using **AWS Certificate Manager (ACM)**. ACM simplifies the process of provisioning, managing, and deploying SSL/TLS certificates for use with AWS services, ensuring secure connections for your applications.

Additionally, it provisions two **EC2 instance** running a **web server** (Apache or Nginx) and automatically applies the generated ACM certificate to secure the website hosted on the EC2 instance.

## Features

- **ACM Certificates**: Automate the creation of SSL/TLS certificates using ACM, which can be used for securing your domain names and AWS resources.
- **Domain Validation**: The configuration supports domain validation to prove ownership of your domain name.
- **Automatic Renewal**: ACM automatically renews certificates before expiration, eliminating the need for manual intervention.
- **Integration with AWS Services**: ACM certificates can be used with services like ELB, CloudFront, and API Gateway to enable secure HTTPS communication.
- **EC2 with Web Server**: Deploy an EC2 instance with a web server (Apache or Nginx) and configure it to use the ACM SSL/TLS certificate for secure HTTPS communication.
- **SSL/TLS for EC2**: The EC2 instance hosts a website and automatically configures the SSL certificate to serve content securely via HTTPS.

## Purpose

This setup simplifies the process of obtaining and managing SSL certificates using AWS Certificate Manager, and it also automates the deployment of a web server on an EC2 instance. The web server is configured with the ACM SSL certificate, ensuring secure communication with users over HTTPS.

## Usage

1. **Install Dependencies**: Ensure [Terraform](https://www.terraform.io/) is installed on your system.
2. **Initialize and Apply**:
   ```bash
   terraform init
   terraform apply