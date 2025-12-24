# Dotfiles

Personal dotfiles for zsh, git, and other configurations.

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles/scripts
chmod +x bootstrap.sh
./bootstrap.sh
```

## What's Included

### Zsh Configuration

- **`.zshrc`** - Main config, sources modular files
- **`aliases.zsh`** - Shell aliases
- **`exports.zsh`** - Environment variables
- **`plugins.zsh`** - Oh My Zsh plugins and theme

### Plugins (auto-installed)

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)

### Git Configuration

- **`.gitconfig`** - Git aliases and settings

## Structure

```
dotfiles/
├── zsh/
│   ├── .zshrc          # Main zsh config
│   ├── aliases.zsh     # Aliases
│   ├── exports.zsh     # Exports and PATH
│   └── plugins.zsh     # Plugins and theme
├── git/
│   └── .gitconfig      # Git configuration
├── scripts/
│   └── bootstrap.sh    # Installation script
└── README.md
```

## Local Overrides

Create `~/.zshrc.local` for machine-specific settings that won't be tracked:

```bash
# ~/.zshrc.local
export CUSTOM_VAR="value"
alias myalias='mycommand'
```

## Manual Installation

If you prefer not to use the bootstrap script:

1. Install Oh My Zsh:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. Install plugins:
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
   ```

3. Link files:
   ```bash
   ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
   ```

## Updating

```bash
cd ~/dotfiles
git pull
```

Plugins can be updated with:

```bash
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
```
