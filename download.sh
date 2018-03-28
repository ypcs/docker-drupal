#!/bin/sh
set -e

TARGET="${1}"
[ -z "${TARGET}" ] && echo "missing target directory!" && exit 1

TEMPDIR="$(mktemp -d drupal-download.XXXXXX)"
CURDIR="$(pwd)"

cd "${TEMPDIR}"

drush pm-download \
    --drupal-project-rename=drupal \
    "drupal-${DRUPAL_VERSION:-7.x}"

mkdir -p "${TARGET}"
mv drupal/* "${TARGET}/"

cd "${CURDIR}"
rm -rf "${TEMPDIR}"
