FROM abiosoft/caddy:builder as builder

ARG version="{{ cookiecutter.caddy_version }}"
ARG plugins="realip,cloudflare"

RUN VERSION=${version} PLUGINS=${plugins} /bin/sh /usr/bin/builder.sh

FROM alpine:{{ cookiecutter.caddy_alpine_version }}

RUN apk --no-cache add curl openssl

RUN mkdir -p /srv/www \
    /srv/caddy/

WORKDIR /srv/caddy

COPY Caddyfile /srv/caddy/
COPY tls_mode /srv/caddy/tls_mode
COPY --from=builder /install/caddy /usr/local/bin/

EXPOSE 80/tcp
EXPOSE 443/tcp

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["caddy", "-agree"]
