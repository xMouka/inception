FROM debian:bookworm

ARG ADMINER_VERSION=5.4.2

RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget -O index.php https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
