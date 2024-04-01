# Utiliza la imagen oficial de PHP como base
FROM php:7.4-fpm

# Instala dependencias requeridas por Laravel y extensiones de PHP necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip

# Copia los archivos del proyecto al contenedor
COPY . /var/www/html

# Establece los permisos adecuados
RUN chown -R www-data:www-data /var/www/html/storage

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala las dependencias de PHP del proyecto
WORKDIR /var/www/html
RUN composer install

# Establece el comando por defecto para ejecutar PHP-FPM
CMD ["php-fpm"]
