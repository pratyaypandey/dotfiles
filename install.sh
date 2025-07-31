#!/bin/bash

# Pratyay's Dotfiles Installer
# This script installs the dotfiles to their proper locations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to backup existing configuration
backup_config() {
    local config_path="$1"
    local backup_path="$2"
    
    if [ -e "$config_path" ]; then
        print_warning "Found existing configuration at $config_path"
        if [ ! -e "$backup_path" ]; then
            print_status "Creating backup at $backup_path"
            mv "$config_path" "$backup_path"
        else
            print_warning "Backup already exists at $backup_path, removing old config"
            rm -rf "$config_path"
        fi
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -L "$target" ]; then
        print_status "Removing existing symlink at $target"
        rm "$target"
    fi
    
    print_status "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Main installation function
main() {
    print_status "Starting dotfiles installation..."
    
    # Get the directory where this script is located
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    print_status "Dotfiles directory: $DOTFILES_DIR"
    
    # Check prerequisites
    print_status "Checking prerequisites..."
    
    if ! command_exists nvim; then
        print_error "Neovim is not installed. Please install it first."
        print_status "On macOS: brew install neovim"
        print_status "On Ubuntu/Debian: sudo apt install neovim"
        print_status "On Arch: sudo pacman -S neovim"
        exit 1
    fi
    
    if ! command_exists git; then
        print_error "Git is not installed. Please install it first."
        exit 1
    fi
    
    print_success "Prerequisites check passed"
    
    # Create necessary directories
    print_status "Creating necessary directories..."
    mkdir -p ~/.config
    
    # Backup and install nvim configuration
    print_status "Installing Neovim configuration..."
    backup_config ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
    
    # Copy nvim configuration
    cp -r "$DOTFILES_DIR/nvim" ~/.config/
    print_success "Neovim configuration installed"
    
    # Create a symlink for easy updates (optional)
    if [ ! -L ~/.config/nvim ]; then
        print_status "Creating symlink for easy updates..."
        rm -rf ~/.config/nvim
        ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim
        print_success "Symlink created: ~/.config/nvim -> $DOTFILES_DIR/nvim"
    fi
    
    # Install Emacs/Doom configuration with symlinks
    if [ -d "$DOTFILES_DIR/doom" ]; then
        print_status "Installing Doom Emacs configuration..."
        backup_config ~/.config/doom ~/.config/doom.backup.$(date +%Y%m%d_%H%M%S)
        rm -rf ~/.config/doom
        ln -sf "$DOTFILES_DIR/doom" ~/.config/doom
        print_success "Doom Emacs symlink created: ~/.config/doom -> $DOTFILES_DIR/doom"
    fi
    
    if [ -d "$DOTFILES_DIR/emacs" ]; then
        print_status "Installing Emacs configuration..."
        backup_config ~/.config/emacs ~/.config/emacs.backup.$(date +%Y%m%d_%H%M%S)
        rm -rf ~/.config/emacs
        ln -sf "$DOTFILES_DIR/emacs" ~/.config/emacs
        print_success "Emacs symlink created: ~/.config/emacs -> $DOTFILES_DIR/emacs"
    fi
    
    # Install plugins
    print_status "Installing Neovim plugins..."
    if nvim --headless -c "Lazy! sync" -c "qa" 2>/dev/null; then
        print_success "Neovim plugins installed successfully"
    else
        print_warning "Plugin installation may have failed. You can run ':Lazy sync' manually in Neovim"
    fi
    
    # Create additional useful symlinks (optional)
    print_status "Setting up additional configurations..."
    
    # Zsh configuration (if exists)
    if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
        backup_config ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
        create_symlink "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
        print_success "Zsh configuration linked"
    fi
    
    # Git configuration (if exists)
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
        backup_config ~/.gitconfig ~/.gitconfig.backup.$(date +%Y%m%d_%H%M%S)
        create_symlink "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
        print_success "Git configuration linked"
    fi
    
    print_success "Installation completed successfully!"
    print_status ""
    print_status "Next steps:"
    print_status "1. Open Neovim: nvim"
    print_status "2. Install language servers: :Mason"
    print_status "3. Install formatters as needed"
    print_status "4. Customize your configuration as desired"
    print_status ""
    print_status "For LaTeX support, ensure you have:"
    print_status "- A LaTeX distribution (TeX Live, MiKTeX, etc.)"
    print_status "- latexindent for formatting"
    print_status "- Python 3 for UltiSnips"
    print_status ""
    print_success "Happy coding! 🎉"
}

# Run main function
main "$@" 