# Dotfiles - Main zsh configuration
# This file sources all modular configs

export DOTFILES="$HOME/dotfiles"
export ZDOTDIR="$HOME/.config/zsh"

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Source modular configs
[[ -f $DOTFILES/zsh/exports.zsh ]] && source $DOTFILES/zsh/exports.zsh
[[ -f $DOTFILES/zsh/plugins.zsh ]] && source $DOTFILES/zsh/plugins.zsh

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Source aliases after oh-my-zsh to allow overrides
[[ -f $DOTFILES/zsh/aliases.zsh ]] && source $DOTFILES/zsh/aliases.zsh

# Local overrides (not tracked in git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
