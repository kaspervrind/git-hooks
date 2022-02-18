#!/bin/bash

# This way you can customize which branches should be skipped when
# prepending commit message.
if [ -z "$BRANCHES_TO_SKIP" ]; then
  BRANCHES_TO_SKIP=(master develop test)
fi

BRANCH_NAME=$(git symbolic-ref --short HEAD | tr '[:upper:]' '[:lower:]' | tr '_' '-')
BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")
BRANCH_IN_COMMIT=$(grep -c "\[$BRANCH_NAME\]" $1)
if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_EXCLUDED -eq 1 ]] && ! [[ $BRANCH_IN_COMMIT -ge 1 ]]; then
  sed -i.bak -e "1s%^%[$BRANCH_NAME] %" $1
fi


##!/bin/sh
## husky
#cd .
#[ -f package.json ] && cat package.json | grep -q '"preparecommitmsg"\s*:'
#[ $? -ne 0 ] && exit 0
#export NVM_DIR="/Users/kaspervrind/.nvm"
#BREW_NVM_DIR="/usr/local/opt/nvm"
#[ -s "$BREW_NVM_DIR/nvm.sh" ] && . "$BREW_NVM_DIR/nvm.sh"
#export PATH=$PATH:/usr/local/bin:/usr/local
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
#command -v nvm >/dev/null 2>&1 && [ -f .nvmrc ] && nvm use
#command -v npm >/dev/null 2>&1 || { echo >&2 "husky - can't find npm in PATH. Skipping preparecommitmsg script in package.json"; exit 0; }
#export GIT_PARAMS="$*"
#npm run preparecommitmsg
#if [ $? -ne 0 ]; then
#  echo
#  echo "husky - prepare-commit-msg hook failed (add --no-verify to bypass)"
#  echo
#  exit 1
#fi
