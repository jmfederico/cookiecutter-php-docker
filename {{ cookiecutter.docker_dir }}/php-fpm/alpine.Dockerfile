FROM php:{{ cookiecutter.php_version }}-fpm-alpine

RUN apk add --no-cache $PHPIZE_DEPS \
    \
    && docker-php-ext-install opcache pdo_mysql bcmath pcntl exif \
    \
    && apk add --no-cache libxml2-dev libjpeg-turbo-dev libpng-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    \
    && apk add --no-cache bzip2-dev \
    && docker-php-ext-install bz2 \
    \
    && apk add --no-cache libzip-dev \
    && docker-php-ext-install zip \
    \
    && apk add --no-cache icu-dev \
    && docker-php-ext-install intl \
    \
    && apk add --no-cache tidyhtml-dev \
    && docker-php-ext-install tidy \
    \
    && apk add --no-cache libxml2-dev \
    && docker-php-ext-install soap xmlrpc \
    \
    && apk add --no-cache libxslt-dev \
    && docker-php-ext-install xsl \
    \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    \
    && apk del $PHPIZE_DEPS

RUN mkdir -p /srv/php-fpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY docker/php-fpm/php-fpm.d/*.conf /usr/local/etc/php-fpm.d/
COPY docker/php-fpm/conf.d/*.ini /usr/local/etc/php/conf.d/

WORKDIR /srv/www

EXPOSE 9000/tcp

COPY docker/php-fpm/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]
