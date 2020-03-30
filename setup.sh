#!/bin/sh

sudo apt-get update

sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt-get update

pip3 install flashfocus

sudo git clone https://github.com/neovim/neovim.git /usr/local/src/neovim
(cd /usr/local/src/neovim && sudo make CMAKE_BUILD_TYPE=Release && sudo make install)


vivaldi_download_link=https://downloads.vivaldi.com/stable/vivaldi-stable_2.11.1811.49-1_amd64.deb
vivaldi_download_dir=~/Downloads
vivaldi_file=${vivaldi_download_dir}/`basename "$vivaldi_download_link"`

wget "-P "$vivaldi_download_dir" $vivaldi_download_link"
sudo apt install "$vivaldi_file"

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client

# wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | \
#   NVM_DIR=/home/dburian/.local/src/nvm bash
# Need of node js..., nvm cannot be used with npm prefixes, and installs node
# into its location ergo needs to be sourced, this implies longer terminal
# loading times
# Ivis needs node 10.x so now I am installing 10.x...

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

npm config set prefix "~/.npm-packages"

npm install --global pure-prompt

# loads urxvt extenstions
urxvt_theme_path=urxvt-themes -c
urxvt_theme_name=`basename ${urxvt_theme_path}`
urxvt-theme "$urxvt_theme_name"

