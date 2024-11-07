# 00-VPC - AWS VPC Deployment

This folder contains Terraform configuration code to deploy a **VPC (Virtual Private Cloud)** with both public and private subnets, along with necessary resources to support secure and organized network management in AWS.

## Features

- **VPC**: Creates a VPC to serve as the primary network for the infrastructure.
- **Public Subnets**: Configured to host resources accessible from the internet.
- **Private Subnets**: Designed for resources that require restricted, internal access only.
- **Additional Resources**: Includes essential components like Internet Gateway, NAT Gateway, and route tables, enabling secure and efficient communication between resources.

## Purpose

This VPC setup is designed to be used as a base network layer for applications and other AWS services. It allows for organizing resources securely within private and public subnets, and it can be referenced later via `data` blocks in other Terraform modules to ensure a cohesive architecture across the infrastructure.

## Usage

1. **Install Dependencies**: Ensure [Terraform](https://www.terraform.io/) is installed on your system.
2. **Initialize and Apply**:
   ```bash
   terraform init
   terraform apply
