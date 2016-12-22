#!/bin/bash

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

# main
baclin
