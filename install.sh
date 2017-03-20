#!/bin/bash

os=$(uname)

do_backup() {
    backup=$HOME/backup/dotfiles
    if [ ! -d $backup ]; then
        mkdir -p $backup
    fi

    if [ -e "$HOME/$1" ]; then
        now=`date +%Y%m%d_%s`
        [ ! -L "$HOME/$1" ] && cp -fpR "$HOME/$1" "$backup/$1.$now";
    fi
}

isExist() {
    if which $1 >/dev/null 2>&1;then
        echo "# -> [+] $1 exist"
        return 0
    else
        echo "# -> [-] $1 not exist"
        return 1
    fi

}

install() {
    isExist $1
    if [ "$?" -ne 0 ]; then
        echo "# -> [+] install $1..."
        if [ $os == 'Darwin' ];then
            brew install $1
        elif [ $os == 'Linux' ];then
            if which apt-get >/dev/null; then
                sudo apt-get install -y $1
            else
                echo "# -> [-] Sorry, please install $1 by yourself!"
            fi
        fi
    fi
}

# backup & link dot files
backup_copy() {
    do_backup .vimrc
    do_backup .zshrc
    do_backup .bashrc
    do_backup .gitconfig
    do_backup .tmux.conf
    cp $(pwd)/files/vimrc $HOME/.vimrc
    cp $(pwd)/files/zshrc $HOME/.zshrc
    cp $(pwd)/files/bashrc $HOME/.bashrc
    cp $(pwd)/files/gitconfig $HOME/.gitconfig
    cp $(pwd)/files/tmux.conf $HOME/.tmux.conf

	echo "# -> [+] Exit from backup & link"
    echo "#"
}

requirement() {
    if [ $os == 'Darwin' ];then
		isExist brew
	    if [ "$?" -ne 0 ]; then
			echo "# -> [+] Downloading brew first ..."
	    	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	    fi
        brew install git wget proxychains-ng cmake
		echo "# -> [-] Please download shadowsocks client on https://github.com/shadowsocks/shadowsocks-iOS/releases/"

    elif [ $os == 'Linux' ];then
		if which apt-get >/dev/null; then
        	sudo apt-get remove -y vim-common
        	sudo add-apt-repository -y ppa:jonathonf/vim   # vim version 8
        	sudo add-apt-repository -y ppa:hzwhuang/ss-qt5
        	sudo apt update
        	sudo apt-get install -y vim vim-gtk git wget curl build-essential cmake python-dev python3-dev python-setuptools python3-setuptools python-pip python3-pip ppa-purge proxychains trash-cli shadowsocks-qt5
		else
			echo "# -> [-] Sorry, please install some packages by yourself!"
		fi
    fi

	echo "# -> [+] Exit from install requirement"
    echo "#"
}

vim() {
    # Vundle
	if [ ! -d $HOME/.vim/bundle ];then
		echo "# -> [+] Downloading bundle..."
    	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	fi

    # Powerlin fonts
	if [ ! -d $HOME/.vim/fonts ];then
		echo "# -> [+] Downloading essential fonts..."
    	git clone https://github.com/powerline/fonts.git $HOME/.vim/fonts
    	$HOME/.vim/fonts/install.sh
	fi

    # ctags
    install ctags
    # cscope
    install cscope

	echo "# -> [+] Exit from install vim"
    echo "#"
}

zsh() {
    # oh-my-zsh
	if [ ! -d $HOME/.oh-my-zsh ];then
        echo "# -> [+] Downloading oh-my-zsh..."
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    # zsh
    install zsh

    # autojump
    install autojump

	echo "# -> [+] Exit from install zsh"
    echo "#"
}

tmux() {
    # tmux
    install tmux

	echo "# -> [+] Exit from install tmux"
    echo "#"
}

setEnv() {
    if [ ! -d $HOME/bin ]; then
        mkdir $HOME/bin
    fi

    if [ $os == 'Linux' ];then
        cat $(pwd)/files/env_for_linux >> $HOME/.zshrc
        cat $(pwd)/files/env_for_linux >> $HOME/.bashrc
    elif [ $os == 'Darwin' ];then
        cat $(pwd)/files/env_for_mac >> $HOME/.zshrc
        cat $(pwd)/files/env_for_mac >> $HOME/.bashrc
    fi

    echo "# -> [+] Exit from setEnv"
    echo "#"
}

# main()

echo "# --------------------------------------------------------"
echo "# 1. Backup and Link"
echo "# --------------------------------------------------------"
echo "#"

backup_copy

echo "# --------------------------------------------------------"
echo "# 2. Install some requirements"
echo "# --------------------------------------------------------"
echo "#"

requirement

echo "# --------------------------------------------------------"
echo "# 3. Install some tools about vim"
echo "# --------------------------------------------------------"
echo "#"

vim

echo "# --------------------------------------------------------"
echo "# 4. Install some tools about zsh"
echo "# --------------------------------------------------------"
echo "#"

zsh

echo "# --------------------------------------------------------"
echo "# 5. Install some tools about Tmux"
echo "# --------------------------------------------------------"
echo "#"

tmux

echo "# --------------------------------------------------------"
echo "# 6. Set some environment variables"
echo "# --------------------------------------------------------"
echo "#"

setEnv

echo "# -> [+] Install finish !"
echo "# --------------------------------------------------------"
