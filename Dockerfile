FROM alpine:latest

VOLUME /downloads

EXPOSE 6800

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh;mkdir /config;apk add --update --no-cache aria2 && rm -rf /var/cache/apk/*
ENTRYPOINT [ "/entrypoint.sh" ]
CMD aria2c --conf-path=/config/aria2.conf
