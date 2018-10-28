FROM alpine
MAINTAINER Scotty Logan <scotty@scottylogan.com>

ADD https://caddyserver.com/download/linux/amd64?plugins=http.nobots,http.realip&license=personal /tmp/caddy

RUN addgroup -S caddy && \
    adduser -h /var/tmp -s /bin/false -g Caddy -S -D -H -G caddy caddy && \
    apk add --no-cache ca-certificates && \
    mkdir -p /usr/local/bin /var/lib/caddy/ssl /etc/caddy && \
    chown -R caddy:caddy /etc/caddy && \
    mv /tmp/caddy /usr/local/bin && \
    chmod 755 /usr/local/bin/caddy
    
ENV CADDYPATH=/var/lib/caddy/ssl

VOLUME /etc/caddy
VOLUME /var/log/caddy
VOLUME /var/lib/caddy/ssl

EXPOSE 80 443

CMD ["/usr/local/bin/caddy", "-agree=true", "-conf=/etc/caddy/Caddyfile", "-root=/var/tmp" ]
