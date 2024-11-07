#!/bin/bash
sudo yum update -y
sudo yum install -y cronie httpd mod_ssl certbot python3-certbot-apache

sudo systemctl start httpd
sudo systemctl enable httpd

sudo mkdir -p /var/www/${domain_name}

echo '{ "status": "Healthy" }' | sudo tee /var/www/${domain_name}/health
sudo chmod 644 /var/www/${domain_name}/health

cat <<EOT | sudo tee /etc/httpd/conf.d/health-check.conf
Alias "/health" "/var/www/${domain_name}/health"
<Directory "/var/www/${domain_name}">
    Require all granted
</Directory>
<Files "health">
    ForceType application/json
</Files>
EOT

cat <<EOF | sudo tee /etc/httpd/conf.d/vhost.conf
<VirtualHost *:80>
    ServerAdmin jartal@kopiustech.com
    ServerName webservernlb.academybox1.academy.kopiustech.com
    ServerAlias ${private_ip}
    DocumentRoot /var/www/${domain_name}
    <Directory /var/www/${domain_name}>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

echo "<html><h1>Test de mi dominio: ${domain_name}</h1></html>" | sudo tee /var/www/${domain_name}/index.html
sudo chmod -R 775 /var/www/${domain_name}

sudo systemctl restart httpd

sudo certbot --apache -d webservernlb.academybox1.academy.kopiustech.com --non-interactive --agree-tos -m jartal@kopiustech.com

sudo echo "0 0 1 */2 * /usr/bin/certbot renew --quiet" | crontab -



sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
