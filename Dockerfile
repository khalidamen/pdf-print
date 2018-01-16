FROM php:7.1-fpm

# Install dependencies
#RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -


RUN apt-get update && apt-get install -y \
	    libmagickwand-dev memcached libmemcached-dev libpq-dev\
        --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick 

# Install Memcached for php 7
RUN curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" \
    && mkdir -p /usr/src/php/ext/memcached \
    && tar -C /usr/src/php/ext/memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached \
	&& rm /tmp/memcached.tar.gz
