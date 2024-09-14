# Path to your Oh My Zsh installation.
export ZSH="$HOME/.local/share/oh-my-zsh"
. ${HOME}/.config/exports
. ${HOME}/.config/aliases

ZSH_THEME="af-magic"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh