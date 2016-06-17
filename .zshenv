# Zsh Enviornment file
#
# Loaded: always
#
# Designed to be shared among different shells and computers
#
# Author: David Terei

# =========================
# NOTE: Arch & Zsh Stupidity
# ==========================
# Normally, we'd source `.shenv` to setup up our environment here. But Arch
# dumbly has the global zsh configure scripts setup to reset your path after
# sourcing `.zshenv`. So we must setup our path using `.zprofile`.
#
# This is still a problem, as `.zprofile` isn't sourced when creating non-login
# shells, but in general, we want our path setup regardless.
#
# So, we have to source `.shenv` in both `.zshenv` and `.zprofile` and just
# detect if this is a login shell. If it is, we don't soure `.shenv` here and
# rely on `.zprofile` sourcing it instead.

if [[ ! -o login  ]]; then
  if [ -f ~/.shenv ]; then
    echo "yes"
    source ~/.shenv
  fi
fi
