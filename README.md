# Backend with AWS - S3, DynamoDB, IAM

This repository contains the infrastructure and configuration for deploying a backend using AWS and Terraform. The project provisions and configures the following AWS resources:

- **S3 Bucket**: for storing static files and data.
- **DynamoDB**: for managing schema-less data, ideal for applications needing low latency and high availability.
- **IAM User**: a user with specific permissions to securely interact with the AWS resources defined in the backend.

## Purpose
The purpose of this backend is to provide a flexible and scalable foundation for applications that require file storage, NoSQL database support, and secure AWS resource access.

## Project Context
This project is part of the **DevOps Academy at Kopius Inc.** and is designed to simulate a production environment. Some resources use names like "clarin" as examples for a production-like setting.

## Getting Started

To get started, clone this repository and follow the steps below:

1. **Install Dependencies**: Ensure you have [Terraform](https://www.terraform.io/) and [AWS CLI](https://aws.amazon.com/cli/) installed.
2. **Configure AWS CLI**: Set up your AWS CLI with appropriate credentials.
3. **Initialize and Apply Terraform**:
   ```bash
   terraform init
   terraform apply
