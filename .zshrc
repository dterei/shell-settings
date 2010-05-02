# Zsh Shell Config
# Designed to be shared among different shells and computers
#
# Author: David Terei


####################
# LOAD OTHER FILES #
####################

# Environment variables
if [ -f ~/.shenv ]; then
	source ~/.shenv
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Alias definitions.
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

# Ssh agent
if [ -f ~/.ssh_startup.sh ]; then
	source ~/.ssh_startup.sh
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
setopt pushdminus  #swap meaning of +, - keys for dir stack
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

# make C-w use directory structure
WORDCHARS=''


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

#cache zsh tab-completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache 
#make completion style a little nicer looking
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 
#zstyle ':completion:*:*:*:*:*' menu yes select

#control the menu completion with zstyle
setopt no_menu_complete nolistbeep
# ksh like binding
bindkey -M viins "\e\\" complete-word
# without this everything gets mixed up for _expand
zstyle ':completion:*:*:*:*' group-name ''
zstyle ':completion:*' completer _expand _complete _match _correct _approximate
# below may need adjusting, if you type ae<tab> it gives bad results
# giving you all 2 letter commands
zstyle ':completion:*' max-errors 4 not-numeric
# I never seen this prompt, where should it appear?
# corrections still work, ie cd /u/l/s/zsh<Tab> works
zstyle ':completion:*' prompt 'Made %e corrections'
zstyle ':completion:*:expand:*:*' tag-order 'all-expansions expansions'
zstyle ':completion:*:*:*:*' group-order all-expansions expansions 
# this enables menu completion, but on the 2nd tab only
# select without =1 does not work the same way
zstyle ':completion:*:*:*:*' menu select=1
zstyle ':completion:*:*:*:*' verbose yes
# without below glob in the middle does not work
zstyle ':completion:*:*:*:*' list-suffixes yes

# Alt-backspace to undo
bindkey -M menuselect "\M-^?" undo
bindkey -M menuselect "^Z" undo
# Incremental search forward and backward like in emacs 
# (requires stty -ixon)
bindkey -M menuselect "^S" history-incremental-search-forward
bindkey -M menuselect "^R" history-incremental-search-backward
bindkey -M menuselect "^N" vi-insert
# shift-tab go backward
bindkey -M menuselect "\e[Z" up-line-or-history
# C-Space
bindkey -M menuselect "^@"  accept-and-infer-next-history
# Make enter exit menu selection and do actual command
# instead of just exiting the menu selection
bindkey -M menuselect "^M" .accept-line
# sort files by date and follow symlinks
zstyle ':completion:*:*:*:*' file-sort date follow
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


#######################
# APPEARANCE SETTINGS #
#######################

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$GIT_PROMPT_PREFIX${ref#refs/heads/}$(_parse_git_dirty)$GIT_PROMPT_SUFFIX "
}

function _parse_git_dirty () {
  if [[ $( (git status 2> /dev/null) | tail -n1 ) != "nothing to commit (working directory clean)" ]]; then
    echo "$GIT_PROMPT_DIRTY"
  else
    echo "$GIT_PROMPT_CLEAN"
  fi
}

GIT_PROMPT_PREFIX="%{$fg[green]%}git:(%{$fg[red]%}"
GIT_PROMPT_SUFFIX="%{$reset_color%}"
GIT_PROMPT_DIRTY="%{$fg[green]%}) %{$fg[yellow]%}✗%{$reset_color%}"
GIT_PROMPT_CLEAN="%{$fg[blue]%})"

#PROMPT="[%{$fg[green]%}%n%{$reset_color%}:%(0?..%{$fg_bold[red]%}%?%{$reset_color%})%{$fg[blue]%}%16<...<%~%<<%{$reset_color%}%(!.#.]) "
PROMPT='%{$fg[blue]%}%c %(0?..${fg_bold[red]}%? )%{$reset_color%}%{${fg[red]}%}»%{${reset_color}%} '
#PROMPT='%{$fg[blue]%}%c $(git_prompt_info)%(0?..${fg_bold[red]}%? )%{$reset_color%}%{${fg[red]}%}»%{${reset_color}%} '
#PROMPT="%{$reset_color%}[%{$fg[green]%}➜ %{$reset_color%}%{$fg[blue]%}%c%(0?..%{$fg_bold[red]%} %?)%{$reset_color%}] "

#RPROMPT="%{$fg[yellow]%}(%D{%m-%d %H:%M})%{$reset_color%}"
RPROMPT="%{$fg[green]%}%~%{$reset_color%}"

