#!/usr/bin/env bash

set -e

pcurrent=$(pwd)
echo $pcurrent

files=()
for file in $(git diff --name-only --cached --diff-filter=d | grep '.php'); do
  if [ -z "$file" ]; then
     continue
   fi
   files+=("${file}")
done

echo  "There are ${#files[@]} to be fixed"

if [ ${#files[@]} = 0 ]; then
  echo "no PHP files to be changed. Don't execute phpunit"
  exit 0
fi

if [ "$( docker compose ps php | grep 'php' )" ]; then
    unbuffer docker compose exec php /app/vendor/bin/phpunit --configuration /app/phpunit.xml.dist
elif [ "$( docker compose ps php-fpm | grep 'php-fpm' )" ]; then
    unbuffer docker compose exec php-fpm /app/vendor/bin/phpunit --configuration /app/phpunit.xml.dist
elif [ -e vendor/bin/phpunit ] && [ -e vendor/phpunit/phpunit/phpunit ] && [ -e phpunit.xml ]; then
    vendor/bin/phpunit -dxdebug.coverage_enable=1 --fail-on-warning  --configuration phpunit.xml
elif [ -e vendor/bin/phpunit ] && [ -e vendor/phpunit/phpunit/phpunit ] && [ -e phpunit.xml.dist ]; then
    vendor/bin/phpunit -dxdebug.coverage_enable=1 --fail-on-warning  --configuration phpunit.xml.dist
elif [ -e vendor/bin/phpunit ] && [ -e vendor/phpunit/phpunit/phpunit ]; then
    vendor/bin/phpunit -dxdebug.coverage_enable=1 --fail-on-warning
else
    echo "No PHPUnit file found, skipping tests"
fi

exit 0
