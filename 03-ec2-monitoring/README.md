# EC2 Monitoring with Grafana, Prometheus, NGINX, and Docker

This Terraform configuration deploys two EC2 instances in AWS, where one instance is used to monitor the other using **Grafana** and **Prometheus**. The setup includes monitoring of an **NGINX** web server. Additionally, **Docker** is used to run Prometheus and Grafana configuration files (`prometheus.yml` and `datasource.yaml`).

## Overview

The project creates:

- **EC2 Instance 1**: Runs **NGINX** to simulate a web server.
- **EC2 Instance 2**: Runs **Prometheus** and **Grafana** inside Docker containers to monitor the **NGINX** web server from EC2 Instance 1.

### Key Components

1. **NGINX Web Server**: The first EC2 instance runs an NGINX web server to serve static content.
2. **Prometheus**: Installed on the second EC2 instance inside a Docker container, Prometheus collects and stores metrics from the NGINX server.
3. **Grafana**: Installed on the second EC2 instance inside a Docker container, Grafana is used to visualize the metrics collected by Prometheus, providing insights into the performance of the NGINX server.
4. **Docker**: Docker is used to run **Prometheus** and **Grafana** with their respective configuration files (`prometheus.yml` for Prometheus and `datasource.yaml` for Grafana).

### Features

- **Real-time Monitoring**: Grafana dashboards are set up to visualize NGINX metrics in real-time.
- **Prometheus Scraping**: Prometheus scrapes NGINX metrics exposed on a defined endpoint.
- **Dockerized Configuration**: Both Prometheus and Grafana are containerized using Docker, allowing for more flexibility and ease of deployment.
- **Automated Setup**: The configuration is automated using Terraform to simplify deployment.

## Requirements

- **AWS Account**: To deploy resources to AWS.
- **Terraform**: Terraform is used to deploy the infrastructure.
- **Docker**: Docker is used to run Prometheus and Grafana containers.
- **EC2 Instances**: Two EC2 instances with appropriate IAM roles and security groups.
- **Security Groups**: Ensure the necessary ports are open for HTTP (NGINX), Prometheus, and Grafana.

## Deployment Steps

1. **Set up your AWS credentials**: Ensure that your AWS credentials are properly configured in your environment.
2. **Clone the repository**: Clone the repository to your local machine or environment.
3. **Modify variables**: Adjust any variables in `variables.tf` according to your preferences, including instance types, region, etc.
4. **Initialize Terraform**: Run `terraform init` to initialize the Terraform working directory.
5. **Apply the configuration**: Run `terraform apply` to create the resources in your AWS account.
6. **Access Grafana**: After the resources are deployed, access Grafana by navigating to the public IP of EC2 Instance 2 on port 3000. Use the default credentials to log in (typically `admin`/`admin`).

### Docker Setup for Prometheus and Grafana

Prometheus and Grafana are configured through Docker containers on **EC2 Instance 2**. The configuration files (`prometheus.yml` and `datasource.yaml`) are mounted as volumes into the Docker containers. These configuration files define how Prometheus collects data and how Grafana connects to Prometheus as a data source.

1. **Prometheus Docker**: Runs Prometheus with `prometheus.yml` configuration to scrape metrics from the NGINX server.
2. **Grafana Docker**: Runs Grafana with `datasource.yaml` to define the Prometheus data source and visualize the metrics.

## Monitoring

Once the EC2 instances are up and running:

- The NGINX server on **EC2 Instance 1** can be accessed via its public IP.
- Prometheus on **EC2 Instance 2** scrapes metrics from the NGINX server.
- Grafana visualizes the data collected by Prometheus on customizable dashboards.

## Example Use Case

This setup can be used for:

- **Web server monitoring**: Monitoring NGINX performance and availability.
- **Infrastructure observability**: Monitoring EC2 instance health and performance metrics.
- **Learning purposes**: This setup can serve as a learning exercise for understanding monitoring stacks with Prometheus, Grafana, and Docker.

## Resources

- **NGINX**: [https://nginx.org/](https://nginx.org/)
- **Prometheus**: [https://prometheus.io/](https://prometheus.io/)
- **Grafana**: [https://grafana.com/](https://grafana.com/)
- **Docker**: [https://www.docker.com/](https://www.docker.com/)

## License

This project is licensed under the MIT License.


