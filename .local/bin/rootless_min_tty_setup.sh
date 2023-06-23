#!/bin/bash
#
# This is a script to setup minimal tty without sudo rights. This setup should include:
#   - bash/zsh
#   - nvim
#
# Prerequisites:
#   - git
#   - gcc or clang, make --- required by fzf extension
#
BASHRC_DIR="$HOME"
ZSHRC_DIR="$HOME"

FZF_BIN="https://github.com/junegunn/fzf/releases/download/0.42.0/fzf-0.42.0-linux_amd64.tar.gz"
FZF_INSTALL_DIR="$HOME/.local/bin"

NVIM_INSTALL_DIR="$HOME/.local/src"
NVIM_BIN="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"

DOTFILES_INSTALL_DIR="$HOME/.local/src"

XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

function setup_bash() {
  rm -f "$HOME"/.bashrc "$HOME"/.profile
  mkdir -p "$BASHRC_DIR"
  cat  > "$BASHRC_DIR"/.bashrc <<EOT
#ENV vars
export XDG_CONFIG_HOME="\$HOME"/.config
export XDG_CACHE_HOME="\$HOME"/.cache
export XDG_DATA_HOME="\$HOME"/.local

export PATH="\$PATH":"\$HOME"/.local/bin
export EDITOR="nvim"

#Aliases
alias l="ls -lah --color=always"
alias v="nvim"
EOT
  cat > "$BASHRC_DIR"/.profile <<EOT
if [ "\$BASH" ]; then
  if [ -f "$BASHRC_DIR"/.bashrc ]; then
    . "$BASHRC_DIR"/.bashrc
  fi
fi

mesg n 2> /dev/null || true
EOT
  source $BASHRC_DIR/.bashrc
}

function setup_zsh() {
  mkdir -p "$ZSHRC_DIR"
  cat > "$ZSHRC_DIR"/.zshrc <<EOT
#ENV vars
export XDG_CONFIG_HOME="\$HOME"/.config
export XDG_CACHE_HOME="\$HOME"/.cache
export XDG_DATA_HOME="\$HOME"/.local/share

export PATH="\$PATH":"\$HOME"/.local/bin
export EDITOR="nvim"

#Aliases
alias l="ls -lah --color=always"
alias v="nvim"
EOT
  source $ZSHRC_DIR/.zshrc
}

function install_fzf() {
  mkdir -p $FZF_INSTALL_DIR
  cd $FZF_INSTALL_DIR

  curl -OL $FZF_BIN
  tarfile=`basename $FZF_BIN`
  tar zxvf $tarfile

  rm $tarfile
}

function install_nvim() {
  # Moving to install location
  mkdir -p $NVIM_INSTALL_DIR
  cd $NVIM_INSTALL_DIR

  # Downdloading nvim
  curl -OL "$NVIM_BIN"

  # Extracting tar file
  tarfile=`basename $NVIM_BIN`
  tar xzvf $tarfile
  installed_dir=`echo $tarfile | cut -d . -f 1`
  mv $installed_dir nvim

  # Removing the tar file
  rm $tarfile

  # Installing the binary
  mkdir -p $HOME/.local/bin
  ln -s $NVIM_INSTALL_DIR/nvim/bin/nvim $HOME/.local/bin/nvim
}

function install_dotfiles() {
  cd $DOTFILES_INSTALL_DIR
  git clone https://github.com/dburian/dotfiles.git

  mkdir -p $XDG_CONFIG_HOME
  ln -s $DOTFILES_INSTALL_DIR/dotfiles/.config/nvim $XDG_CONFIG_HOME
}

function install_nvim_plugins() {
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  nvim -c "PlugInstall | qa"
}

function install_python_dev() {
  #TODO: null-ls is going to complain pylint is not there
  #TODO: no config for mypy
  pip install pyright black isort git+https://github.com/pre-commit/mirrors-mypy
}

# I am not installing bashrc and zshrc from dotfiles because they requrie too much dependencies
# TODO: have a minimal branch
if [ -x "/bin/zsh" ] ; then
  #Not tested
  setup_zsh
else
  setup_bash
fi

install_fzf

install_nvim
install_dotfiles
install_nvim_plugins


install_python_dev
# TODO: Install pyright, null-ls, ...


