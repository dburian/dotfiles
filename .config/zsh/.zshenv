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
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

## Clipboard manager - clipmenu
export CM_LAUNCHER="rofi"
export CM_HISTLENGTH=10

## NPM
export npm_config_prefix="$XDG_DATA_HOME"/node_modules
export userconfig="$XDG_DATA_HOME"/npm

## JAVA
# relink /usr/lib/jvm/default
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/jre'
# export JAVA_HOME='/usr/lib/jvm/java-16-openjdk'

## FLUTTER development
export CHROME_EXECUTABLE=`which google-chrome-stable`
export PATH="/opt/android-sdk/emulator:$PATH"

## Locations
export wiki="/home/dburian/Documents/wiki"
export dotfiles="/home/dburian/Documents/dotfiles"

# Aliases
alias l="ls -lah"
alias v="nvim"
alias clipmenu="clipmenu -dmenu -p Clipmenu"
alias rofi="rofi -show combi"

alias ssh="TERM=xterm-color ssh"

alias z="zathura --fork"

## Python related
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="activate_virtual_environment"


