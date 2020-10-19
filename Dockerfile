FROM ubuntu

LABEL version="1.0"
LABEL description="Ubuntu / Apache 2 / PHP 7.4"

MAINTAINER Nicolas BOULFROY <contact@nicolas-boulfroy.com>

# TimeZone configuration for TzData package.
ENV TZ=Europe/Paris

# Where you are when you exec the container.
WORKDIR /var/www

# Installs all necessary packages.
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y curl \
    && apt-get install -y php \
    && apt install -y php7.4-cli php7.4-fpm php7.4-json php7.4-pdo php7.4-mysql php7.4-sqlite3 php7.4-pgsql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath php7.4-json php7.4-dev php7.4-dom php7.4-enchant php7.4-pdo-pgsql php7.4-pdo-mysql php7.4-bz2 php7.4-imap php7.4-soap php7.4-intl \
    && apt-get install -y apache2 \
    && apt-get install -y composer \
    && apt-get clean \
    && a2enmod ssl \
    && a2enmod rewrite
	
# Adds permissions for directory project, Apache configuration & php configuration.
RUN chmod -R 777 /var/www && chmod -R 777 /etc/apache2 && chmod -R 777 /etc/php/7.4

# Command line executes when container is launching.
CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]
