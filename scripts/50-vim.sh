#!/bin/bash
BASEDIR="$HOME/.vim/bundle"
if test ! -f "$HOME/.vim"; then
  echo "Installing VIM-IDE"
  git clone git@github.com:fredrik84/vim-ide.git $HOME/.vim
fi
mkdir -p $BASEDIR
for plugin in $(cat schemas/vim-plugins.txt); do
  PLUGIN=$(basename $plugin)
  if test -f "$BASEDIR/$PLUGIN"; then
    echo "Installing $PLUGIN"
    git clone $plugin "$BASEDIR/$PLUGIN"
  else
    echo "Updating $PLUGIN"
    (
      cd $BASEDIR/$PLUGIN;
      git fetch
      BRANCH=$(git branch | tail -n1 | /usr/bin/cut -c '3-')
      git pull origin $BRANCH
    )
  fi
done
