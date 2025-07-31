#!/bin/bash

# Pratyay's Dotfiles Update Script
# This script syncs changes from the actual config locations back to the dotfiles repo

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_status "Starting dotfiles update..."

# Function to sync a configuration directory
sync_config() {
    local config_name="$1"
    local source_dir="$2"
    local target_dir="$3"
    
    if [ -d "$source_dir" ]; then
        print_status "Updating $config_name configuration..."
        
        # Check if source is a symlink
        if [ -L "$source_dir" ]; then
            local link_target=$(readlink "$source_dir")
            if [[ "$link_target" == "$target_dir" ]]; then
                print_status "$config_name is already symlinked to dotfiles - no need to sync"
                return
            fi
        fi
        
        # Sync changes from .config to dotfiles
        rsync -av --delete --exclude='.git' --exclude='.local' --exclude='eln-cache' --exclude='lazy-lock.json' --exclude='plugin/' --exclude='lazy/' "$source_dir/" "$target_dir/"
        print_success "$config_name configuration updated"
    else
        print_warning "$config_name configuration not found at $source_dir"
    fi
}

# Sync all configurations
sync_config "Neovim" ~/.config/nvim "$DOTFILES_DIR/nvim"
sync_config "Doom Emacs" ~/.config/doom "$DOTFILES_DIR/doom"
sync_config "Emacs" ~/.config/emacs "$DOTFILES_DIR/emacs"

# Update zsh configuration (if exists)
if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
    print_status "Updating Zsh configuration..."
    mkdir -p "$DOTFILES_DIR/zsh"
    cp ~/.zshrc "$DOTFILES_DIR/zsh/.zshrc"
    print_success "Zsh configuration updated"
fi

# Update git configuration (if exists)
if [ -f ~/.gitconfig ] && [ ! -L ~/.gitconfig ]; then
    print_status "Updating Git configuration..."
    mkdir -p "$DOTFILES_DIR/git"
    cp ~/.gitconfig "$DOTFILES_DIR/git/.gitconfig"
    print_success "Git configuration updated"
fi

print_success "Update completed successfully!"
print_status ""
print_status "Next steps:"
print_status "  git add ."
print_status "  git commit -m 'Update dotfiles'"
print_status "  git push"
print_status ""
print_status "Tip: You can also edit files directly in ~/Code/dotfiles/ and then run this script"
print_status "to sync any changes made outside the dotfiles directory." 