# Zsh Enviornment file
#
# Loaded: always
#
# Designed to be shared among different shells and computers
#
# Author: David Terei

# All else in .shenv to share between shells and get around
# normal stupid unix bashrc/profile loading issues.
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi
