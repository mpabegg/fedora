#!/usr/local/bin/zsh

# Use emacs keybindings
bindkey -e

# Set up completion caching
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache/"
zstyle ':completion:*' menu select

# Initialize Starship prompt
eval "$(starship init zsh)"

# Add custom function directories to fpath and autoload them
fpath=($ZDOTDIR/functions/**/ $fpath)
autoload -U $ZDOTDIR/functions/**/*(.:t)

# Load zsh/complist module and set completion options
zmodload zsh/complist
_comp_options+=(globdots)

# Load colors
autoload -Uz colors && colors

# Source custom functions and initialize plugins
source "$ZDOTDIR/zsh-functions"
zsh_init_plugins

# Source all .zsh files in the adds directory
for f in $ZDOTDIR/adds/*.zsh(N); do
  source "$f"
done

# Source aliases
source "$ZDOTDIR/alias.zsh"

# Add and configure plugins
zsh_add_plugin "zimfw/environment"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Set keybinding for accepting autosuggestions
bindkey '^Y' autosuggest-accept
set bell-style off

# Set environment variables
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export ARCHFLAGS="-arch $(uname -m)"

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

export PATH="$XDG_DATA_HOME/bob/nvim-bin:$PATH"
