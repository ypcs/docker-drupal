#!/bin/sh
set -e

TARGET="${1}"
VERSION="${2:-${DRUPAL_VERSION:-7.x}}"
[ -z "${TARGET}" ] && echo "missing target directory!" && exit 1
[ -z "${VERSION}" ] && echo "missing version!" && exit 1

TEMPDIR="$(mktemp -d drupal-download.XXXXXX)"
CURDIR="$(pwd)"

cd "${TEMPDIR}"

drush pm-download \
    --drupal-project-rename=drupal \
    "drupal-${VERSION}"

mkdir -p "${TARGET}"
mv drupal/* "${TARGET}/"

cd "${CURDIR}"
rm -rf "${TEMPDIR}"
