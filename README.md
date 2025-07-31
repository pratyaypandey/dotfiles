# Pratyay's Dotfiles
I couldn't be bothered with making a README. Here's what Cursor thinks: 
> A curated collection of my development environment configuration files, featuring a powerful Neovim setup optimized for LaTeX, Python, and general development.

## 🚀 Features

### Neovim Configuration
- **Plugin Manager**: Lazy.nvim for fast and efficient plugin management
- **Theme**: Kanagawa Dragon theme for a beautiful, eye-friendly experience
- **LSP**: Full Language Server Protocol support with Mason
- **Completion**: nvim-cmp with UltiSnips integration
- **File Explorer**: NvimTree with git integration
- **UI Enhancements**: Noice.nvim for better UI, Trouble for diagnostics
- **Code Formatting**: Conform.nvim with auto-format on save
- **Productivity**: Hardtime.nvim to improve vim habits

### LaTeX Support
- **VimTeX**: Comprehensive LaTeX support with live compilation
- **UltiSnips**: Extensive snippet collection for LaTeX
- **SymPy Integration**: Python math evaluation to LaTeX
- **Auto-cleanup**: Automatic cleanup of auxiliary files
- **Beamer Support**: Presentation templates and shortcuts

### Emacs Configuration
- **Doom Emacs**: Complete Doom Emacs configuration with custom modules
- **Custom Config**: Personalized Emacs setup with custom functions and keybindings
- **Package Management**: Straight.el for package management
- **Themes and UI**: Custom themes and UI enhancements

### Key Bindings
- `<leader>e` / `<leader>E`: Toggle file explorer
- `<leader>f`: Format buffer
- `<leader>xx`: Toggle diagnostics
- `<leader>ht`: Toggle Hardtime
- `<C-s>`: Save file (works in insert and normal mode)
- `<C-l>`: Insert LaTeX line break (in .tex files)

## 📦 Installation

### Prerequisites
- Neovim (0.9.0 or higher)
- Git
- A C compiler (for tree-sitter)
- Python 3 (for UltiSnips)

### Quick Install
```bash
# Clone the repository
git clone https://github.com/pratyaypandey/dotfiles.git ~/Code/dotfiles

# Run the install script
cd ~/Code/dotfiles
./install.sh
```

### Manual Installation
```bash
# Create necessary directories
mkdir -p ~/.config/nvim

# Copy nvim configuration
cp -r ~/Code/dotfiles/nvim/* ~/.config/nvim/

# Install plugins (first time you open nvim)
nvim --headless -c "Lazy! sync" -c "qa"
```

## 🛠️ Dependencies

### System Dependencies
```bash
# macOS (using Homebrew)
brew install neovim git ripgrep fd

# Ubuntu/Debian
sudo apt install neovim git ripgrep fd-find

# Arch Linux
sudo pacman -S neovim git ripgrep fd
```

### Language Servers (auto-installed via Mason)
- pyright (Python)
- clangd (C/C++)
- texlab (LaTeX)
- dockerls (Docker)

### Formatters (auto-installed via Conform)
- black (Python)
- isort (Python)
- prettier (JavaScript/TypeScript/Web)
- stylua (Lua)
- latexindent (LaTeX)
- shfmt (Shell)
- clang_format (C/C++)
- gofmt (Go)
- rustfmt (Rust)

## 🎨 Customization

### Adding New Plugins
Edit `nvim/lua/plugins.lua` and add your plugin to the appropriate module or as a standalone plugin.

### Modifying Key Bindings
Key bindings are defined in their respective module files:
- General bindings: `nvim/init.lua`
- UI bindings: `nvim/lua/ui.lua`
- LSP bindings: `nvim/lua/lsp.lua`

### LaTeX Snippets
Customize LaTeX snippets in `nvim/UltiSnips/tex.snippets`. The file includes:
- Smart bracket snippets
- Color text shortcuts
- Document templates
- Beamer presentation templates
- SymPy integration for math

### Workflow for Updates
The install script creates symlinks from `~/.config/` to `~/Code/dotfiles/` for one-way synchronization:

- `~/.config/nvim` → `~/Code/dotfiles/nvim`
- `~/.config/doom` → `~/Code/dotfiles/doom`
- `~/.config/emacs` → `~/Code/dotfiles/emacs`

#### One-Way Workflow (Recommended)
```bash
# Edit in .config (changes automatically sync to dotfiles)
nvim ~/.config/nvim/init.lua
nvim ~/.config/doom/config.el
nvim ~/.config/emacs/early-init.el

# Changes are immediately reflected in dotfiles!
# Then commit and push
cd ~/Code/dotfiles
git add .
git commit -m "Update configuration"
git push
```

#### For Others (Cloning)
```bash
# Clone and install
git clone https://github.com/pratyaypandey/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
./install.sh  # Creates symlinks for one-way sync
```

## 📁 Structure

```
dotfiles/
├── nvim/
│   ├── init.lua              # Main configuration
│   ├── lua/
│   │   ├── plugins.lua       # Plugin management
│   │   ├── lsp.lua          # LSP configuration
│   │   ├── completion.lua   # Completion setup
│   │   ├── ui.lua           # UI plugins
│   │   └── latex.lua        # LaTeX support
│   └── UltiSnips/
│       └── tex.snippets     # LaTeX snippets
├── doom/                    # Doom Emacs configuration
│   ├── config.el            # Custom configuration
│   ├── init.el              # Module initialization
│   └── packages.el          # Package declarations
├── emacs/                   # Emacs configuration
│   ├── early-init.el        # Early initialization
│   ├── .doomrc              # Doom configuration
│   └── lisp/                # Custom Lisp functions
├── install.sh               # Installation script
└── README.md               # This file
```

## 🔧 Troubleshooting

### Common Issues

1. **Plugins not loading**: Run `:Lazy sync` in Neovim
2. **LSP not working**: Run `:Mason` and install required language servers
3. **Formatters not working**: Install system dependencies (see above)
4. **UltiSnips not working**: Ensure Python 3 is installed and accessible

### Reset Configuration
```bash
# Remove current nvim config
rm -rf ~/.config/nvim

# Reinstall from dotfiles
./install.sh
```

### Making Changes
Since your configurations are symlinked from `.config` to the dotfiles directory, you can edit files in their natural location:

```bash
# Edit any configuration file in .config
nvim ~/.config/nvim/init.lua
nvim ~/.config/doom/config.el
nvim ~/.config/emacs/early-init.el

# Changes are immediately active and automatically synced to dotfiles
```

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Fast plugin manager
- [Kanagawa](https://github.com/rebelot/kanagawa.nvim) - Beautiful theme
- [VimTeX](https://github.com/lervag/vimtex) - LaTeX support
- [UltiSnips](https://github.com/SirVer/ultisnips) - Snippet engine

---

**Happy coding! 🎉** 
