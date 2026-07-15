# AWS CLI completion.
#
# aws-cli v2 ships its own completer binary (aws_completer); wiring it up
# via zsh's bash-completion compat is all that's needed. (The old v1
# helper this file used to contain re-ran `compinit` on every shell, which
# was slow and undid the cached compinit in .zshrc.)
if command -v aws_completer >/dev/null 2>&1; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C aws_completer aws
fi
