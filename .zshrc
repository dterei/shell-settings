# Zsh Shell Config
#
# Loaded: interactive shell
#
# Designed to be shared among different shells and computers
#
# Author: David Terei

####################
# LOAD OTHER FILES #
####################

# If not running interactively, don't do anything - shouldn't be needed, as
# zshrc isn't loaded when non-interactive, but just be safe
[ -z "$PS1" ] && return
[[ $- != *i* ]] && return

autoload -U  zmv
autoload -U  zcalc
autoload -U  zargs
autoload -Uz insert-composed-char

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
HISTSIZE=50000
SAVEHIST=$HISTSIZE
setopt SHARE_HISTORY      # share history live across sessions (implies append + incremental)
setopt EXTENDED_HISTORY   # record timestamps in history
setopt HIST_IGNORE_DUPS   # don't record a line matching the previous one
setopt HIST_IGNORE_SPACE  # don't record commands that start with a space
setopt HIST_REDUCE_BLANKS # strip extra whitespace before recording
setopt HIST_FIND_NO_DUPS  # skip duplicates when searching with Ctrl+P
setopt HIST_VERIFY        # expand history (!!) before executing, not immediately


#######################
# COMPLETION SETTINGS #
#######################

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

setopt recexact # in completion, recognise exact matches

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
# Only rebuild the completion dump (with its slow security scan) when it's
# missing or over a day old; otherwise reuse it via -C for fast startup.
_zcompdump=~/.zsh/.zcompdump
if [[ -f $_zcompdump && -n $(find "$_zcompdump" -mtime -1 2>/dev/null) ]]; then
  compinit -C -d "$_zcompdump"
else
  compinit -d "$_zcompdump"
fi
unset _zcompdump

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
# I like my Esc/ search very much, put it back
bindkey -rM viins "\e/"

# Load known hosts file for auto-completion with ssh and scp commands
if [ -f ~/.ssh/known_hosts ]; then
  zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
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
bindkey '^t' accept-and-hold


#################
# UNICODE INPUT #
#################

# bindy to F5
zle -N insert-composed-char
bindkey '\e[15~' insert-composed-char


#######################
# APPEARANCE SETTINGS #
#######################

HOST_SHOW=""
[[ -n $SSH_CLIENT ]] && HOST_SHOW+="%{$fg_bold[white]%}%m: "
PROMPT="%{$reset_color%}[$HOST_SHOW%{$reset_color%}%c%(0?..%{$fg_bold[red]%} %?)%{$reset_color%}] "
RPROMPT="%{$fg_bold[green]%}%~%{$reset_color%}"

##################
# ZSH COMPLETERS #
##################

# General completions
if [[ -d ~/.zsh/zsh-completes/ ]]; then
  for f in ~/.zsh/zsh-completes/*(N); do
    source "$f"
  done
fi

# Google Cloud
if [ -d /opt/google-cloud-sdk/ ]; then
  source '/opt/google-cloud-sdk/path.zsh.inc'
  source '/opt/google-cloud-sdk/completion.zsh.inc'
fi

# Azure CLI (completion normally loads via the site-functions FPATH above)
if [ -f /opt/az/bin/az.completion.sh ]; then
  source '/opt/az/bin/az.completion.sh' 1> /dev/null;
fi

# FZF
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
elif [ -d /usr/share/fzf/ ]; then
  source '/usr/share/fzf/key-bindings.zsh'
  source '/usr/share/fzf/completion.zsh'
elif [ -d /opt/homebrew/opt/fzf ]; then
  source '/opt/homebrew/opt/fzf/shell/key-bindings.zsh'
  source '/opt/homebrew/opt/fzf/shell/completion.zsh'
fi

# Kubectl (cache the completion so we don't shell out to kubectl on every
# startup; regenerate when the kubectl binary is newer than the cache)
if [ $commands[kubectl] ]; then
  _kubecomp=~/.zsh/cache/kubectl.zsh
  if [[ ! -s $_kubecomp || $commands[kubectl] -nt $_kubecomp ]]; then
    mkdir -p "${_kubecomp:h}"
    kubectl completion zsh > "$_kubecomp"
  fi
  source "$_kubecomp"
  unset _kubecomp
fi

########################
# ZSH-AUTOSUGGESTIONS  #
########################

_zas_paths=(
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
)
for _p in $_zas_paths; do
  if [ -f "$_p" ]; then
    source "$_p"
    break
  fi
done
unset _zas_paths _p

##########################
# ZSH-SYNTAX-HIGHLIGHTING #
##########################

# Must be sourced last
_zsh_paths=(
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)
for _p in $_zsh_paths; do
  if [ -f "$_p" ]; then
    source "$_p"
    break
  fi
done
unset _zsh_paths _p

##########
# ZOXIDE #
##########

if [ $commands[zoxide] ]; then
  eval "$(zoxide init zsh)"
fi

###########
# DIRENV  #
###########

if [ $commands[direnv] ]; then
  eval "$(direnv hook zsh)"
fi
