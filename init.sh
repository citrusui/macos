#!/usr/bin/env bash

function checkTools() {
  if [ ! "$(which git)" ]; then
    echo "Git is required." # TODO: install these automatically
    echo "Please install them from your package manager."
    echo "If you are on macOS, run xcode-select --install."
    sleep 5;
    exit 1;
  fi
}

function pullSource() {
  rsync --exclude ".git" --exclude ".travis.yml" --exclude "init.sh" --exclude "*.md" -avh --no-perms . ~; # TODO: suppress output with -s and report if files were untouched
}

checkTools

cd "$(dirname "${BASH_SOURCE}")";
echo ""
echo "Pulling updates..."
echo ""
git pull origin master;
if [ "$1" == "-y" ]; then
  pullSource
else
  echo ""
  read -p "This may overwrite your existing preferences. Continue? [Y/N] "
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    pullSource
  fi
fi
