# Environment variables
## Programs
export EDITOR="nvim"

## Helpful constants
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache

## Cleaning ~
export XAUTHORITY="$XDG_CONFIG_HOME"/X11/Xauthority
export LESSHISTFILE="/dev/null"
export MYSQL_HISTFILE="/dev/null"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GHCUP_USE_XDG_DIRS='yes'
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_CACHE_HOME"/cabal

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
export dots="/home/dburian/Documents/dotfiles"

## Shortcuts
alias l="ls -lah"
alias v="nvim"
alias z="zathura --fork"
alias activate="activate_virtual_environment"
alias d="directory"
alias f="edit-file"

## Always with these flags
alias clipmenu="clipmenu -dmenu -p Clipmenu"
alias rofi="rofi -show combi"
alias ssh="TERM=xterm-color ssh"
alias pip="pip3"


