# Zsh Profile file
#
# Loaded: login shell
#
# Designed to be shared among different shells and computers
#
# Author: David Terei

# See [ NOTE: Arch & Zsh Stupidity ].
# All else in .shenv to share between shells and get around
# normal stupid unix bashrc/profile loading issues.
if [ -f ~/.shenv ]; then
  echo "yes"
	source ~/.shenv
fi
