#!/bin/sh
set -e

TARGET="$1"
[ -z "${TARGET}" ] && echo "missing target directory!" && exit 1

# check that essential variables defined
[ -z "${DRUPAL_SITE}" ] && echo "missing variable: \$DRUPAL_" && exit 1
[ -z "${DRUPAL_USERNAME}" ] && echo "missing variable: \$DRUPAL_USERNAME" && exit 1
[ -z "${DRUPAL_PASSWORD}" ] && echo "missing variable: \$DRUPAL_PASSWORD" && exit 1
[ -z "${DRUPAL_DATABASE_DSN}" ] && echo "missing variable: \$DRUPAL_DATABASE_DSN" && exit 1



if [ ! -f "${TARGET}/install.php" ]
then
    echo "No Drupal installation found, exiting!"
    exit 1
fi

cd "${TARGET}"

set +e
drush status bootstrap | grep -q Successful
STATUS="$?"
set -e

if [ "${STATUS}" = "1" ]
then
    drush site-install standard -y \
        --db-url="${DRUPAL_DATABASE_DSN}" \
        --site-name="${DRUPAL_SITE}" \
        --account-name="${DRUPAL_USERNAME}" \
        --account-pass="${DRUPAL_PASSWORD}"
else
    echo "Drupal already bootstrapped, skipping site-install!"
fi
