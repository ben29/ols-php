#!/usr/bin/env bash

git pull
docker build -t php-ols:1.0 .
docker tag php-ols:1.0 benhakim2010/php-ols:1.0
docker tag php-ols:1.0 benhakim2010/php-ols:latest
docker push benhakim2010/php-ols:1.0
docker push benhakim2010/php-ols:latest