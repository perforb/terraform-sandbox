#!/bin/sh

# for health check
# sudo yum install -y httpd
# sudo systemctl start httpd
# sudo systemctl enable httpd
# sudo cat << 'EOF' >> /var/www/html/index.html
# OK
# EOF

# docker
sudo amazon-linux-extras install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo mkdir /opt/docker

# launch phpMyAdmin
sudo cat << 'EOF' > /opt/docker/docker-compose.yml
version: "3"

services:
  myadmin:
    image: phpmyadmin/phpmyadmin:${pma_version}
    ports:
      - "8081:80"
    networks:
      - frontend
      - backend
    environment:
#      PMA_HOSTS: <mysql_host1>[,<mysql_host2>]
      PHP_UPLOAD_MAX_FILESIZE: "512M"
      PMA_ABSOLUTE_URI: http://${admin_host}/myadmin/
    restart: always

volumes:
  db_data:

networks:
  frontend:
  backend:
EOF
sudo docker-compose -f /opt/docker/docker-compose.yml up -d

# mysql 5.7
sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo yum-config-manager --disable mysql80-community
sudo yum-config-manager --enable mysql57-community
sudo yum install -y mysql-community-client

# mysql 8.0
# yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
# yum-config-manager --enable mysql80-community
# yum-config-manager --disable mysql57-community
# yum install -y mysql-community-client

# redis
sudo amazon-linux-extras install -y epel
sudo yum install -y redis