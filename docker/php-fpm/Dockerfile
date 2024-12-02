FROM php:8.0-fpm
RUN apt-get update && apt-get install -y \
    tini \
    libzip-dev \
    libfcgi-bin \
    procps tmux vim net-tools \
    supervisor \
    && docker-php-ext-install zip

COPY supervisord.conf /etc/supervisor/supervisord.conf

CMD ["supervisord"]
