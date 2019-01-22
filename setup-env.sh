#!/bin/sh

install_package() {
	if [ $(dpkg -l $1 >/dev/null 2>&1; echo $?) -eq 1 ]; then
		sudo apt-get install -y $1
	else
		echo "package $1 already installed"
	fi
}

link_file() {
	# arg1: link_file
	# arg2: link_to
	if [ -e $1 ] && [ ! -L $1 ]; then
		mv $1 $1.bak
		echo "backed up previous $1"
	fi
	if [ ! -e $1 ]; then
		ln -s $2 $1
		echo "linked $1 to $2"
	fi
	if [ -L $1 ]; then
		echo "link for $1 already exists"
	fi
}

install_package curl
install_package zsh
install_package git
install_package openssh-client
install_package openssh-server
install_package openssl
install_package xsel
install_package tmux
install_package fonts-powerline

# Ensure repo is downloaded
if [ "$(basename $0)" != "setup-env.sh" ] && [ ! -d ~/.env ]; then
	git clone https://github.com/mds325/env.git ~/.env
	echo "env repo downloaded"
	DIR="$HOME/.env"
else
	DIR="$(cd $(dirname $0) && pwd)"
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
if [ -z "$(which google-chrome-stable)" ]; then
	curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	sudo apt-get install libappindicator3-1 libindicator3-7
	rm google-chrome-stable_current_amd64.deb
	echo "installed google-chrome-stable"
else
	echo "package google-chrome-stable already installed"
fi


mkdir -p ~/.config/nvim

# Link settings
link_file ~/.zshrc $DIR/dotfiles/.zshrc
link_file ~/.tmux.conf $DIR/dotfiles/.tmux.conf
link_file ~/.config/nvim/init.vim $DIR/nvim/init.vim 

git config --global user.email "me@mds325.io"
git config --global user.name "Manuel Sanchez"

if [ "$(basename `getent passwd $LOGNAME`)" != "zsh" ]; then
	chsh -s $(which zsh)
	echo "default shell changed to zsh"
else
	echo "default shell is already zsh"
fi

if [ ! -f ~/.ssh/*.pub ]; then
	echo "No public ssh key-pair found. creating one"
	ssh-keygen -t rsa -b 4096 -C "$USER@$HOSTNAME"
fi
