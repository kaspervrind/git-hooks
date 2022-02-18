#!/usr/bin/env bash

# if any command inside script returns error, exit and return that error
set -e

if [ -e behat.yml ]; then
    echo "Running burger Behat tests"
#    bin/behat -p burger
#    bin/behat -p dvmg
#    bin/behat -p beheer
fi


