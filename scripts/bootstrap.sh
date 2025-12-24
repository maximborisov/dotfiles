#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Detect package manager and install packages
install_packages() {
    info "Installing required packages..."

    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y zsh git curl wget
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y zsh git curl wget
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y zsh git curl wget
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm zsh git curl wget
    elif command -v apk >/dev/null 2>&1; then
        sudo apk add zsh git curl wget
    elif command -v brew >/dev/null 2>&1; then
        brew install zsh git curl wget
    else
        warn "Package manager not detected. Please install zsh, git, curl manually."
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        info "Oh My Zsh already installed, skipping..."
    else
        info "Installing Oh My Zsh..."
        RUNZSH=no KEEP_ZSHRC=yes sh -c \
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

# Install zsh plugins
install_plugins() {
    info "Installing zsh plugins..."

    # zsh-autosuggestions
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    else
        info "zsh-autosuggestions already installed"
    fi

    # zsh-syntax-highlighting
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting \
            "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    else
        info "zsh-syntax-highlighting already installed"
    fi

    # zsh-completions
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
        info "Installing zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions \
            "$ZSH_CUSTOM/plugins/zsh-completions"
    else
        info "zsh-completions already installed"
    fi
}

# Backup existing files
backup_existing() {
    local file=$1
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        info "Backing up existing $file to ${file}.backup"
        mv "$file" "${file}.backup"
    fi
}

# Create symlinks
create_symlinks() {
    info "Creating symlinks..."

    # Backup and link .zshrc
    backup_existing "$HOME/.zshrc"
    ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    info "Linked ~/.zshrc"

    # Link .gitconfig if exists
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
        backup_existing "$HOME/.gitconfig"
        ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
        info "Linked ~/.gitconfig"
    fi
}

# Change default shell to zsh
change_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        info "Changing default shell to zsh..."
        chsh -s "$(which zsh)" || warn "Failed to change shell. Run: chsh -s \$(which zsh)"
    else
        info "zsh is already the default shell"
    fi
}

# Main
main() {
    echo "================================"
    echo "  Dotfiles Bootstrap Script"
    echo "================================"
    echo ""

    # Check if dotfiles directory exists
    if [ ! -d "$DOTFILES_DIR" ]; then
        error "Dotfiles directory not found at $DOTFILES_DIR"
    fi

    install_packages
    install_oh_my_zsh
    install_plugins
    create_symlinks
    change_shell

    echo ""
    info "Bootstrap complete!"
    info "Log out and log back in, or run: exec zsh"
}

main "$@"
