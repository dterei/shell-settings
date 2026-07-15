#!/usr/bin/env bash

# settings location (directory this script resides in, regardless of cwd)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# files to ignore processing
IGNORE=". .. .mailrc .gitignore .git .DS_Store"
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

# process any other files
# ssh config is machine-specific and gitignored (see .gitignore); only
# link it when a local copy exists so a fresh clone doesn't leave a
# dangling ~/.ssh/config symlink.
if [ -f "${DIR}/config" ]; then
  mkdir -p ~/.ssh
  ln -sf "${DIR}/config" ~/.ssh/config
fi
mkdir -p $HOME/.config/alacritty
ln -sf "${DIR}/alacritty.toml" $HOME/.config/alacritty/alacritty.toml
ln -sf "${HOME}/Dropbox/Sensitive/2fa" $HOME/.config/ga

# setup zsh
mkdir -p $HOME/.zsh
ln -sfF "${DIR}/zsh-completes" $HOME/.zsh/zsh-completes
