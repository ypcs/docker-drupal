#!/bin/sh
set -e

drush \
    --yes \
    site-install minimal \
    --account-name="${USERNAME}" \
    --account-pass="${PASSWORD}" \
    --account-mail="${EMAIL}" \
    --db-url="${DATABASE_URI}" \
    --site-name="${SITE_NAME}" \
    --site-mail="${SITE_MAIL}"
