#!/bin/bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
timestamp="$(date +%Y%m%d_%H%M%S)"

link_config() {
  source_path="$1"
  target_path="$2"
  mkdir -p "$(dirname "$target_path")"

  if [ -L "$target_path" ]; then
    rm "$target_path"
  elif [ -e "$target_path" ]; then
    mv "$target_path" "${target_path}.backup.${timestamp}"
  fi

  ln -s "$source_path" "$target_path"
  printf 'linked %s -> %s\n' "$target_path" "$source_path"
}

link_config "$dotfiles_dir/zsh/.zshrc" "$HOME/.zshrc"
link_config "$dotfiles_dir/zsh/.zprofile" "$HOME/.zprofile"
link_config "$dotfiles_dir/zsh/.profile" "$HOME/.profile"
link_config "$dotfiles_dir/git/.gitconfig" "$HOME/.gitconfig"
link_config "$dotfiles_dir/git/ignore" "$HOME/.config/git/ignore"
link_config "$dotfiles_dir/config/uv.toml" "$HOME/.config/uv/uv.toml"
link_config "$dotfiles_dir/config/atuin.toml" "$HOME/.config/atuin/config.toml"
link_config "$dotfiles_dir/config/starship.toml" "$HOME/.config/starship.toml"

printf '\nDotfiles installed. Open a new shell to load them.\n'
