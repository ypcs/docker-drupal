#!/bin/sh
set -e

TARGET="${1}"
[ -z "${TARGET}" ] && echo "missing target directory!" && exit 1
[ ! -d "${TARGET}" ] && echo "target directory does not exist!" && exit 1

mkdir -p "${TARGET}/sites/default/files"

echo "Change file ownership to root:www-data."
find "${TARGET}" -exec chown root:www-data '{}' \;

echo "Change file permissions (d: 0755, f: 0644)."
find "${TARGET}" -type d -exec chmod 0755 '{}' \;
find "${TARGET}" -type f -exec chmod 0644 '{}' \;

echo "Add write permissions to user content."
find "${TARGET}/sites/default" -type d -name files -exec chmod 0770 '{}' \;
find "${TARGET}/sites/defaul/files" -type d -exec chmod 0770 '{}' \;
find "${TARGET}/sites/default/files" -type f -exec chmod 0660 '{}' \;

# needed by civicrm
find "${TARGET}/sites" -maxdepth 1 -type d -name default -exec chmod 0770 '{}' \;

