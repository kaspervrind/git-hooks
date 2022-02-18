#!/usr/bin/env bash

echo "Runing PHPStan"
PHPFILES=`git diff --name-only --diff-filter=d HEAD | grep \.php`
if [[ "${PHPFILES}" == "" ]]; then
  exit 0
fi

phpstan analyze --level=1 $(git diff --name-only --diff-filter=d HEAD | grep \.php)
