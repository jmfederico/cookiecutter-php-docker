FROM abiosoft/caddy:{{ cookiecutter.caddy_version }}

RUN mkdir -p /srv/www \
    /srv/caddy

WORKDIR /srv/caddy

ARG MKCERT_VERSION={{ cookiecutter.mkcert_version }}
RUN wget -O /usr/local/bin/mkcert https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64
RUN chmod +x /usr/local/bin/mkcert

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/parent", "caddy", "--agree=$ACME_AGREE"]
