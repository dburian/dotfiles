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
export MYSQL_HISTFILE="/dev/null"

## Clipboard manager - clipmenu
export CM_LAUNCHER="rofi"
export CM_HISTLENGTH=10

## NPM
PATH="$XDG_DATA_HOME/node_modules/bin:$PATH"
export npm_config_prefix="$XDG_DATA_HOME"/node_modules
export userconfig="$XDG_DATA_HOME"/npm

## Locations
export wiki="/home/dburian/Documents/wiki"
export dotfiles="/home/dburian/Documents/dotfiles"


# Aliases
alias l="ls -lah"
alias v="nvim"
alias clipmenu="clipmenu -dmenu -p Clipmenu"
alias rofi="rofi -show combi"

alias ssh="TERM=xterm-color ssh"


