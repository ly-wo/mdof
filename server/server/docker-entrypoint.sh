#!/bin/sh

mkdir -p log/exception log/mail log/market log/scene

sed -i "s|GAME_SERVER_HOST|${GAME_SERVER_HOST}|g" /app/config/game.properties
sed -i "s|GAME_SERVER_PORT|${GAME_SERVER_PORT}|g" /app/config/game.properties
sed -i "s|LOGIN_SERVER_URL|${LOGIN_SERVER_URL}|g" /app/config/game.properties
sed -i "s|PAY_NOTIFY_URL|${PAY_NOTIFY_URL}|g" /app/config/game.properties
sed -i "s|ADMIN_URL|${ADMIN_URL}|g" /app/config/game.properties

sed -i "s|GM_SERVER_PORT|${GM_SERVER_PORT}|g" /app/config/application.properties

sed -i "s|MYSQL_GAME_HOST|${MYSQL_GAME_HOST}|g" /app/config/application.properties
sed -i "s|MYSQL_GAME_PORT|${MYSQL_GAME_PORT}|g" /app/config/application.properties
sed -i "s|MYSQL_GAME_USERNAME|${MYSQL_GAME_USERNAME}|g" /app/config/application.properties
sed -i "s|MYSQL_GAME_PASSWORD|${MYSQL_GAME_PASSWORD}|g" /app/config/application.properties
sed -i "s|MYSQL_GAME_SCHEMA|${MYSQL_GAME_SCHEMA}|g" /app/config/application.properties

sed -i "s|MYSQL_LOGIN_HOST|${MYSQL_LOGIN_HOST}|g" /app/config/application.properties
sed -i "s|MYSQL_LOGIN_PORT|${MYSQL_LOGIN_PORT}|g" /app/config/application.properties
sed -i "s|MYSQL_LOGIN_USERNAME|${MYSQL_LOGIN_USERNAME}|g" /app/config/application.properties
sed -i "s|MYSQL_LOGIN_PASSWORD|${MYSQL_LOGIN_PASSWORD}|g" /app/config/application.properties
sed -i "s|MYSQL_LOGIN_SCHEMA|${MYSQL_LOGIN_SCHEMA}|g" /app/config/application.properties

sed -i "s|MYSQL_KF_HOST|${MYSQL_KF_HOST}|g" /app/config/application.properties
sed -i "s|MYSQL_KF_PORT|${MYSQL_KF_PORT}|g" /app/config/application.properties
sed -i "s|MYSQL_KF_USERNAME|${MYSQL_KF_USERNAME}|g" /app/config/application.properties
sed -i "s|MYSQL_KF_PASSWORD|${MYSQL_KF_PASSWORD}|g" /app/config/application.properties
sed -i "s|MYSQL_KF_SCHEMA|${MYSQL_KF_SCHEMA}|g" /app/config/application.properties

sed -i "s|REDIS_HOST|${REDIS_HOST}|g" /app/config/application.properties
sed -i "s|REDIS_PASSWORD|${REDIS_PASSWORD}|g" /app/config/application.properties
sed -i "s|REDIS_PORT|${REDIS_PORT}|g" /app/config/application.properties
sed -i "s|REDIS_DB|${REDIS_DB}|g" /app/config/application.properties

if [ "${REDIS_ENABLED}" = "1" ]; then
  sed -i "39,47s|^#||g" /app/config/application.properties
fi


java -Dloader.path=lib,resource -jar game_server-1.0.jar