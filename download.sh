#!/bin/sh
set -e

TARGET="${1:-/var/www}"

mkdir -p "${TARGET}"
cd "${TARGET}"

drush pm-download \
    --drupal-project-rename=drupal \
    "drupal-${DRUPAL_VERSION}"
