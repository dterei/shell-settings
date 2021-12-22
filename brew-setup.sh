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
  curl \
  ctags \
  docker \
  dropbox \
  fd \
  fzf \
  gcc \
  git \
  go \
  gpg \
  microsoft-office \
  notion \
  pkg-config \
  poetry \
  pyenv \
  rectangle \
  ripgrep \
  signal \
  homebrew/cask/spark \
  spotify \
  svn \
  subversion \
  tmux \
  vim \
  wget \
  zplug"

# 3. Install fonts
/bin/bash -c "arch -arm64 brew install \
  homebrew/cask-fonts/font-source-code-pro \
  homebrew/cask-fonts/font-source-code-pro-for-powerline"
