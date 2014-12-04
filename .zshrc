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

if [[ -f ~/Settings/zsh-completes/aws_zsh_completer.sh ]]; then
  source ~/Settings/zsh-completes/aws_zsh_completer.sh
fi

###############
# GO COMPLETE #
###############

# gc
prefixes=(5 6 8)
for p in $prefixes; do
	compctl -g "*.${p}" ${p}l
	compctl -g "*.go" ${p}g
done

# standard go tools
compctl -g "*.go" gofmt

# gccgo
compctl -g "*.go" gccgo

# go tool
__go_tool_complete() {
  typeset -a commands build_flags
  commands+=(
    'build[compile packages and dependencies]'
    'clean[remove object files]'
    'doc[run godoc on package sources]'
    'fix[run go tool fix on packages]'
    'fmt[run gofmt on package sources]'
    'get[download and install packages and dependencies]'
    'help[display help]'
    'install[compile and install packages and dependencies]'
    'list[list packages]'
    'run[compile and run Go program]'
    'test[test packages]'
    'tool[run specified go tool]'
    'version[print Go version]'
    'vet[run go tool vet on packages]'
  )
  if (( CURRENT == 2 )); then
    # explain go commands
    _values 'go tool commands' ${commands[@]}
    return
  fi
  build_flags=(
    '-a[force reinstallation of packages that are already up-to-date]'
    '-n[print the commands but do not run them]'
    "-p[number of parallel builds]:number"
    '-x[print the commands]'
    "-work[print temporary directory name and keep it]"
    "-gcflags[flags for 5g/6g/8g]:flags"
    "-ldflags[flags for 5l/6l/8l]:flags"
    "-gccgoflags[flags for gccgo]:flags"
  )
  __go_list() {
      local expl importpaths
      declare -a importpaths
      importpaths=($(go list ${words[$CURRENT]}... 2>/dev/null))
      _wanted importpaths expl 'import paths' compadd "$@" - "${importpaths[@]}"
  }
  case ${words[2]} in
  clean|doc)
      _arguments -s -w : '*:importpaths:__go_list'
      ;;
  fix|fmt|list|vet)
      _alternative ':importpaths:__go_list' ':files:_path_files -g "*.go"'
      ;;
  install)
      _arguments -s -w : ${build_flags[@]} \
        "-v[show package names]" \
	'*:importpaths:__go_list'
      ;;
  get)
      _arguments -s -w : \
        ${build_flags[@]}
      ;;
  build)
      _arguments -s -w : \
        ${build_flags[@]} \
        "-v[show package names]" \
        "-o[output file]:file:_files" \
        "*:args:{ _alternative ':importpaths:__go_list' ':files:_path_files -g \"*.go\"' }"
      ;;
  test)
      _arguments -s -w : \
        ${build_flags[@]} \
        "-c[do not run, compile the test binary]" \
        "-i[do not run, install dependencies]" \
        "-v[print test output]" \
        "-x[print the commands]" \
        "-short[use short mode]" \
        "-parallel[number of parallel tests]:number" \
        "-cpu[values of GOMAXPROCS to use]:number list" \
        "-run[run tests and examples matching regexp]:regexp" \
        "-bench[run benchmarks matching regexp]:regexp" \
        "-benchtime[run each benchmark during n seconds]:duration" \
        "-timeout[kill test after that duration]:duration" \
        "-cpuprofile[write CPU profile to file]:file:_files" \
        "-memprofile[write heap profile to file]:file:_files" \
        "-memprofilerate[set heap profiling rate]:number" \
        "*:args:{ _alternative ':importpaths:__go_list' ':files:_path_files -g \"*.go\"' }"
      ;;
  help)
      _values "${commands[@]}" \
        'gopath[GOPATH environment variable]' \
        'importpath[description of import paths]' \
        'remote[remote import path syntax]' \
        'testflag[description of testing flags]' \
        'testfunc[description of testing functions]'
      ;;
  run)
      _arguments -s -w : \
          ${build_flags[@]} \
          '*:file:_path_files -g "*.go"'
      ;;
  tool)
      if (( CURRENT == 3 )); then
          _values "go tool" $(go tool)
          return
      fi
      case ${words[3]} in
      [568]g)
          _arguments -s -w : \
              '-I[search for packages in DIR]:includes:_path_files -/' \
              '-L[show full path in file:line prints]' \
              '-S[print the assembly language]' \
              '-V[print the compiler version]' \
              '-e[no limit on number of errors printed]' \
              '-h[panic on an error]' \
              '-l[disable inlining]' \
              '-m[print optimization decisions]' \
              '-o[file specify output file]:file' \
              '-p[assumed import path for this code]:importpath' \
              '-u[disable package unsafe]' \
              "*:file:_files -g '*.go'"
          ;;
      [568]l)
          local O=${words[3]%l}
          _arguments -s -w : \
              '-o[file specify output file]:file' \
              '-L[search for packages in DIR]:includes:_path_files -/' \
              "*:file:_files -g '*.[ao$O]'"
          ;;
      dist)
          _values "dist tool" banner bootstrap clean env install version
          ;;
      *)
          # use files by default
          _files
          ;;
      esac
      ;;
  esac
}

compdef __go_tool_complete go

# The next line updates PATH for the Google Cloud SDK.
if [ -d ${HOME}/Software/google-cloud-sdk/ ]; then
  source '/Users/davidt/Software/google-cloud-sdk/completion.zsh.inc'
fi

