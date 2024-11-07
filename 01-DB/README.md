# 00-Database with Bastion - AWS RDS Setup with Bastion Host

This folder contains Terraform configuration code to deploy an **RDS (Relational Database Service)** instance along with a **Bastion Host** to securely access the database. The Bastion Host serves as an intermediary server that allows SSH access to the database instances in a private subnet, improving security and minimizing direct access to the database.

## Features

- **RDS Instance**: Deploy a secure relational database instance (e.g., MySQL, PostgreSQL, etc.) in a private subnet within your VPC.
- **Bastion Host**: Deploy a Bastion Host in a public subnet to provide SSH access to the database instances.
- **Security Group Configuration**: Configure security groups to restrict access to the RDS instance only through the Bastion Host, ensuring controlled and secure database access.
- **Private Subnet**: The RDS instance will reside in a private subnet, further isolating it from direct internet access.

## Purpose

This setup provides a secure environment to manage relational databases while maintaining best practices for database access. The Bastion Host acts as a jump server, ensuring that the database instance is not directly exposed to the public internet, while still allowing authorized access through the Bastion.

## Usage

1. **Install Dependencies**: Ensure [Terraform](https://www.terraform.io/) is installed on your system.
2. **Initialize and Apply**:
   ```bash
   terraform init
   terraform apply
