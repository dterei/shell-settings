#!/usr/bin/env bash

# 1. Install brew
test -x /usr/local/bin/brew || \
  test -x /opt/homebrew/bin/brew || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install usual packages
/bin/bash -c "arch -arm64 brew install \
  bat \
  contexts \
  ctags \
  curl \
  direnv \
  fd \
  git-delta \
  font-sauce-code-pro-nerd-font \
  fzf \
  gcc \
  git \
  go \
  gpg \
  jq \
  neovim \
  pkg-config \
  poetry \
  pyenv \
  raycast \
  rectangle \
  ripgrep \
  shellcheck \
  tmux \
  vim \
  wget \
  zsh-autosuggestions \
  zoxide \
  zsh-syntax-highlighting"
