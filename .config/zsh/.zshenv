# Environment variables
## Programs
export EDITOR="nvim"

## PATH
#export PATH="$PATH:/usr/lib/jvm/default/bin"
#export PATH="$PATH:/home/dburian/.cache/cabal/bin"
#export PATH="$PATH:$XDG_DATA_HOME/go/bin"
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/.local/bin"

# export ANDROID_SDK_ROOT='/opt/android-sdk'
# export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
# export PATH=$PATH:$ANDROID_ROOT/emulator
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools/

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
export GOPATH="$XDG_DATA_HOME"/go
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv

## Clipboard manager - clipmenu
export CM_LAUNCHER="rofi"
export CM_HISTLENGTH=10

## Lua
alias luamake=/home/dburian/.local/src/lua-language-server/3rd/luamake/luamake

## NPM
export NVM_DIR="$HOME/.config/nvm"

## JAVA
export JAVA_HOME='/usr/lib/jvm/default'
export _JAVA_AWT_WM_NONREPARENTING=1 #needed for Protege
export CLASSPATH="$XDG_CACHE_HOME/maven/repository/"

## FLUTTER development
export CHROME_EXECUTABLE=`which google-chrome-stable`

## Locations
export dots="$HOME/Documents/dotfiles"

## Shortcuts
alias l="ls -lah --color=always"
alias v="nvim"
alias z="zathura --fork"
alias view="setsid feh --draw-filename --draw-tinted --auto-zoom --auto-reload --scale-down"
alias activate="activate_virtual_environment"
alias loc="locate"
alias edit="locate-edit"

## Always with these flags
alias clipmenu="clipmenu -dmenu -p Clipmenu"
alias rofi="rofi -show combi"
alias ssh="TERM=xterm-color ssh"
alias pip="pip3"
alias mvn='mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml'
alias flavours='flavours -c "$XDG_CONFIG_HOME"/flavours/config.toml'
