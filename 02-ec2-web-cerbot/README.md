# 01-Certbot - EC2 with Apache and SSL Certificate

This folder contains Terraform configuration code to create an **EC2 instance** running **Apache HTTP Server**, along with the automated installation and configuration of an **SSL/TLS certificate** using **Certbot**. The certificate is automatically applied to the Apache web server, ensuring secure HTTPS connections for your website.

## Features

- **EC2 Instance with Apache**: Deploy an EC2 instance with Apache HTTP Server installed, ready to serve web traffic.
- **Certbot for SSL/TLS**: Automatically install and configure Certbot on the EC2 instance to generate a free SSL certificate from Let's Encrypt.
- **Apache SSL Configuration**: Configure Apache to serve your website over HTTPS, ensuring encrypted communication.
- **Automated SSL Renewal**: Set up Certbot's automatic renewal process for SSL certificates, ensuring your HTTPS connection remains secure without manual intervention.

## Purpose

This setup automates the process of deploying an EC2 instance with Apache, securing the web server with an SSL certificate, and ensuring that traffic between the server and clients is encrypted using HTTPS. It's ideal for serving websites securely with minimal configuration.

## Usage

1. **Install Dependencies**: Ensure [Terraform](https://www.terraform.io/) is installed on your system.
2. **Initialize and Apply**:
   ```bash
   terraform init
   terraform apply