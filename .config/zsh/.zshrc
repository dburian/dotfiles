# Enable colors
autoload -U colors && colors

# For pure prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")

# Pure prompt
autoload -U promptinit; promptinit
PURE_PROMPT_SYMBOL='$'
PURE_PROMPT_VICMD_SYMBOL='?'
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
comp_options+=(globdots) #Autocomplete hidden files

# Batch rename
autoload zmv

# Local definitions
[ -e $XDG_CONFIG_HOME/zsh/local.sh ] && source $XDG_CONFIG_HOME/zsh/local.sh

# functions
source $XDG_CONFIG_HOME/zsh/funcs

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Initializes pyenv so we can use local python versions
# eval "$(pyenv init -)"
