#!/usr/bin/env bash

# 1. Install brew
test -x /usr/local/bin/brew || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install usual packages
/bin/bash -c "brew install \
  alacritty \
  contexts \
  curl \
  docker \
  dropbox \
  fd \
  font-source-code-pro \
  font-source-code-pro-for-powerline \
  fzf \
  gcc \
  git \
  microsoft-office \
  notion \
  pkg-config \
  poetry \
  pyenv \
  rectangle \
  ripgrep \
  signal \
  spark \
  spotify \
  subversion \
  tmux \
  vim \
  virtualbox \
  wget"
