# Pratyay's dotfiles

This repository is the reproducible source for the workstation's shell and core developer-tool configuration.

## Managed configuration

- Zsh environment and prompt startup
- Git identity, signing, pull/push defaults, and global ignores
- uv's managed-Python policy
- Starship prompt
- Atuin interaction preference

Python projects use uv-managed interpreters. The default JavaScript runtime is Homebrew's Node 24 LTS, with Corepack providing pnpm and Yarn on demand.

## Install

```sh
git clone https://github.com/pratyaypandey/dotfiles.git ~/Code/dotfiles
~/Code/dotfiles/install.sh
```

The installer moves every existing target to a timestamped backup before linking the repository version. It does not install packages or touch application data.

## Package prerequisites

```sh
brew install uv node@24 starship atuin zoxide eza bat git-delta
```

Rust remains managed by rustup. OrbStack supplies Docker and Kubernetes command-line integration.

## Editor configuration

The `nvim/` directory is a historical configuration snapshot and is not installed automatically. The active `~/.config/nvim` checkout is maintained separately so this repository cannot overwrite it accidentally.
