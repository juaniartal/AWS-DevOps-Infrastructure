#!/bin/bash
sudo yum update -y

sudo dnf install -y nginx httpd-tools

sudo systemctl start nginx
sudo systemctl enable nginx


sudo mkdir -p /etc/nginx/pass
sudo mkdir -p /var/www/html/
echo 'mysecurepassword' | sudo htpasswd -c -i /etc/nginx/pass/htpasswd.key admin

cat <<EOT > /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name _;

    root /var/www/html;

    # auth_basic "Area Restringida";
    # auth_basic_user_file /etc/nginx/pass/htpasswd.key;

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

echo "<html><body><h1>WEB B</h1></body></html>" | sudo tee /var/www/html/index.html


sudo systemctl restart nginx