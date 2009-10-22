# Zsh Shell Config
# Designed to be shared among different shells and computers
#
# Author: David Terei
# Last Modified: 21/10/2009

# Environment variables
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History settings
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY # SHARE_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY # puts timestamps in history
setopt HISTIGNOREDUPS

# shell settings
setopt autocd # change to dirs without cd
setopt autolist
#setopt correctall
setopt nobeep # don't beep
setopt autopushd # auto append dirs to push/pop list
setopt autoresume 
setopt cdablevars # avoid the need for an explicit $ for cd to vars
#setopt correct # spelling correction
setopt extendedglob # extended pattern matching
#setopt globdots # pattern match against . files
setopt longlistjobs
setopt mailwarning
setopt notify
setopt pushdminus
setopt pushdsilent
setopt pushdtohome
setopt rcquotes
setopt recexact

unsetopt autoparamslash
unsetopt bgnice

# Emacs or Vim keybindings
#bindkey -v
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

#cache zsh tab-completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache 
#make completion style a little nicer looking
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 

#nice prompt
autoload -U promptinit
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"
promptinit
PS1="[$PR_LIGHT_GREEN%n$PR_NO_COLOR:%(0?..$PR_RED%?$PR_NO_COLOR)$PR_LIGHT_BLUE%16<...<%~%<<$PR_NO_COLOR%(!.#.]) "
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"

# Alias definitions.
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

# Ssh agent
if [ -f ~/.ssh_startup.sh ]; then
	source ~/.ssh_startup.sh
fi

