#!/usr/bin/env bash

# if any command inside script returns error, exit and return that error 
set -e

# magic line to ensure that we're always inside the root of our application,
# no matter from which directory we'll run script
# thanks to it we can just enter `./scripts/run-tests.bash`
cd "${0%/*}/../../../"
pwd

# let's fake failing test for now
echo "Running tests"
echo "............................" 

.git/hooks/scripts/phpunit.bash
.git/hooks/scripts/php-stan.bash
