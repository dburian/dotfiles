# Enable colors
autoload -U colors && colors

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Lines configured by zsh-newuser-install
HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000
SAVEHIST=5000

# Vi mode
bindkey -v
export KEYTIMEOUT=1 #For -v recommended

# Edit command in vim # Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) #Autocomplete hidden files

source /home/dburian/.config/broot/launcher/bash/br

# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
