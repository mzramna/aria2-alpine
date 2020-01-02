FROM alpine:latest

VOLUME /downloads

EXPOSE 6800

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh;mkdir $CONFIG_FOLDER;/entrypoint.sh;apk add --update --no-cache aria2 && rm -rf /var/cache/apk/*

CMD aria2c --conf-path=/config/aria2.conf
