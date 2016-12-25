#!/bin/bash

if [ -d ~/.vim/bundle/YouCompleteMe ];then
    cd ~/.vim/bundle/YouCompleteMe
    git pull
    git submodule update --init --recursive
    ./install.py --clang-completer
    ret="$?"
    if [ "$ret" -ne '0' ];then
        echo "Oops, you must compile YCM by yourself"
    else
        echo "Compiled success!"
    fi
else
    echo "Please download YCM"
fi
