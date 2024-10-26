#!/usr/bin/env bash

# Define prefix for installation
prefix="/usr/local/lsws/lsphp83"

CFLAGS="-g -O2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -ffile-prefix-map=/build/php8.3-8.3.10=. -flto=auto -ffat-lto-objects -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -fcf-protection -fdebug-prefix-map=/build/php8.3-8.3.10=/usr/src/php8.3-8.3.10-1+noble -O2 -Wall -fsigned-char -fno-strict-aliasing -fno-lto -g"

./configure \
    --host=x86_64-linux-gnu \
    --datadir="${prefix}/share/php/8.3" \
    --libdir="${prefix}/lib/php" \
    --libexecdir="${prefix}/lib/php" \
    --prefix="${prefix}" \
    --program-suffix=8.3 \
    --build=x86_64-linux-gnu \
    --with-libdir=lib/x86_64-linux-gnu \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-openssl \
    --with-iconv \
    --with-curl \
    --with-zlib \
    --with-libxml \
    --with-zip \
    --with-sodium \
    --with-pic \
    --enable-filter \
    --enable-ctype \
    --enable-xml \
    --enable-tokenizer \
    --enable-dom \
    --enable-simplexml \
    --enable-calendar \
    --enable-pdo \
    --enable-phar \
    --enable-session \
    --enable-mbstring \
    --enable-bcmath \
    --enable-exif \
    --enable-fileinfo \
    --enable-gd \
    --enable-intl \
    --enable-zts \
    --enable-ipv6 \
    --enable-litespeed \
    --disable-cgi \
    --disable-phpdbg \
    --disable-all