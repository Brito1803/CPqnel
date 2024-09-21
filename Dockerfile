# Gunakan image PHP dengan Apache
FROM php:7.4-apache

# Install ekstensi yang diperlukan untuk MySQL dan PHP
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Install MySQL
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

# Konfigurasi MySQL, buat user dan database default
RUN service mysql start \
    && mysql -e "CREATE DATABASE IF NOT EXISTS my_database;" \
    && mysql -e "CREATE USER 'my_user'@'%' IDENTIFIED BY 'my_password';" \
    && mysql -e "GRANT ALL PRIVILEGES ON my_database.* TO 'my_user'@'%';" \
    && mysql -e "FLUSH PRIVILEGES;"

# Install Composer dan Node.js untuk mengelola dependensi PHP
RUN apt-get install -y git unzip curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Salin kode aplikasi ke dalam container
COPY . /var/www/html

# Set permission
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80
