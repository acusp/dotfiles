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
    do_backup .tmux.conf
    ln -sf $(pwd)/files/vimrc $HOME/.vimrc
    ln -sf $(pwd)/files/gitconfig $HOME/.gitconfig
    ln -sf $(pwd)/files/tmux.conf $HOME/.tmux.conf
    if [ $os == 'Linux' ];then
        ln -sf $(pwd)/files/zshrc_linux $HOME/.zshrc
    elif [ $os == 'Darwin' ];then
        ln -sf $(pwd)/files/zshrc_mac $HOME/.zshrc
    fi
}

requirement() {
    if [ $os == 'Darwin' ];then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install git wget proxychains-ng cmake
        wget -c https://github.com/shadowsocks/shadowsocks-iOS/releases/download/2.6.3/ShadowsocksX-2.6.3.dmg

    elif [ $os == 'Linux' ];then
        sudo apt-get remove -y vim-common
        sudo add-apt-repository -y ppa:jonathonf/vim   # vim version 8
        sudo add-apt-repository -y ppa:hzwhuang/ss-qt5
        sudo apt update
        sudo apt-get install -y vim vim-gnome git wget curl build-essential cmake python-dev python3-dev ppa-purge proxychains shadowsocks-qt5
    fi
}

vim() {
    # Vundle
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    # Powerlin fonts
    git clone https://github.com/powerline/fonts.git $HOME/.vim/fonts
    $HOME/.vim/fonts/install.sh

    if [ $os == 'Darwin' ];then
        # ctags
        sudo brew install ctags
        # cscope
        sudo brew install cscope

    elif [ $os == 'Linux' ];then
        # ctags
        sudo apt-get install -y ctags
        # cscope
        sudo apt-get install -y cscope
    fi
}

zsh() {
    # oh-my-zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    if [ $os == 'Darwin' ];then
        # autojump
        brew install autojump

    elif [ $os == 'Linux' ];then
        # zsh
        sudo apt-get install -y zsh
        # autojump
        sudo apt-get install -y autojump
    fi
}

tmux() {
    if [ $os == 'Darwin' ];then
        brew install tmux

    elif [ $os == 'Linux' ];then
        sudo apt-get install tmux

    fi
}

install() {
    echo "2. install some requirements..."
    requirement

    echo "3. install some tools about vim..."
    vim

    echo "4. install some tools about zsh..."
    zsh

    echo "5. install some tools about Tmux..."
    tmux
}

# main()
baclin
install
