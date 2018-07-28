#!/usr/bin/env bash

# settings location
#DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd  )
DIR=`pwd`

# files to ignore processing
IGNORE=". .. .mailrc .gitignore .git"
ignore() {
  b=`basename $1`
  for f in $IGNORE
  do
    if [ "$f" == "$b" ]; then
      return 1
    fi
  done
  return 0
}

# process all . files
for x in $DIR/.*
do
  ignore $x
  if [ $? -eq 1 ]; then
    continue
  fi
  # echo Processing $x
  ln -sfF "${x}" ~/
done

# setup mailrc
if [[ "$OSTYPE" =~ "darwin" ]]; then
  ln -sf "${DIR}/mailrc-osx" ~/.mailrc
else
  ln -sf "${DIR}/mailrc" ~/.mailrc
fi

# process any other files
ln -sf "${DIR}/config" ~/.ssh/config
mkdir -p $HOME/.config/alacritty
ln -sf "${DIR}/alacritty.yml" $HOME/.config/alacritty/alacritty.yml

# setup zsh
mkdir -p $HOME/.zsh

