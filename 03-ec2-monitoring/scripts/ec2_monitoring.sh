#!/bin/bash

sudo dnf update -y

sudo dnf install -y docker

sudo systemctl start docker
sudo systemctl enable docker

sudo dnf install -y libxcrypt-compat

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker ec2-user

mkdir -p /home/ec2-user/prometheus
mkdir -p /home/ec2-user/grafana/provisioning/dashboards
mkdir -p /home/ec2-user/grafana/provisioning/datasources
mkdir -p /home/ec2-user/telegraf


cat <<EOT > /home/ec2-user/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['${monitored_ip}:9100']

  - job_name: 'telegraf'
    static_configs:
      - targets: ['${monitored_ip}:9273','${monitoring_ip}:9273']
EOT

cat <<EOT > /home/ec2-user/grafana/provisioning/datasources/datasource.yaml
apiVersion: 1

datasources:
- name: Prometheus
  type: prometheus
  uid: prometheus
  url: http://prometheus:9090
  isDefault: true
  access: proxy
  editable: true
EOT

cat <<EOT > /home/ec2-user/grafana/provisioning/dashboards/dashboard.yaml
apiVersion: 1
providers:
- name: 'default'
  orgId: 1
  folder: ''
  type: 'file'
  disableDeletion: false
  updateIntervalSeconds: 10
  options:
    path: /etc/grafana/provisioning/dashboards
EOT

wget -O /home/ec2-user/grafana/provisioning/dashboards/node_exporter_full.json https://grafana.com/api/dashboards/1860/revisions/25/download


cat <<EOT > /home/ec2-user/docker-compose.yaml
version: '3'

services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - /home/ec2-user/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin  
    volumes:
      - /home/ec2-user/grafana/provisioning/datasources/datasource.yaml:/etc/grafana/provisioning/datasources/datasource.yaml
      - /home/ec2-user/grafana/provisioning/dashboards/dashboard.yaml:/etc/grafana/provisioning/dashboards/dashboard.yaml
      - /home/ec2-user/grafana/provisioning/dashboards/node_exporter_full.json:/etc/grafana/provisioning/dashboards/node_exporter_full.json

  telegraf:
    image: telegraf:latest
    container_name: telegraf
    volumes:
      - /home/ec2-user/telegraf/telegraf.conf:/etc/telegraf/telegraf.conf:ro
    ports:
      - "9273:9273"
    restart: unless-stopped
EOT

cat <<EOT > /home/ec2-user/telegraf/telegraf.conf
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  precision = ""
  hostname = ""
  omit_hostname = false

[[outputs.prometheus_client]]
  listen = ":9273"

[[inputs.http_response]]
  urls = ["http://${monitored_ip}:8090/health"]
  response_timeout = "5s"
  method = "GET"
  follow_redirects = true

[[inputs.ping]]
  urls = ["${monitored_ip}"]
  count = 3
  interval = "60s"
EOT



sudo chown -R ec2-user:ec2-user /home/ec2-user/prometheus /home/ec2-user/docker-compose.yaml /home/ec2-user/grafana /home/ec2-user/telegraf

cd /home/ec2-user/
docker-compose up -d
