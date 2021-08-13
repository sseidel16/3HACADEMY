#!/bin/bash

# create and copy necessary data directories
sudo mkdir /app
sudo chmod +777 /app
cp -rf ./app

# onlyoffice-mysql-server
sudo docker run --net onlyoffice -i -t -d --restart=always --name onlyoffice-mysql-server \
	-v /app/onlyoffice/mysql/conf.d:/etc/mysql/conf.d \
	-v /app/onlyoffice/mysql/data:/var/lib/mysql \
	-v /app/onlyoffice/mysql/initdb:/docker-entrypoint-initdb.d \
	-e MYSQL_ROOT_PASSWORD=my-secret-pw \
	-e MYSQL_DATABASE=onlyoffice \
	mysql:5.7

# onlyoffice-community-server
sudo docker run --net onlyoffice -i -t -d --privileged --restart=always --name onlyoffice-community-server \
	-p 8080:80 -p 8443:443 -p 5222:5222 \
	-e MYSQL_SERVER_ROOT_PASSWORD=my-secret-pw \
	-e MYSQL_SERVER_DB_NAME=onlyoffice \
	-e MYSQL_SERVER_HOST=onlyoffice-mysql-server \
	-e MYSQL_SERVER_USER=onlyoffice_user \
	-e MYSQL_SERVER_PASS=onlyoffice_pass \
	-v /app/onlyoffice/CommunityServer/data:/var/www/onlyoffice/Data \
	-v /app/onlyoffice/CommunityServer/logs:/var/log/onlyoffice \
	-v /app/onlyoffice/CommunityServer/letsencrypt:/etc/letsencrypt \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	onlyoffice/communityserver




