#!/bin/bash

# onlyoffice-mysql-server
sudo docker run --net onlyoffice -i -t -d --restart=always --name onlyoffice-mysql-server \
	-v /app/onlyoffice/mysql/conf.d:/etc/mysql/conf.d \
	-v /app/onlyoffice/mysql/initdb:/docker-entrypoint-initdb.d \
	-v /app/onlyoffice/mysql/data:/var/lib/mysql \
	-v /app/onlyoffice/mysql/logs:/var/log/mysql \
	-e MYSQL_ROOT_PASSWORD=my-secret-pw \
	-e MYSQL_DATABASE=onlyoffice \
	mysql:5.7

# onlyoffice-control-panel
sudo docker run --net onlyoffice -i -t -d --restart=always --name onlyoffice-control-panel \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /app/onlyoffice/CommunityServer/data:/app/onlyoffice/CommunityServer/data \
	-v /app/onlyoffice/ControlPanel/data:/var/www/onlyoffice/Data \
	-v /app/onlyoffice/ControlPanel/logs:/var/log/onlyoffice \
	onlyoffice/controlpanel

# onlyoffice-document-server
sudo docker run --net onlyoffice -i -t -d --restart=always --name onlyoffice-document-server \
	-v /app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice  \
	-v /app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data \
	-v /app/onlyoffice/DocumentServer/lib:/var/lib/onlyoffice \
	-v /app/onlyoffice/DocumentServer/db:/var/lib/postgresql \
	onlyoffice/documentserver

# onlyoffice-community-server
sudo docker run --net onlyoffice -i -t -d --privileged --restart=always --name onlyoffice-community-server \
	-p 8080:80 -p 8443:443 -p 5222:5222 \
	-e MYSQL_SERVER_ROOT_PASSWORD=my-secret-pw \
	-e MYSQL_SERVER_DB_NAME=onlyoffice \
	-e MYSQL_SERVER_HOST=onlyoffice-mysql-server \
	-e MYSQL_SERVER_USER=onlyoffice_user \
	-e MYSQL_SERVER_PASS=onlyoffice_pass \
	-e CONTROL_PANEL_PORT_80_TCP=80 \
	-e CONTROL_PANEL_PORT_80_TCP_ADDR=onlyoffice-control-panel \
	-e DOCUMENT_SERVER_PORT_80_TCP_ADDR=onlyoffice-document-server \
	-v /app/onlyoffice/CommunityServer/data:/var/www/onlyoffice/Data \
	-v /app/onlyoffice/CommunityServer/logs:/var/log/onlyoffice \
	-v /app/onlyoffice/CommunityServer/letsencrypt:/etc/letsencrypt \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	onlyoffice/communityserver

