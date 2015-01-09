#!/bin/sh

#DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd  )
DIR="$HOME/Settings"

ln -sf "${DIR}/.aliases" ~/.aliases
ln -sf "${DIR}/.bashrc" ~/.bashrc
ln -sf "${DIR}/.gdbinit" ~/.gdbinit
ln -sf "${DIR}/.fluxbox" ~/.fluxbox
ln -sf "${DIR}/.fonts" ~/.fonts
ln -sf "${DIR}/.fonts.conf" ~/.fonts.conf
ln -sf "${DIR}/.ghc" ~/.ghc
ln -sf "${DIR}/.gitconfig" ~/.gitconfig
ln -sf "${DIR}/.gitignore_global" ~/.gitignore_global
ln -sf "${DIR}/.irbrc" ~/.irbrc
ln -sf "${DIR}/.mailrc" ~/.mailrc
ln -sf "${DIR}/.muttrc" ~/.muttrc
ln -sf "${DIR}/.profile" ~/.profile
ln -sf "${DIR}/.screenrc" ~/.screenrc
ln -sf "${DIR}/.scripts/" ~/.scripts
ln -sf "${DIR}/.shenv" ~/.shenv
ln -sf "${DIR}/.tmux.conf" ~/.tmux.conf
ln -sf "${DIR}/.zprofile" ~/.zprofile
ln -sf "${DIR}/.zshrc" ~/.zshrc

ln -sf "${DIR}/.Xresources" ~/.Xresources
ln -sf "${DIR}/.Xmodmap" ~/.Xmodmap

ln -sf "${DIR}/config" ~/.ssh/config

