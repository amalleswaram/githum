FROM php:8.0-apache

ENV http_proxy http://138.35.86.205:8080
ENV https_proxy http://138.35.86.205:8080

MAINTAINER "lpastva <pastva@dxc.com>"
RUN a2enmod rewrite
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apt-get update
RUN apt-get install -y zlib1g-dev && rm -rf /var/lib/apt/lists/* && docker-php-ext-install zip
RUN docker-php-ext-install mysqli

COPY ./html /var/www/html