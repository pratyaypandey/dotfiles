# Fast, minimal Zsh config

# Keep PATH deterministic and deduplicated.
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  /Library/TeX/texbin
  /opt/homebrew/opt/node@24/bin
  "$HOME/.cargo/bin"
  /opt/homebrew/bin
  /opt/homebrew/sbin
  "$HOME/go/bin"
  $path
)
export PATH

# Rebuild the completion dump at most once per day.
autoload -Uz compinit
_comp_dump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n $_comp_dump(#qNmh+24) ]]; then
  compinit -d "$_comp_dump"
else
  compinit -C -d "$_comp_dump"
fi
unset _comp_dump

# Start Python-backed helpers only when needed.
fuck() { unset -f fuck; eval "$(thefuck --alias)"; fuck "$@"; }

eval "$(/opt/homebrew/bin/zoxide init zsh)"
eval "$(/opt/homebrew/bin/starship init zsh)"
eval "$(atuin init zsh)"

alias mud='open -a "/Applications/Mud.app"'
alias cd="z"
alias zi="z -i"
alias cdd="builtin cd"
alias ls="eza --icons --group-directories-first"
alias ll="eza -lh --git"
alias tree="eza --tree"
alias cat="bat"
