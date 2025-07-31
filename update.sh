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

# Update nvim configuration
if [ -d ~/.config/nvim ]; then
    print_status "Updating Neovim configuration..."
    
    # Check if nvim is symlinked to our dotfiles
    if [ -L ~/.config/nvim ] && [ "$(readlink ~/.config/nvim)" = "$DOTFILES_DIR/nvim" ]; then
        print_status "Neovim is already symlinked to dotfiles - no need to sync"
        print_status "Changes made directly in ~/Code/dotfiles/nvim/ will be reflected immediately"
    else
        # Copy changes from ~/.config/nvim to dotfiles
        rsync -av --exclude='lazy-lock.json' --exclude='plugin/' --exclude='lazy/' ~/.config/nvim/ "$DOTFILES_DIR/nvim/"
        print_success "Neovim configuration updated"
    fi
else
    print_warning "Neovim configuration not found at ~/.config/nvim"
fi

# Update zsh configuration (if exists)
if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
    print_status "Updating Zsh configuration..."
    cp ~/.zshrc "$DOTFILES_DIR/zsh/.zshrc"
    print_success "Zsh configuration updated"
fi

# Update git configuration (if exists)
if [ -f ~/.gitconfig ] && [ ! -L ~/.gitconfig ]; then
    print_status "Updating Git configuration..."
    cp ~/.gitconfig "$DOTFILES_DIR/git/.gitconfig"
    print_success "Git configuration updated"
fi

print_success "Update completed successfully!"
print_status "Don't forget to commit your changes:"
print_status "  git add ."
print_status "  git commit -m 'Update dotfiles'"
print_status "  git push" 