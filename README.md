Simple docker image for [caddy](https://caddyserver.com/), using Alpine Linux.

Run with 3 volumes:

* one containing a Caddyfile to be mounted on /etc/caddy (can be read-only)
* a log volume to be mounted on /var/log/caddy (must be read/write)
* one for Let's Encrypt certificates, to be mounted on /var/lib/caddy/ssl (must be read/write)

