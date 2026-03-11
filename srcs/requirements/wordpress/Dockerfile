FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql php-curl php-gd php-mbstring \
    php-xml php-xmlrpc php-zip wget curl netcat-openbsd \
    php-redis \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/wp-setup.sh /usr/local/bin/wp-setup.sh
RUN chmod +x /usr/local/bin/wp-setup.sh

EXPOSE 9000

RUN chown -R www-data:www-data /var/www/html

CMD ["/usr/local/bin/wp-setup.sh"]