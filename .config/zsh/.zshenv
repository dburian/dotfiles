# Environment variables
## Programs
export EDITOR="nvim"

## Helpful constants
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache

## PATH
export PATH="$PATH:/usr/lib/jvm/default/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$XDG_DATA_HOME/go/bin"
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
export PATH="$PATH:$HOME/.local/src/lua-language-server/bin"


# export ANDROID_SDK_ROOT='/opt/android-sdk'
# export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
# export PATH=$PATH:$ANDROID_ROOT/emulator
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools/


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
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

## Clipboard manager - clipmenu
export CM_HISTLENGTH=10

## Lua
alias luamake=/home/dburian/.local/src/lua-language-server/3rd/luamake/luamake

## NPM
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/.npmrc
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export PATH="$HOME/.npm_packages/bin":$PATH
export NODE_PATH="$HOME/.npm_packages/lib/node_modules"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"

## JAVA
export JAVA_HOME='/usr/lib/jvm/default'
export _JAVA_AWT_WM_NONREPARENTING=1 #needed for Protege
export CLASSPATH="$XDG_CACHE_HOME/maven/repository/"


## Locations
export dots=~/repos/dotfiles

## Shortcuts
alias l="ls -lah --group-directories-first --color=always"
alias v="nvim"
alias z="zathura --fork"
alias view="setsid feh --draw-filename --draw-tinted --auto-zoom --auto-reload --scale-down"
alias activate="activate_virtual_environment"
alias loc="locate"
alias edit="locate-edit"

## Always with these flags
alias rofi="rofi -show combi"
alias pip="pip3"
alias mvn='mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml'
