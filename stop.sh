#!/bin/bash

sudo docker container stop onlyoffice-community-server
sudo docker container rm onlyoffice-community-server

sudo docker container stop onlyoffice-document-server
sudo docker container rm onlyoffice-document-server

sudo docker container stop onlyoffice-control-panel
sudo docker container rm onlyoffice-control-panel

sudo docker container stop onlyoffice-mysql-server
sudo docker container rm onlyoffice-mysql-server


