#!/bin/bash

APP_DATA_DIR=/app

# create and copy necessary data directories
sudo mkdir ${APP_DATA_DIR}
sudo chmod +777 ${APP_DATA_DIR}
cp -rf ./app/* ${APP_DATA_DIR}

# give permissions for everything
sudo chmod -R +777 ${APP_DATA_DIR}

# remove unwanted .gitkeep s
find ${APP_DATA_DIR} -type f -name '.gitkeep' -delete

sudo chmod 0644 ${APP_DATA_DIR}/onlyoffice/mysql/conf.d/onlyoffice.cnf


