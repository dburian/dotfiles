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
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

SRC_INSTALL_DIR="$HOME/.local/src"
BIN_INSTALL_DIR="$HOME/.local/bin"



BASHRC_DIR="$HOME"
ZSHRC_DIR="$HOME"

FZF_BIN="https://github.com/junegunn/fzf/releases/download/0.42.0/fzf-0.42.0-linux_amd64.tar.gz"
FZF_INSTALL_DIR="$HOME/.local/bin"

RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz"
RG_INSTALL_DIR=$SRC_INSTALL_DIR

NVIM_INSTALL_DIR=$SRC_INSTALL_DIR
NVIM_BIN="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"

DOTFILES_INSTALL_DIR=$(dirname $(dirname $(dirname $(dirname $(readlink -fn -- "$0")))))

echo $DOTFILES_INSTALL_DIR
exit

CTAGS_URL="https://github.com/universal-ctags/ctags/releases/download/v6.1.0/universal-ctags-6.1.0.tar.gz"



function setup_bash() {
  mkdir -p "$BASHRC_DIR"
  bashrc="$BASHRC_DIR"/.bashrc
  if [ -e $bashrc ]; then
    echo "Appending new lines to ${bashrc}. Check them."
  fi
  echo "Creating new bashrc at ${bashrc}."
  cat  >> $bashrc <<EOT
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
  bashprofile="$BASHRC_DIR"/.profile
  if [ -e $bashprofile ]; then
    echo "Appending new lines to ${bashprofile}. Check them."
  fi
  cat >> $bashprofile <<EOT
if [ "\$BASH" ]; then
  if [ -f $bashrc ]; then
    . $bashrc
  fi
fi

mesg n 2> /dev/null || true
EOT
  source $bashrc
}

function install_fzf() {
  mkdir -p $FZF_INSTALL_DIR
  cd $FZF_INSTALL_DIR

  curl -OL $FZF_BIN
  tarfile=`basename $FZF_BIN`
  tar zxvf $tarfile

  rm $tarfile
}

function install_rg() {
  mkdir -p $RG_INSTALL_DIR
  cd $RG_INSTALL_DIR

  curl -OL $RG_URL
  tarfile=`basename $RG_URL`
  tar zxvf $tarfile
  rg_dir=${tarfile%%.tar.gz}
  ln -s $RG_INSTALL_DIR/$rg_dir/rg $BIN_INSTALL_DIR

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

  mkdir -p $XDG_CONFIG_HOME
  ln -s $DOTFILES_INSTALL_DIR/dotfiles/.config/nvim $XDG_CONFIG_HOME
  ln -s $DOTFILES_INSTALL_DIR/dotfiles/.config/git $XDG_CONFIG_HOME
}

function install_ctags() {
  mkdir -p $SRC_INSTALL_DIR
  cd $SRC_INSTALL_DIR

  curl -OL $CTAGS_URL
  tarfile=`basename $CTAGS_URL`

  tar xvf $tarfile
  ctags_dir=${tarfile%%.tar.xz}
  ln -s $SRC_INSTALL_DIR/$ctags_dir/bin/ctags $BIN_INSTALL_DIR

  rm $tarfile
}

setup_bash

install_fzf
install_rg

install_nvim
install_dotfiles

install_ctags
