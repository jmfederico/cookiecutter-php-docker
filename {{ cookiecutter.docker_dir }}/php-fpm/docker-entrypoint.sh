#!/usr/bin/env sh
set -eo pipefail

composer dump-autoload

exec "$@"
