FROM drupal:10.2.1-php8.2-apache-bullseye

RUN set -eux; \
	apt-get update; \
	apt-get install -y \
	zip \
	unzip \
	nano \
	git \
	wget \
	gnupg2 \
	default-mysql-client \
	apt-transport-https \
	ca-certificates \
	curl \
	npm \
	openssh-client \
	--no-install-recommends

# set recommended PHP.ini settings
RUN { \
		echo 'memory_limit = 512M'; \
	} > /usr/local/etc/php/conf.d/docker-fpm.ini

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION 10.2.1
ENV DRUPAL_CI true

# Install NodeJs.
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Install Playwright and its dependencies
RUN npx playwright install-deps

# Install robo.
RUN set -eux; \
	composer global require consolidation/robo:^4;

# Add composer to PATH.
ENV PATH=/root/.config/composer/vendor/bin:${PATH}

# Allow composer to run as root.
ENV COMPOSER_ALLOW_SUPERUSER=1

# Remove existing drupal files.
RUN rm -rf /var/www/html

# vim:set ft=dockerfile:
