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

backup() {
    backup=$HOME/backup/dotfiles
    if [ ! -d $backup ]; then
        mkdir -p $backup
    fi

    if [ -e "$HOME/$1" ]; then
        now=`date +%Y%m%d_%s`
        [ ! -L "$HOME/$1" ] && cp -fpR "$HOME/$1" "$backup/$1.$now";
    fi
}

append() {
    cat $1 >> $2
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
                sudo apt-get update
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

    backup .vimrc
    backup .zshrc
    backup .gitconfig
    backup .tmux.conf
    backup .ycm_extra_conf.py
    cp -rf $(pwd)/vim/basic.vimrc $HOME/.vimrc
    #cp -rf $(pwd)/configs/zshrc $HOME/.zshrc
    cp -rf $(pwd)/configs/gitconfig $HOME/.gitconfig
    cp -rf $(pwd)/configs/tmux.conf $HOME/.tmux.conf
    cp -rf $(pwd)/configs/agignore $HOME/.agignore

    if [ $os == 'Linux' ];then
        backup .bashrc
        cp -rf $(pwd)/configs/bashrc $HOME/.bashrc
    elif [ $os == 'Darwin' ];then
        backup .bash_profile
        cp -rf $(pwd)/configs/bashrc $HOME/.bash_profile
    fi

    if [ ! -d $HOME/.vim/skeleton ]; then
        mkdir -p $HOME/.vim/skeleton
    fi
    cp -rf $(pwd)/vim/skeleton/* $HOME/.vim/skeleton/

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
        brew install git git-gui wget proxychains-ng cmake ranger screenfetch the_silver_searcher

    elif [ $os == 'Linux' ];then
		if which apt-get >/dev/null; then
        	sudo apt-get remove -y vim-common
        	sudo apt update
        	sudo apt-get install -y vim
            sudo apt-get install -y git gitk wget curl
            sudo apt-get install -y build-essential cmake
            sudo apt-get install -y python-dev python3-dev python-setuptools python3-setuptools python-pip python3-pip ppa-purge
            sudo apt-get install -y tree proxychains ranger screenfetch silversearcher-ag
		else
			bad_echo "[-] Sorry, please install some packages by yourself!"
		fi
    fi

    msg_footer requirement
}

vim() {
    msg_header "Install some tools about vim"

    cp -rf $(pwd)/vim/ycm_extra_conf.py $HOME/.vim/.ycm_extra_conf.py

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
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

web() {
    msg_header "Install some tools about web"

    if [ $os == 'Darwin' ];then
        # yarn
        curl -o- -L https://yarnpkg.com/install.sh | bash
    elif [ $os == 'Linux' ];then
        # yarn
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt update && sudo apt install --no-install-recommends yarn

        # nvm & nodejs
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
        bad_echo "[-] Please manual install nodejs use: nvm install --lts!"
    fi

    msg_footer web
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
    cp -f $(pwd)/configs/emacs_alias.sh $HOME/bin/

    if [ $os == 'Linux' ];then
        #append $(pwd)/configs/env_for_linux >> $HOME/.zshrc
        append $(pwd)/configs/env_for_linux $HOME/.bashrc
    elif [ $os == 'Darwin' ];then
        #append $(pwd)/configs/env_for_mac $HOME/.zshrc
        append $(pwd)/configs/env_for_mac $HOME/.bash_profile
    fi

    msg_footer "setEnv"
}

main() {
    option=$1

    backup_copy
    setEnv

    if [ "$option" == "init" ]; then
        requirement
        vim
        zsh
        tmux
        #web
    fi
    if [ "$option" == "web" ]; then
        web
    fi

    nice_echo "[+] Install Success !"
    echo "# --------------------------------------------------------"
}

#==============================================================================#
#==============================================================================#

# main

if [ $# != 1 ]; then
    echo "Usage:"
    echo "./install init|config|web"
    exit -1
fi
main $1
