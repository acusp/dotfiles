#!/bin/bash

os=$(uname)
backup=$HOME/backup/dotfiles

# backup & link dot files
baclin() {
    echo "1. Backup and Link..."
    mkdir -p $HOME/backup/dotfiles
    mv $HOME/.vimrc $backup
    mv $HOME/.zshrc $backup
    mv $HOME/.gitconfig $backup
    ln -sf $(pwd)/vimrc $HOME/.vimrc
    if [ $os == 'linux' ];then
        ln -sf $(pwd)/zshrc_linux $HOME/.zshrc
    elif [ $os == 'Darwin' ];then
        ln -sf $(pwd)/zshrc_mac $HOME/.zshrc
    fi
    ln -sf $(pwd)/gitconfig $HOME/.gitconfig
}

# install tools
install() {
    if [ $os == 'linux' ];then
        echo "2. install requirements..."
        sudo apt-get install -y git wget curl
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
        brew install git wget proxychains-ng

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
