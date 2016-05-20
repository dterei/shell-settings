# Zsh Enviornment file
#
# Designed to be shared among different shells and computers
#
# Author: David Terei

# If running interactively, don't do anything
[ -n "$PS1" ] && return
[[ $- == *i* ]] && return

# All else in .shenv to share between shells and get around
# normal stupid unix bashrc/profile loading issues.
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi
