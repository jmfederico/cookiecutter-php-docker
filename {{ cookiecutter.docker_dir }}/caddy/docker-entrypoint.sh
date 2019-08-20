#!/usr/bin/env sh
set -eo pipefail

if [[ ! -z "$CADDY_CERT" && ! -z "$CADDY_PRIVKEY" ]] && [[ ! -f $CADDY_CERT || ! -f $CADDY_PRIVKEY ]];
then
    echo "Generating new self-sign certificates" >&2
    mkdir -p "$(dirname "$CADDY_CERT")"
    mkdir -p "$(dirname "$CADDY_PRIVKEY")"
    mkcert -cert-file "$CADDY_CERT" -key-file "$CADDY_PRIVKEY" ${CADDY_DOMAIN%:*}
fi

exec "$@"
