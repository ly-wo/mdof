FROM mysql:5.7.28

ENV SERVER_HOST 127.0.0.1
ENV GAME_SERVER_PORT 10001

ENV MYSQL_GAME_SCHEMA game
ENV MYSQL_LOGIN_SCHEMA login

ENV MYSQL_ROOT_PASSWORD 123456
ENV LANG C.UTF-8
ENV TZ Asia/Shanghai

COPY init.sql /docker-entrypoint-initdb.d/init.sql
COPY docker-entrypoint.sh /usr/local/bin/
