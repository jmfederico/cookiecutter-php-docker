FROM php:{{ cookiecutter.php_version }}-fpm

RUN apt-get update \
    \
    && docker-php-ext-install opcache pdo_mysql bcmath pcntl exif \
    \
    && apt-get install -y libxml2-dev libjpeg-dev libpng-dev libfreetype6-dev --no-install-recommends \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    \
    && apt-get install -y libbz2-dev --no-install-recommends \
    && docker-php-ext-install bz2 \
    \
    && apt-get install -y zlib1g-dev --no-install-recommends \
    && docker-php-ext-install zip \
    \
    && apt-get install -y libicu-dev --no-install-recommends \
    && docker-php-ext-install intl \
    \
    && apt-get install -y libtidy-dev --no-install-recommends \
    && docker-php-ext-install tidy \
    \
    && apt-get install -y libxml2-dev --no-install-recommends \
    && docker-php-ext-install soap xmlrpc \
    \
    && apt-get install -y libxslt-dev --no-install-recommends \
    && docker-php-ext-install xsl \
    \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    \
    && rm -r /var/lib/apt/lists/*

RUN mkdir -p /srv/php-fpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY docker/php-fpm/php-fpm.d/*.conf /usr/local/etc/php-fpm.d/
COPY docker/php-fpm/conf.d/*.ini /usr/local/etc/php/conf.d/

WORKDIR /srv/www

COPY composer.* ./

RUN composer install

EXPOSE 9000/tcp

COPY docker/php-fpm/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]
