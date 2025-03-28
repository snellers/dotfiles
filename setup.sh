#!/bin/bash
# A script for bootstrapping a fresh installation.
set -euo pipefail
cd
echo "Installing some packages"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt install \
    rlwrap ripgrep tmux xsel \
    powerline kitty neovim \
    python3-dev python3-pip gparted \
    cryptsetup lvm2
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

echo "Setting up shell customizations"
ln -sf ~/git/dotfiles/.tmux.conf.local
ln -sf ~/git/dotfiles/.profile.local
echo ". ~/.profile.local" >> .profile
ln -sf ~/git/dotfiles/.bashrc.local
echo ". ~/.bashrc.local" >> .bashrc
mkdir -p .config
cd .config
if [ -d nvim ]; then
    mv -f nvim nvim.old
fi
ln -sf ~/git/dotfiles/nvim 
if [ -d kitty ]; then
    mv -f kitty kitty.old
fi
cd

