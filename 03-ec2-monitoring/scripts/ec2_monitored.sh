#!/bin/bash
# Actualizar el sistema
sudo dnf update -y

# Instalar Docker
sudo dnf install -y docker

# Iniciar y habilitar Docker
sudo systemctl start docker
sudo systemctl enable docker

sudo dnf install -y libxcrypt-compat

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker ec2-user

sudo dnf install -y nginx httpd-tools

sudo systemctl start nginx
sudo systemctl enable nginx


sudo mkdir -p /etc/nginx/pass
sudo mkdir -p /var/www/html/
mkdir -p /home/ec2-user/telegraf

echo 'mysecurepassword' | sudo htpasswd -c -i /etc/nginx/pass/htpasswd.key admin

echo "<html><body><h1>LA CAFETERIA DE PIPO COMEBACK</h1></body></html>" | sudo tee /var/www/html/index.html

cat <<EOT > /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name _;

    root /var/www/html;

    auth_basic "Area Restringida";
    auth_basic_user_file /etc/nginx/pass/htpasswd.key;

    location / {
        try_files \$uri \$uri/ =404;
    }
}

server {
    listen 8090;
    server_name _;

    location /health {
        access_log off;
        add_header 'Content-Type' 'application/json';
        return 200 '{"Status": "Healthy"}';
    }
}
EOT

sudo systemctl restart nginx

mkdir -p /home/ec2-user/node_exporter

cat <<EOT > /home/ec2-user/node_exporter/docker-compose.yaml
version: '3'

services:
  node_exporter:
    image: quay.io/prometheus/node-exporter:latest
    container_name: node_exporter
    command:
      - '--path.rootfs=/host'
    network_mode: host
    pid: host
    restart: unless-stopped
    volumes:
      - '/:/host:ro,rslave'
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

[[inputs.ping]]
  urls = ["google.com"]
  count = 3
  interval = "60s"
EOT

cat <<EOT > /home/ec2-user/telegraf/docker-compose.yaml
version: '3'

services:
  telegraf:
    image: telegraf:latest
    container_name: telegraf
    volumes:
      - /home/ec2-user/telegraf/telegraf.conf:/etc/telegraf/telegraf.conf:ro
    ports:
      - "9273:9273"
    restart: unless-stopped
EOT

sudo chown -R ec2-user:ec2-user /home/ec2-user/node_exporter/docker-compose.yaml  /home/ec2-user/telegraf

cd /home/ec2-user/node_exporter
docker-compose up -d

cd /home/ec2-user/telegraf
docker-compose up -d