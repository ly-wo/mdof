#!/bin/sh

sed -i "s|LOGIN_SERVER_HOST|${LOGIN_SERVER_HOST}|g" /app/config/application.yml
sed -i "s|LOGIN_SERVER_PORT|${LOGIN_SERVER_PORT}|g" /app/config/application.yml
sed -i "s|OSS_ADDR|${OSS_ADDR}|g" /app/config/application.yml

sed -i "s|MYSQL_LOGIN_HOST|${MYSQL_LOGIN_HOST}|g" /app/config/application.yml
sed -i "s|MYSQL_LOGIN_PORT|${MYSQL_LOGIN_PORT}|g" /app/config/application.yml
sed -i "s|MYSQL_LOGIN_USERNAME|${MYSQL_LOGIN_USERNAME}|g" /app/config/application.yml
sed -i "s|MYSQL_LOGIN_PASSWORD|${MYSQL_LOGIN_PASSWORD}|g" /app/config/application.yml
sed -i "s|MYSQL_LOGIN_SCHEMA|${MYSQL_LOGIN_SCHEMA}|g" /app/config/application.yml

java -jar dnf-http-0.0.1-SNAPSHOT.jar