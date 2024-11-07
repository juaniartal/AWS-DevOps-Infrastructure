# AWS Infrastructure Projects

This repository contains multiple infrastructure projects, each organized in its own folder, built using AWS and Terraform. Each folder includes configurations for various AWS resources and setups designed to simulate a production environment. These resources and services enable secure, scalable, and monitored deployments.

## Infrastructure Components

The following AWS infrastructure components are configured across different folders:

- **Backend** 📂: Resources for back-end services and data storage.
- **EC2 Instances** 🖥️: Configurations for virtual machines hosting applications and services.
- **Load Balancer** ⚖️: Implements load balancing for managing traffic across multiple EC2 instances.
- **VPN** 🔒: Secure VPN setups to connect and secure private resources.
- **Network Load Balancer** 📶: High-performance load balancing at the network level.
- **Web Applications on EC2** 🌐: Web applications hosted on EC2, with monitoring set up via **Prometheus** 📊 and **Grafana** 📈 on a separate EC2 instance.
- **Nexus on EC2** 📦: A **Nexus** repository hosted on EC2 for managing and storing software artifacts.
- **Lambda Functions** 🧬: Serverless functions to handle specific tasks and processes.
- **Bitbucket Runners** 🏃‍♂️: EC2 runners configured for CI/CD tasks in **Bitbucket Pipelines**.
- **Database** 🗄️: Setup for databases (e.g., **RDS**) to support application data storage.
- **Bastion Module for SSM** 🛡️: Configurations for a bastion host that provides secure access via AWS Systems Manager (**SSM**).
- **DNS Certificates (Route 53)** 🌐🔒: DNS configurations with **Route 53**, including SSL/TLS certificate management.
- **Certbot for SSL Certification** 🔏: Uses **Certbot** for additional SSL certificate management.
- **VPC** 🌐: Custom VPCs for organizing and securing the network environment.
- **Docker Containers** 🐳: Containerized applications managed through **Docker**.
- **Kubernetes Clusters** ☸️: Deployments managed in Kubernetes clusters for scalability and orchestration.

## Project Context
This repository is part of the **DevOps Academy at Kopius Inc.** and is designed to simulate a production environment. Some resources use names like "clarin" as examples for a production-like setting.

## Getting Started

To start using the infrastructure modules in this repository, follow these steps:

1. **Install Dependencies**: Ensure you have [Terraform](https://www.terraform.io/) and [AWS CLI](https://aws.amazon.com/cli/) installed.
2. **Configure AWS CLI**: Set up your AWS CLI with appropriate credentials.
3. **Navigate to the Desired Folder**: Each folder represents a different infrastructure setup. Choose the one you need.
4. **Initialize and Apply Terraform**:
   ```bash
   terraform init
   terraform apply
