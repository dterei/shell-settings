# Zsh Profile file
#
# Loaded: login shell
#
# Designed to be shared among different shells and computers
#
# Author: David Terei

# Google Cloud SDK.
if [ -f '/home/davidt/Projects/google-cloud-sdk/path.zsh.inc' ]; then
  source '/home/davidt/Projects/google-cloud-sdk/path.zsh.inc'
fi

# See [ NOTE: Arch & Zsh Stupidity ].
# All else in .shenv to share between shells and get around
# normal stupid unix bashrc/profile loading issues.
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi
