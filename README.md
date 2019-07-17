# Docker for PHP

An opinionated [Cookiecutter](https://github.com/audreyr/cookiecutter) template for
running PHP projects in Docker.

## Features

* Uses [MySQL](https://www.mysql.com) as database.
* Uses [Caddy](https://caddyserver.com) as web-server (optionally with
[Cloudflare](https://caddyserver.com/docs/tls.dns.cloudflare) plugin).
* Serves on HTTPS.
* Serves files from `public` folder by default.
* Uses [Alpine](https://alpinelinux.org) or [Debian](https://www.debian.org) for PHP
docker images.
* [Composer](https://getcomposer.org) as package management.
* Includes a development [mail server](http://djfarrelly.github.io/MailDev/).
* Includes example dotenv files compatible with [dotenver](https://pypi.org/project/dotenver/).
* Allows for custom SSL certificates to be used.

## How to use

Run the following commands inside you root projects directory.

```bash
# Grab cookie and generate files
cookiecutter gh:jmfederico/cookiecutter-php-docker
```

```bash
# Automatically generate dotenv files
docker run --rm -v "`pwd`:/var/lib/dotenver/" jmfederico/dotenver
```

```bash
# Initialize composer project
composer require psy/psysh
```

```bash
# Build and run Docker images
docker-compose build
docker-compose up -d
```

Now you can visit https://localhost/

## Running commands
The recommended way to run commands is inside the PHP container:
```bash
docker-compose run --rm php-fpm vendor/bin/psysh
````
