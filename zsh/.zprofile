# OrbStack CLI integration and completions.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

eval "$(/opt/homebrew/bin/brew shellenv)"

# Keg-only Node and user-local shims must also be available to login scripts.
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  /opt/homebrew/opt/node@24/bin
  $path
)
export PATH
