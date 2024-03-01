# FROM apk:rebuild as builder1

# ENV NEED_REPLACE "1"
# ENV OLD_STR "192.168.88.10"
# ENV NEW_STR "dnf.example.org"
# ENV OLD_FILE_PATH "/assets/bin/Data/Managed/Metadata/global-metadata.dat"
# ENV FILE_PATH "global-metadata.dat"
# ENV NEW_FILE_PATH "global-metadata-1.dat"
# ENV APK_FILE="app"
# ENV KEYSTORE_PATH "/app/test.jks"
# ENV KEYSTORE_ALIAS "test"
# ENV KEYSTORE_PASSWORD "123456"
# ENV KEY_PASSWORD "123456"

# ENV APKTOOL_VERSION 2.5.0
# ENV APKTOOL_PATH /usr/local/bin/apktool.jar
# ENV ANDROID_HOME /usr/local/android-sdk
# ENV PATH $PATH:$ANDROID_HOME/tools/bin
# ENV TZ Asia/Shanghai

# COPY ${APK_FILE}.apk .

# RUN /app/script.sh


# go
FROM golang:1.21-alpine AS builder

LABEL stage=gobuilder

ENV CGO_ENABLED 0
ENV GOPROXY https://goproxy.cn,direct
ENV APK_FILE="app"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
  apk update --no-cache && apk add --no-cache tzdata

WORKDIR /build

COPY lib lib/
COPY index.html .
COPY main.go .
# COPY --from=builder1 /data/${APK_FILE}_signed.apk html/${APK_FILE}.apk
ADD go.mod .
ADD go.sum .
RUN go mod download && \
  go build -ldflags="-s -w" -o /app/gm .


FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /usr/share/zoneinfo/Asia/Shanghai
ENV TZ Asia/Shanghai

ENV GIN_MODE release
ENV WEB_HOST ''
ENV WEB_PORT 80
ENV WEB_GM_CODE dnf
ENV GM_SERVER_HOST 127.0.0.1
ENV GM_SERVER_PORT 20001

WORKDIR /app
COPY --from=builder /app/gm .
# COPY download download/

EXPOSE ${WEB_PORT}

CMD ["./gm"]
