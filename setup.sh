#!/bin/sh

install_package() {
	local cmd=$1
	local package=$2

	echo "checking for $package"

	if [ -z "$(which $cmd)" ] && ! dpkg -l $package >/dev/null 2>&1; then
		echo "installing $package"
		sudo apt-get install -y $package
	else
		echo "package $cmd already installed"
	fi
}

link_file() {
	local link_file=$1
	local link_to=$2

	if [ -e $link_file ] && [ ! -L $link_file ]; then
		mv $link_file $link_file.bak
		echo "backed up previous $link_file"
	fi
	if [ ! -e $link_file ]; then
		ln -s $link_to $link_file
		echo "linked $link_to to $link_file"
	fi
	if [ -L $link_file ]; then
		echo "link for $link_file already exists"
	fi
}

install_package curl curl
install_package zsh zsh
install_package git git
install_package ssh openssh-client
install_package sshd openssh-server
install_package openssl openssl
install_package xsel xsel
install_package tmux tmux
install_package fonts-powerline fonts-powerline

# Ensure repo is downloaded
DIR=$HOME/.env
if [ "$(basename $0)" != "setup.sh" ] && [ ! -e ~/.env ]; then
	git clone https://github.com/mds325/env.git ~/.env
	echo "env repo downloaded"
	DIR="$HOME/.env"
elif [ ! -e ~/.env ]; then
	ln -s "$(cd $(dirname $0) && pwd)" ~/.env
	echo "symlink to repo created"
fi

# Install extras
# ohmyzsh
if [ ! -d ~/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	echo "installed ohmyzsh"
else
	echo "package ohmyzsh already installed"
fi

# Install NeoVim
if [ ! -f /usr/local/bin/nvim ]; then
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
	chmod +x nvim.appimage
	sudo mv nvim.appimage /usr/local/bin/nvim
	echo "installed nvim"
else
	echo "package nvim already installed"
fi

# Install Google Chrome
if ! which google-chrome-stable >/dev/null; then
	curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb
	echo "installed google-chrome-stable"
else
	echo "package google-chrome-stable already installed"
fi

# Install nvm
# which nvm
# if ! which nvm; then
#	echo "installing nvm"
#	curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | zsh
#else
#	echo "nvm already installed"
#fi
mkdir -p ~/.config/nvim

echo "Installing missing dependencies for installed packages"
sudo apt-get install --fix-broken -y

echo "Creating symbolic links"
link_file ~/.zshrc $DIR/dotfiles/.zshrc
link_file ~/.tmux.conf $DIR/dotfiles/.tmux.conf
link_file ~/.config/nvim/init.vim $DIR/nvim/init.vim 

echo "Configuring git"
git config --global user.email "me@mds325.io"
git config --global user.name "Manuel Sanchez"


if [ "$(basename `getent passwd $LOGNAME | cut -d: -f7`)" != "zsh" ]; then
	chsh -s $(which zsh)
	echo "default shell changed to zsh"
else
	echo "default shell is already zsh"
fi

if [ ! -f ~/.ssh/*.pub ]; then
	echo "No public ssh key-pair found. creating one"
	ssh-keygen -t rsa -b 4096 -C "$USER@$(hostname)"
fi
