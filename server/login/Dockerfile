FROM openjdk:8-alpine

ENV LOGIN_SERVER_HOST localhost
ENV LOGIN_SERVER_PORT 80
ENV OSS_ADDR http://localhost/resource/

ENV MYSQL_LOGIN_HOST 127.0.0.1
ENV MYSQL_LOGIN_PORT 3306
ENV MYSQL_LOGIN_USERNAME root
ENV MYSQL_LOGIN_PASSWORD 123456
ENV MYSQL_LOGIN_SCHEMA login

WORKDIR /app
COPY . .

EXPOSE ${LOGIN_SERVER_PORT}

CMD [ "./docker-entrypoint.sh" ]