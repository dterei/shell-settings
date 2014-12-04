# Zsh Shell Config
# Designed to be shared among different shells and computers
#
# Author: David Terei

####################
# LOAD OTHER FILES #
####################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

autoload -U zsh/pcre
autoload -U zmv

# Alias definitions.
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

if [ -f /etc/zsh_command_not_found ]; then
	source /etc/zsh_command_not_found
fi

####################
# GENERAL SETTINGS #
####################

setopt nobeep      # don't beep

setopt autocd      # change to dirs without cd
setopt autopushd   # auto append dirs to push/pop list
setopt pushdminus  # swap meaning of +, - keys for dir stack
setopt pushdsilent # don't print dir stack after push/pop

setopt autoresume   # allow resume of job by typing command name
setopt longlistjobs # list jobs in long format
setopt notify       # report status of background processes immediately
unsetopt bgnice     # Don't run background jobs at lower priority
setopt multios      # allow multi output directs (e.g like tee)

setopt glob extendedglob # extended pattern matching
setopt numericglobsort   # sort glob patterns numerically

setopt mailwarning # print warning about new mail

setopt rcquotes    # allow '' to specify an escape '

# Emacs or Vim key bindings
bindkey -e

# Make C-w use directory structure
WORDCHARS=''

# Short delay on waiting for <ESC> to mean escape a char
KEYTIMEOUT=1

# Load mime setup
autoload -U zsh-mime-setup
zsh-mime-setup

####################
# HISTORY SETTINGS #
####################

HISTFILE=~/.zsh/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY # SHARE_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY # puts timestamps in history
setopt HISTIGNOREDUPS


#######################
# COMPLETION SETTINGS #
#######################

setopt recexact # in completion, recognise exact matches

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
zmodload -i zsh/complist

# Cache zsh tab-completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache 
# Make completion style a little nicer looking
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 
zstyle ':completion:*:*:*:*:*' menu yes select

# Control the menu completion with zstyle
setopt no_menu_complete nolistbeep
# Ksh like binding
bindkey -M viins "\e\\" complete-word
# Without this everything gets mixed up for _expand
zstyle ':completion:*:*:*:*' group-name ''
zstyle ':completion:*' completer _expand _complete _match _correct _approximate
# Below may need adjusting, if you type ae<tab> it gives bad results
# Giving you all 2 letter commands
zstyle ':completion:*' max-errors 4 not-numeric
# I never seen this prompt, where should it appear?
# Corrections still work, ie cd /u/l/s/zsh<Tab> works
zstyle ':completion:*' prompt 'Made %e corrections'
zstyle ':completion:*:expand:*:*' tag-order 'all-expansions expansions'
zstyle ':completion:*:*:*:*' group-order all-expansions expansions 
# This enables menu completion, but on the 2nd tab only
# Select without =1 does not work the same way
zstyle ':completion:*:*:*:*' menu select=1
zstyle ':completion:*:*:*:*' verbose yes
# Without below glob in the middle does not work
zstyle ':completion:*:*:*:*' list-suffixes yes

# Alt-backspace to undo
bindkey -M menuselect "\M-^?" undo
bindkey -M menuselect "^Z" undo
# Incremental search forward and backward like in emacs 
# (requires stty -ixon)
bindkey -M menuselect "^S" history-incremental-search-forward
bindkey -M menuselect "^R" history-incremental-search-backward
bindkey -M menuselect "^N" vi-insert
# Shift-tab go backward
bindkey -M menuselect "\e[Z" up-line-or-history
# C-Space
bindkey -M menuselect "^@"  accept-and-infer-next-history
# Make enter exit menu selection and do actual command
# Instead of just exiting the menu selection
bindkey -M menuselect "^M" .accept-line
# Sort files by date and follow symlinks
#zstyle ':completion:*:*:*:*' file-sort date follow
compinit -C
# I like my Esc/ search very much, put it back
bindkey -rM viins "\e/" 

# Load known hosts file for auto-completion with ssh and scp commands
if [ -f ~/.ssh/known_hosts ]; then
  zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
  zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/$1/' ~/.ssh/known_hosts`
fi

# Prompt display
autoload -U promptinit
autoload colors; colors; colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi
setopt prompt_subst
promptinit


################
# KEY SETTINGS #
################

bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search


#######################
# APPEARANCE SETTINGS #
#######################

HOST_SHOW=""
[[ -n $SSH_CLIENT ]] && HOST_SHOW+="%{$fg_bold[white]%}%m: "

 
# PROMPT="%{$reset_color%}[$HOST_SHOW%{$fg[green]%}➜ %{$reset_color%}%{$fg_bold[blue]%}%c%(0?..%{$fg_bold[red]%} %?)%{$reset_color%}] "
PROMPT="%{$reset_color%}[$HOST_SHOW%{$reset_color%}%c%(0?..%{$fg_bold[red]%} %?)%{$reset_color%}] "

RPROMPT="%{$fg_bold[green]%}%~%{$reset_color%}"


##################
# ZSH COMPLETERS #
##################

if [[ -d ~/Settings/zsh-completes/ ]]; then
  for f in `ls ~/Settings/zsh-completes/`; do
    source ~/Settings/zsh-completes/$f
  done
fi

if [ -d ${HOME}/Software/google-cloud-sdk/ ]; then
  source '/Users/davidt/Software/google-cloud-sdk/completion.zsh.inc'
fi

