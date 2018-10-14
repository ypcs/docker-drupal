FROM ypcs/php:7.0

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV DRUSH_VERSION 8.1.17
ENV DRUSH_SHA256 9c5b245c3a437851bded21fd52014dddd1f5eb8f3e9ee8230047533bd02829ba

RUN \
    /usr/lib/docker-helpers/apt-setup && \
    /usr/lib/docker-helpers/apt-upgrade && \
    apt-get --assume-yes install \
        curl \
        php-zip \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-imap \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mcrypt \
        php${PHP_VERSION}-memcache \
        php${PHP_VERSION}-memcached \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-xml && \
    /usr/lib/docker-helpers/apt-cleanup

RUN \
    curl -fSL "https://github.com/drush-ops/drush/releases/download/${DRUSH_VERSION}/drush.phar" -o /usr/local/bin/drush && \
    echo "${DRUSH_SHA256} /usr/local/bin/drush" |sha256sum -c - && \
    chmod +x /usr/local/bin/drush

COPY download.sh /usr/local/sbin/drupal-download
COPY permissions.sh /usr/local/sbin/drupal-permissions
COPY install.sh /usr/local/sbin/drupal-install

RUN echo "Source: https://github.com/ypcs/docker-drupal\nBuild date: $(date --iso-8601=ns)" >/README

ENV DRUPAL_DATABASE_DSN mysql://drupal:drupal@db/drupal
ENV DRUPAL_VERSION 7.x
