FROM php:7.4-apache

# Install Apache, PHP, MySQL, dan phpMyAdmin
RUN apt-get update && apt-get install -y \
  mysql-server \
  php-mysql \
  php-curl \
  php-json \
  php-cgi \
  php-mbstring \
  php-zip \
  php-gd \
  php-xml \
  php-gettext \
  php-ssh2 \
  curl \
  wget \
  unzip \
  && docker-php-ext-install mysqli pdo_mysql \
  && a2enmod rewrite

# Set up MySQL database
RUN service mysql start && mysql -y
  && mysql -e 
  && mysql -y

# Install phpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip \
  && unzip phpMyAdmin-5.1.1-all-languages.zip -d /var/www/html \
  && mv /var/www/html/phpMyAdmin-5.1.1-all-languages /var/www/html/phpmyadmin \
  && rm phpMyAdmin-5.1.1-all-languages.zip

EXPOSE 80
