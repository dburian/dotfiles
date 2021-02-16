# Environment variables
## Programs
export EDITOR="nvim"

## Helpful constants
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache

## Cleaning ~
export XAUTHORITY="$XDG_CONFIG_HOME"/X11/.Xauthority
export LESSHISTFILE="/dev/null"
#export VIMINIT='if !has('"'"'nvim'"'"') | let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC | endif'

# Clipboard manager - clipmenu
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=10


# Aliases
alias l="ls -lah"
alias vim="nvim"
