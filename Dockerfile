FROM debian:12.7

ARG OLS_VERSION=1.8.2
ARG PHP_VERSION=8.3.13

ENV PATH="/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin"
ENV DEPEND="wget g++ make pkg-config libxml2-dev libssl-dev zlib1g-dev libcurl4-openssl-dev libpng-dev libonig-dev libsodium-dev libzip-dev"

RUN set -eux; \
    apt update && apt upgrade -y; \
    apt install --no-install-recommends ${DEPEND} -y; \
    rm -rf /var/lib/apt/lists/*; \
    cd /tmp; \
    wget https://openlitespeed.org/packages/openlitespeed-$OLS_VERSION.tgz; \
    tar xzf openlitespeed-$OLS_VERSION.tgz; \
    cd openlitespeed; \
    ./install.sh; \
    echo 'cloud-docker' > /usr/local/lsws/PLAT; \
    wget https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz; \
    tar zvxf php-${PHP_VERSION}.tar.gz; \
    cd php-{PHP_VERSION}; \
    rm -rf /tmp/*; \
    wget -O -  https://get.acme.sh | sh; \
    ln -s /usr/local/lsws/$PHP_VERSION/bin/php /usr/bin/php; \
    ln -sf /usr/local/lsws/$PHP_VERSION/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp8; \
    ln -sf /usr/local/lsws/fcgi-bin/lsphp8 /usr/local/lsws/fcgi-bin/lsphp;


COPY docker.conf /usr/local/lsws/conf/templates/docker.conf

COPY setup_docker.sh /usr/local/lsws/bin/setup_docker.sh

COPY httpd_config.xml /usr/local/lsws/conf/httpd_config.xml

# COPY htpasswd /usr/local/lsws/admin/conf/htpasswd

RUN /usr/local/lsws/bin/setup_docker.sh && rm /usr/local/lsws/bin/setup_docker.sh

RUN chown 994:994 /usr/local/lsws/conf -R

RUN cp -RP /usr/local/lsws/conf/ /usr/local/lsws/.conf/

RUN cp -RP /usr/local/lsws/admin/conf /usr/local/lsws/admin/.conf/

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 7080

WORKDIR /var/www/vhosts/
