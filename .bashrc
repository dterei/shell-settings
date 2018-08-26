# Bash Shell Config
#
# Designed to be shared among different shells and computers
#
# Author: David Terei

####################
# LOAD OTHER FILES #
####################

# clear all aliases in case any of ours override programs bash needs to load
unalias -a

# Environment variables
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
[[ $- != *i* ]] && return


####################
# GENERAL SETTINGS #
####################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# change directory without cd
shopt -s autocd


####################
# HISTORY SETTINGS #
####################

# don't put duplicate lines in the history. See bash(1) for more options
# ... and ignore same sucessive entries.
#export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend


#######################
# APPEARANCE SETTINGS #
#######################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color|xterm-256color|screen-256color)
	PS1='[\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]] '
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

# Dircolors
if [ -f ~/.dir_colors/dircolors ]
  then eval `dircolors ~/.dir_colors/dircolors`
fi


#######################
# COMPLETION SETTINGS #
#######################

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# Google Cloud SDK
if [ -d /opt/google-cloud-sdk/ ]; then
  source '/opt/google-cloud-sdk/path.bash.inc'
  source '/opt/google-cloud-sdk/completion.bash.inc'
fi

# Azure CLI
source '/home/davidt/lib/azure-cli/az.completion'

# FZF
if [ -d /usr/share/fzf/ ]; then
  source '/usr/share/fzf/key-bindings.bash'
  source '/usr/share/fzf/completion.bash'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Alias definitions
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

