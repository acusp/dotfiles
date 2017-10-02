#!/bin/bash

os=$(uname)

bad_echo() {
    echo -e "# -> \033[0;31m$1\033[0m"
}

nice_echo() {
    echo -e "# -> \033[0;36m$1\033[0m"
}

msg_header() {
    echo "# --------------------------------------------------------"
    nice_echo "[+] $1"
    echo "# --------------------------------------------------------"
    echo "#"
}

msg_footer() {
    nice_echo "[+] Exit from $1()"
    echo "#"
}

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
        nice_echo "[+] $1 exist"
        return 0
    else
        bad_echo "[-] $1 not exist"
        return 1
    fi

}

install() {
    isExist $1
    if [ "$?" -ne 0 ]; then
        nice_echo "[+] install $1..."
        if [ $os == 'Darwin' ];then
            brew install $1
        elif [ $os == 'Linux' ];then
            if which apt-get >/dev/null; then
                sudo apt-get install -y $1
            else
                bad_echo "[-] Sorry, please install $1 by yourself!"
            fi
        fi
    fi
}

#==============================================================================#
#==============================================================================#

# backup & link dot files
backup_copy() {
    msg_header "Update config files"

    do_backup .vimrc
    do_backup .zshrc
    do_backup .gitconfig
    do_backup .tmux.conf
    do_backup .ycm_extra_conf.py
    cp -rf $(pwd)/files/vimrc $HOME/.vimrc
    cp -rf $(pwd)/files/zshrc $HOME/.zshrc
    cp -rf $(pwd)/files/gitconfig $HOME/.gitconfig
    cp -rf $(pwd)/files/tmux.conf $HOME/.tmux.conf

    if [ $os == 'Darwin' ];then
        do_backup .bash_profile
        cp -rf $(pwd)/files/bashrc $HOME/.bash_profile
    elif [ $os == 'Linux' ];then
        do_backup .bashrc
        cp -rf $(pwd)/files/bashrc $HOME/.bashrc
    fi

    msg_footer backup_copy
}

requirement() {
    msg_header "Install some requirements"

    if [ $os == 'Darwin' ];then
		isExist brew
	    if [ "$?" -ne 0 ]; then
			nice_echo "[+] Downloading brew first ..."
	    	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	    fi
        brew install vim git wget proxychains-ng cmake ranger screenfecth
		bad_echo "[-] Please download shadowsocks client on https://github.com/shadowsocks/shadowsocks-iOS/releases/"

    elif [ $os == 'Linux' ];then
		if which apt-get >/dev/null; then
        	sudo apt-get remove -y vim-common
        	sudo add-apt-repository -y ppa:jonathonf/vim   # vim version 8
        	sudo add-apt-repository -y ppa:hzwhuang/ss-qt5
        	sudo apt update
        	sudo apt-get install -y vim vim-gtk git wget curl build-essential cmake python-dev python3-dev python-setuptools python3-setuptools python-pip python3-pip ppa-purge proxychains trash-cli ranger shadowsocks-qt5 screenfecth
		else
			bad_echo "[-] Sorry, please install some packages by yourself!"
		fi
    fi

    msg_footer requirement
}

vim() {
    msg_header "Install some tools about vim"

    cp -rf $(pwd)/files/ycm_extra_conf.py $HOME/.vim/.ycm_extra_conf.py

    # Vundle
	if [ ! -d $HOME/.vim/bundle ];then
		nice_echo "[+] Downloading bundle..."
    	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	fi

    # Powerline fonts
	if [ ! -d $HOME/.vim/fonts ];then
		nice_echo "[+] Downloading essential fonts..."
    	git clone https://github.com/powerline/fonts.git $HOME/.vim/fonts
    	$HOME/.vim/fonts/install.sh
	fi

    # ctags
    install ctags
    # cscope
    install cscope

    msg_footer vim
}

zsh() {
    msg_header "Install some tools about zsh"

    # oh-my-zsh
	if [ ! -d $HOME/.oh-my-zsh ];then
        nice_echo "[+] Downloading oh-my-zsh..."
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    # zsh
    install zsh

    # autojump
    install autojump

    msg_footer zsh
}

tmux() {
    msg_header "Install some tools about Tmux"

    # tmux
    install tmux

    msg_footer tmux
}

spacemacs() {
    mv $HOME/.emacs.d $HOME/.emacs.d.bak
    mv $HOME/.emacs $HOME/.emacs.bak

    git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

    msg_footer spacemacs
}

setEnv() {
    msg_header "Set some environment variables"

    if [ ! -d $HOME/bin ]; then
        mkdir $HOME/bin
    fi
    cp -f $(pwd)/files/emacs_alias.sh $HOME/bin/

    if [ $os == 'Linux' ];then
        cat $(pwd)/files/env_for_linux >> $HOME/.zshrc
        cat $(pwd)/files/env_for_linux >> $HOME/.bashrc
    elif [ $os == 'Darwin' ];then
        cat $(pwd)/files/env_for_mac >> $HOME/.zshrc
        cat $(pwd)/files/env_for_mac >> $HOME/.bash_profile
    fi

    msg_footer "setEnv"
}

main() {
    option=$1

    backup_copy
    setEnv

    if [ "$optioin" == "init" ]; then
        requirement
        vim
        zsh
        tmux
    fi

    nice_echo "[+] Install Success !"
    echo "# --------------------------------------------------------"
}

#==============================================================================#
#==============================================================================#

# main

if [ $# != 1 ]; then
    echo "Usage:"
    echo "./install init|update"
    exit -1
fi
main $1
