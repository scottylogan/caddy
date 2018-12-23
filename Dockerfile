FROM alpine
MAINTAINER Scotty Logan <scotty@scottylogan.com>

ADD https://caddyserver.com/download/linux/amd64?plugins=http.nobots,http.proxyprotocol,http.ratelimit,http.redir,http.realip&license=personal&telemetry=off /tmp/caddy.tar.gz

RUN addgroup -S caddy && \
    adduser -h /var/tmp -s /bin/false -g Caddy -S -D -H -G caddy caddy && \
    apk add --no-cache ca-certificates && \
    mkdir -p /tmp/caddy /usr/local/bin /var/lib/caddy/ssl /etc/caddy && \
    chown -R caddy:caddy /etc/caddy && \
    tar -C /tmp/caddy -xzf /tmp/caddy.tar.gz && \
    mv /tmp/caddy/caddy /usr/local/bin && \
    chmod 755 /usr/local/bin/caddy
    
ENV CADDYPATH=/var/lib/caddy/ssl

VOLUME /etc/caddy
VOLUME /var/log/caddy
VOLUME /var/lib/caddy/ssl

EXPOSE 80 443

CMD ["/usr/local/bin/caddy", "-agree=true", "-conf=/etc/caddy/Caddyfile", "-root=/var/tmp" ]
