# Bash Shell Config
# Designed to be shared among different shells and computers
#
# Author: David Terei

# clear all aliases in case any of ours override programs bash needs to load
unalias -a

# Environment variables
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... and ignore same sucessive entries.
#export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color|xterm-256color)
	PS1='[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]] '
	;;
*)
	PS1='\u@\h:\w\$ '
	;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
	;;
*)
	;;
esac

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# Ssh agent
if [ -f ~/.ssh_startup.sh ]; then
	source ~/.ssh_startup.sh
fi

# Alias definitions.
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

