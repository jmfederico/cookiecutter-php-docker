#!/usr/bin/env sh
set -eo pipefail

# Install dependencies only if php-fpm is being run.
if [[ $@ == "php-fpm" ]]
then
    >&2 echo "Installing dependencies via composer"
    rm -rf vendor/..?* vendor/.[!.]* vendor/*
    composer install
fi

exec docker-php-entrypoint "$@"
