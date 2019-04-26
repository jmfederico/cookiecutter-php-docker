#!/usr/bin/env sh
set -eo pipefail

composer dump-autoloader

exec "$@"
