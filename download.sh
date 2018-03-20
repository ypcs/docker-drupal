#!/bin/sh
set -e

TARGET="${1:-/var/www}"
cd "${TARGET}"

drush pm-download \
    --drupal-project-rename=drupal \
    "drupal-${DRUPAL_VERSION}"
