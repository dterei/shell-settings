#!/usr/bin/env bash

# 1. Install brew
test -x /usr/local/bin/brew || \
  test -x /opt/homebrew/bin/brew || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install usual packages
/bin/bash -c "arch -arm64 brew install \
  alacritty \
  bat \
  contexts \
  ctags \
  curl \
  docker \
  dropbox \
  fd \
  font-source-code-pro \
  font-source-code-pro-for-powerline \
  fzf \
  gcc \
  git \
  go \
  gpg \
  homebrew/cask/spark \
  microsoft-office \
  notion \
  pkg-config \
  poetry \
  pyenv \
  rectangle \
  ripgrep \
  signal \
  spotify \
  subversion \
  svn \
  tmux \
  vim \
  wget \
  zplug"
