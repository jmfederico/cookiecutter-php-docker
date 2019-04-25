#!/usr/bin/env sh
set -eo pipefail

if [[ ! -z "$CADDY_CERT" && ! -z "$CADDY_PRIVKEY" ]] && [[ ! -f $CADDY_CERT || ! -f $CADDY_PRIVKEY ]];
then
    echo "Generating new self-sign certificates" >&2
    mkdir -p /srv/certs
    printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth" > `dirname $(mktemp -u)`/openssl.conf
    openssl req -x509 -out "$CADDY_CERT" -keyout "$CADDY_PRIVKEY" \
        -newkey rsa:2048 -nodes -sha256 \
        -subj '/CN=localhost' -extensions EXT -config `dirname $(mktemp -u)`/openssl.conf
    rm `dirname $(mktemp -u)`/openssl.conf
fi

exec "$@"
