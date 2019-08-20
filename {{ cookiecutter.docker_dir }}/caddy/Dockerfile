FROM abiosoft/caddy:{{ cookiecutter.caddy_version }}

RUN apk --no-cache add curl openssl

RUN mkdir -p /srv/www \
    /srv/caddy

WORKDIR /srv/caddy

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/parent", "caddy", "--agree=$ACME_AGREE"]
