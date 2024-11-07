# 00-Route53 - AWS Route 53 Domain Setup

This folder contains Terraform configuration code to create a **Route 53** hosted zone and manage DNS records within it. This setup enables you to easily provision a domain and create various DNS records like A, CNAME, MX, etc., for use with your AWS infrastructure.

## Features

- **Create Hosted Zone**: Set up a new domain in AWS Route 53 to manage DNS records.
- **DNS Records Management**: Add, modify, or delete DNS records (e.g., A, CNAME, MX, etc.) for the domain created in the hosted zone.
- **Scalable & Flexible**: Easily manage DNS configurations for multiple subdomains and other infrastructure components.

## Purpose

This setup helps in automating the creation of a Route 53 hosted zone and managing domain records. It is ideal for creating a domain to connect your AWS resources (like EC2, S3, or load balancers) to custom domain names and manage routing traffic to various services.

## Usage

1. **Install Dependencies**: Ensure [Terraform](https://www.terraform.io/) is installed on your system.
2. **Initialize and Apply**:
   ```bash
   terraform init
   terraform apply
