FROM drupal:10.0.0-rc3-php8.1-apache-buster

RUN set -eux; \
	apt-get update; \
	apt-get install -y zip unzip nano git wget gnupg2 default-mysql-client

RUN { \
		echo 'deb http://dl.google.com/linux/chrome/deb/ stable main'; \
	} > /etc/apt/sources.list

RUN set -eux; \
	wget https://dl-ssl.google.com/linux/linux_signing_key.pub; \
	apt-key add linux_signing_key.pub; \
	apt-get update; \
	apt-get install -y google-chrome-unstable

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION 10.0.0-rc3

RUN set -eux; \
	export COMPOSER_HOME="$(mktemp -d)"; \
	composer global require consolidation/robo:^4; \
	# delete composer cache
	rm -rf "$COMPOSER_HOME"

ENV PATH=${PATH}:/opt/drupal/vendor/bin
ENV PATH=${HOME}/.composer/vendor/bin:${PATH}

RUN rm -rf /var/www/html

# vim:set ft=dockerfile:
