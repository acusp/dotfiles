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
    ln -sf $(pwd)/zshrc $HOME/.zshrc
    ln -sf $(pwd)/gitconfig $HOME/.gitconfig
}

# install tools
install() {
    echo "2. install requirements..."
    sudo apt-get install git wget curl

    echo "3. install some tools about vim..."
    # Vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    # ctags
    sudo apt-get install ctags
    # cscope
    sudo apt-get install cscope

    echo "4. install some tools about zsh..."
    # zsh
    sudo apt-get install zsh
    # oh-my-zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    # autojump
    sudo apt-get install autojump
}

# main
baclin
install
