#!/usr/bin/env bash

echo "php-cs-fixer pre commit hook start"

if [ "$( docker compose ps php | grep 'php' )" ]; then
   csfixer="docker compose exec -T php /app/tools/php-cs-fixer/vendor/bin/php-cs-fixer --config=/app/.php-cs-fixer.php"
elif [ -e tools/php-cs-fixer/vendor/bin/php-cs-fixer ]; then
  csfixer="tools/php-cs-fixer/vendor/bin/php-cs-fixer"
elif [ -e vendor/friendsofphp/php-cs-fixer/php-cs-fixer ]; then
  csfixer="vendor/friendsofphp/php-cs-fixer/php-cs-fixer"
else
  csfixer="php-cs-fixer"
fi;

echo "Fixer: $csfixer"

function fix ()
{
  ${csfixer} fix --verbose $@;
}

files=()
for file in $(git diff --name-only --cached --diff-filter=d | grep '.php'); do
  if [ -z "$file" ]; then
     continue
   fi
   files+=("${file}")
done

echo  "There are ${#files[@]} to be fixed"

if [ ${#files[@]} -gt 0 ]; then
  fix ${files[@]}
  echo "fixing"
  git add ${files[@]}
fi
echo "php-cs-fixer pre commit hook finish"
