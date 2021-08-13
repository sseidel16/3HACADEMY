#!/bin/bash

sudo docker container stop onlyoffice-mysql-server
sudo docker container rm onlyoffice-mysql-server

sudo docker container stop onlyoffice-community-server
sudo docker container rm onlyoffice-community-server


