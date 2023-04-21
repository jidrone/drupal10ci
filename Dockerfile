FROM drupal:10.0.0-rc3-php8.1-apache-buster

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
	--no-install-recommends

RUN { \
		echo 'deb http://dl.google.com/linux/chrome/deb/ stable main'; \
	} > /etc/apt/sources.list.d/google-chrome.list

RUN set -eux; \
	wget https://dl-ssl.google.com/linux/linux_signing_key.pub; \
	apt-key add linux_signing_key.pub; \
	apt-get update && apt-get install -y \
	google-chrome-unstable \
	fontconfig \
	fonts-ipafont-gothic \
	fonts-wqy-zenhei \
	fonts-thai-tlwg \
	fonts-kacst \
	fonts-symbola \
	fonts-noto \
	fonts-freefont-ttf \
	--no-install-recommends

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION 10.0.0-rc3

RUN set -eux; \
	composer global require consolidation/robo:^4;

ENV PATH=/root/.config/composer/vendor/bin:${PATH}

RUN rm -rf /var/www/html

# vim:set ft=dockerfile:
