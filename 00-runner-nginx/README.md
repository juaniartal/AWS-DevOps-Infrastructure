# EC2 Runner for Pipeline

This project sets up an **EC2 instance** in AWS to function as a **runner** for executing a CI/CD pipeline in a repository. The EC2 instance will be configured to interact with the pipeline, automate tasks, and facilitate the deployment of applications or services.

## Description

The EC2 instance will be used to run processes in the CI/CD pipeline, automating tasks such as building, testing, deploying, and monitoring applications.

### Project Components

1. **EC2 Instance**: An EC2 instance configured as a runner for executing the pipeline.
2. **CI/CD Pipeline**: The pipeline is located in a Git repository and is set up to execute tasks automatically whenever there are changes in the code or repository.
3. **Required Tools**: The EC2 instance will be configured with the necessary tools to run the pipeline, such as Docker, Terraform, AWS CLI, and any other tools required by the pipeline.

### Prerequisites

- **AWS Account**: To create and configure the EC2 instance.
- **Git Repository**: The repository where the pipeline and source code reside.
- **IAM Roles**: Necessary roles for the EC2 instance to interact with other AWS services, such as ECR, S3, or any other services involved in the pipeline.

### Implementation Steps

1. **Set Up the EC2 Instance**:
    - Create an EC2 instance with an appropriate **AMI** (e.g., Ubuntu or Amazon Linux).
    - Ensure that the EC2 instance has adequate resources (e.g., **t2.micro** or larger, depending on your pipeline's size).
    - Make sure the EC2 instance has an appropriate IAM role to execute the pipeline and access other AWS resources (e.g., permissions for S3, ECR, etc.).

2. **Install Required Tools**:
    - Install **Docker**: To run application containers.
    - Install **Terraform**: If the pipeline includes Infrastructure as Code configurations.
    - Install **AWS CLI**: To interact with AWS from the EC2 instance.
    
    Example installation commands for Ubuntu:
    ```bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo apt-get install -y terraform
    sudo apt-get install -y awscli
    ```

3. **Configure the Pipeline**:
    - Ensure that the repository contains the necessary pipeline configuration files (e.g., `.gitlab-ci.yml`, `bitbucket-pipelines.yml`, or similar for your platform).
    - Make sure the EC2 runner has access to the repository, either via SSH keys or HTTPS.
    
4. **Running the Pipeline**:
    - The EC2 instance will act as a runner, executing tasks defined in the pipeline.
    - You can trigger the pipeline manually or automatically based on commits or pull requests to the repository.

### Additional Notes

- The EC2 instance can be scaled vertically or horizontally based on the load of the pipeline.
- It is recommended to use **Elastic IP** for persistent access to the EC2 instance.
- Ensure proper security measures are in place, such as using **security groups** and configuring **IAM roles** with the least privilege principle.

### Tags

- **ec2**
- **ci/cd**
- **aws**
- **terraform**
- **docker**

