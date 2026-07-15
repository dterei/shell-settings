#!/usr/bin/env bash

# 1. Install brew
test -x /usr/local/bin/brew || \
  test -x /opt/homebrew/bin/brew || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install usual packages
/bin/bash -c "arch -arm64 brew install \
  alacritty \
  bat \
  claude-code \
  contexts \
  ctags \
  curl \
  direnv \
  docker \
  dropbox \
  fd \
  font-sauce-code-pro-nerd-font \
  fzf \
  gcc \
  git \
  go \
  gpg \
  homebrew/cask/spark \
  jq \
  microsoft-office \
  neovim \
  notion \
  pkg-config \
  poetry \
  pyenv \
  raycast \
  rectangle \
  ripgrep \
  shellcheck \
  signal \
  spotify \
  subversion \
  tmux \
  vim \
  wget"
