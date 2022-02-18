#!/usr/bin/env bash

set -e

pcurrent=$(pwd)
echo $pcurrent
# example of commands for different languages
# eslint .         # JS code quality check
# npm test         # JS unit tests
# flake8 .         # python code quality check
# nosetests        # python nose
# just put your usual test command here
if [[ $pcurrent == "/Users/kaspervrind/code/mijnoverheid-sf3-docker" ]]; then
    unbuffer /usr/local/bin/docker-compose exec php vendor/bin/phpunit -dxdebug.coverage_enable=1 --fail-on-warning  --configuration phpunit.xml.dist
elif [[ $pcurrent == "/Users/kaspervrind/code/portico" ]]; then
    unbuffer /usr/local/bin/docker-compose exec portico vendor/phpunit/phpunit/phpunit
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
