# Project: Webserver Infrastructure with Apache and Monitoring on AWS

This project deploys a complete AWS infrastructure using **Terraform**, including a web server with Apache, custom error pages, SSL/TLS certificates, metrics monitoring with Grafana, and load testing from an additional EC2 instance.

## Table of Contents
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Web Server Configuration](#web-server-configuration)
- [Monitoring and Logs](#monitoring-and-logs)
- [Load Testing](#load-testing)
- [Useful Commands](#useful-commands)

---

## Architecture

- **VPC:** 
  - 2 public subnets and 2 private subnets.
  - Proper routing and secure access configuration.

- **EC2 Instance for Webserver:**
  - Apache installed with support for metrics and logs.
  - Custom pages for errors (`404`) and under-construction notices.
  - SSL/TLS certificates with Certbot.

- **Monitoring:**
  - Grafana server with dashboards for metrics and logs.
  - Metrics agent (Prometheus).
  - Log agent (e.g., Fluent Bit).

- **Load Testing:**
  - Additional EC2 instance for generating load and errors.

---

## Features

1. **Web Server with Apache:**
   - Metrics available at `/metrics`.
   - Custom error pages (`404`) and default under-construction page.
   - Hides Apache server information.
   - Logs configured for `access` and `error`.

2. **SSL/TLS:**
   - Configured using **Certbot**.
   - Hosted zones managed with **Route 53**.

3. **Monitoring:**
   - **Grafana** for dashboards.
   - System metrics (CPU, RAM, Disk) and custom metrics from `/metrics`.
   - Log exploration using plugins (e.g., Loki).

4. **Load Testing:**
   - Script to generate 200 HTTP requests.
   - Script to simulate errors and overload conditions.

---

## Prerequisites

- AWS account with appropriate permissions.
- Terraform installed locally.

---

## Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo-name.git
   cd your-repo-name
