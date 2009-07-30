# Zsh Shell Config
# Designed to be shared among different shells and computers
#
# Author: David Terei
# Last Modified: 21/06/2009

# Environment variables
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
setopt autocd
setopt extendedglob

# Emacs or Vim keybindings
#bindkey -v
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#### USER CONFIG #####

#cache zsh tab-completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache 
#make completion style a little nicer looking
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 

#command correction
setopt correctall

#nice prompt
autoload -U promptinit
promptinit
export PROMPT=$'%m %(0?..%{\e[0;31m%}%?)%(1j.%{\e[0;32m%}%j.)%{\e[0;33m%}%16<...<%~%<<%{\e[0;36m%}%#%{\e[0m%} '

# Alias definitions.
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

# Ssh agent
if [ -f ~/.ssh_startup.sh ]; then
	source ~/.ssh_startup.sh
fi

