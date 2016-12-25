#!/bin/bash

os=$(uname)

do_backup() {
    backup=$HOME/backup/dotfiles
    if [ -e "$HOME/$1" ]; then
        now=`date +%Y%m%d_%s`
        [ ! -L "$HOME/$1" ] && cp -fpR "$HOME/$1" "$backup/$1.$now";
    fi
}

# backup & link dot files
baclin() {
    echo "1. Backup and Link..."
    do_backup .vimrc
    do_backup .zshrc
    do_backup .gitconfig
    ln -sf $(pwd)/files/vimrc $HOME/.vimrc
    ln -sf $(pwd)/files/gitconfig $HOME/.gitconfig
    if [ $os == 'linux' ];then
        ln -sf $(pwd)/files/zshrc_linux $HOME/.zshrc
    elif [ $os == 'Darwin' ];then
        ln -sf $(pwd)/files/zshrc_mac $HOME/.zshrc
    fi
}

# install tools
install() {
    if [ $os == 'linux' ];then
        echo "2. install requirements..."
        sudo apt-get install -y git wget curl build-essential cmake python-dev python3-dev
        sudo apt-get install -y proxychains
        sudo add-apt-repository -y ppa:hzwhuang/ss-qt5
        sudo apt-get update
        sudo apt-get install -y shadowsocks-qt5

        echo "3. install some tools about vim..."
        # Vundle
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        # ctags
        sudo apt-get install -y ctags
        # cscope
        sudo apt-get install -y cscope

        echo "4. install some tools about zsh..."
        # zsh
        sudo apt-get install -y zsh
        # oh-my-zsh
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        # autojump
        sudo apt-get install -y autojump

    elif [ $os == 'Darwin' ];then
        echo "2. install requirements..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install git wget proxychains-ng cmake
        wget -c https://github.com/shadowsocks/shadowsocks-iOS/releases/download/2.6.3/ShadowsocksX-2.6.3.dmg

        echo "3. install some tools about vim..."
        # Vundle
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        # ctags
        sudo brew install ctags
        # cscope
        sudo brew install cscope

        echo "4. install some tools about zsh..."
        # oh-my-zsh
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        # autojump
        brew install autojump
    fi
}

# main()
baclin
install
