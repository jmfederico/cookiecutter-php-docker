FROM abiosoft/caddy:{{ cookiecutter.caddy_version }}

RUN mkdir -p /srv/www \
    /srv/caddy

WORKDIR /srv/caddy

ADD https://github.com/FiloSottile/mkcert/releases/download/v1.4.0/mkcert-v1.4.0-linux-amd64 /usr/local/bin/mkcert
RUN chmod +x /usr/local/bin/mkcert

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/parent", "caddy", "--agree=$ACME_AGREE"]
