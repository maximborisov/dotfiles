# Oh My Zsh plugins and theme configuration

# Theme
ZSH_THEME="robbyrussell"

# Plugins
# Note: zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions
# are installed by bootstrap.sh
plugins=(
    git
    z
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Plugin settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
