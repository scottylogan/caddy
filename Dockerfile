FROM alpine
MAINTAINER Scotty Logan <scotty@scottylogan.com>

ADD https://caddyserver.com/download/linux/amd64?plugins=http.nobots,http.realip&license=personal /tmp/caddy

RUN addgroup -S caddy && \
    adduser -h /var/tmp -s /bin/false -g Caddy -S -D -H -G caddy caddy && \
    apk add --no-cache ca-certificates && \
    mkdir -p /usr/local/bin /etc/ssl/caddy /etc/caddy && \
    chown -R caddy:caddy /etc/caddy && \
    mv /tmp/caddy /usr/local/bin
    
ENV CADDYPATH=/etc/caddy/ssl

VOLUME /etc/caddy
VOLUME /var/log/caddy

CMD ["/usr/local/bin/caddy", "-agree=true", "-conf=/etc/caddy/Caddyfile", "-root=/var/tmp" ]
