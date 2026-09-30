export PATH="$HOME/.local/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jimmy/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions

# ----------------------------------------------------------------------
# fzf-tab (must load after compinit, before autosuggestions/syntax-highlighting)
# ----------------------------------------------------------------------

source "/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"


# Set personal aliases
# For a full list of active aliases, run `alias`.
#
# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# ----------------------------------------------------------------------
# Colors
# ----------------------------------------------------------------------
if [ -f ~/.bash_colors ]; then
    . ~/.bash_colors
fi

# ----------------------------------------------------------------------
# starship
# ----------------------------------------------------------------------

eval "$(starship init zsh)"

# ----------------------------------------------------------------------
# zsh-autosuggestions
# ----------------------------------------------------------------------

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ----------------------------------------------------------------------
# zsh-syntax-highlighting (must be the last thing sourced in this file)
# ----------------------------------------------------------------------

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
