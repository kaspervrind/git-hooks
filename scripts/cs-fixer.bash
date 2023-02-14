#!/usr/bin/env bash

echo "php-cs-fixer pre commit hook start"

if [ "$( docker compose ps php | grep 'php' )" ]; then
   csfixer="docker compose exec php /app/tools/php-cs-fixer/vendor/bin/php-cs-fixer"
elif [ -e tools/php-cs-fixer/vendor/bin/php-cs-fixer ]; then
  csfixer="tools/php-cs-fixer/vendor/bin/php-cs-fixer"
elif [ -e vendor/friendsofphp/php-cs-fixer/php-cs-fixer ]; then
  csfixer="vendor/friendsofphp/php-cs-fixer/php-cs-fixer"
else
  csfixer="php-cs-fixer"
fi;

echo "Fixer: $csfixer"

git status --porcelain | grep -e '^[AM]\(.*\).php$' | cut -c 3- | while read line; do
    echo "checking $line"
    ${csfixer} fix --verbose "$line";
    git add "$line";
done

echo "php-cs-fixer pre commit hook finish"
