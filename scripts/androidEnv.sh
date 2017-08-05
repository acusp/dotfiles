#!/bin/bash

os=$(uname)

jdk() {
    if [ $os == 'Darwin' ];then
        echo "# -> Please download Oracle JDK for Mac OS by yourself"
    elif [ $os == 'Linux' ];then
        sudo add-apt-repository -y ppa:openjdk-r/ppa
        sudo apt-get update
        sudo apt-get install -y openjdk-7-jdk openjdk-8-jdk
    fi

    echo "# -> [+] Exit from install jdk"
    echo "#"
}

required_packages() {
    if [ $os == 'Darwin' ];then
        echo "# -> Please visit the official website"
    elif [ $os == 'Linux' ];then
        # ubuntu 14.04
        sudo apt-get install -y git-core gnupg flex bison gperf build-essential \
        zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
        lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
        libgl1-mesa-dev libxml2-utils xsltproc unzip
    fi

    echo "# -> [+] Exit from install required packages"
    echo "#"
}

repo() {
    if [ ! -d $HOME/bin ]; then
        mkdir $HOME/bin
    fi

    if [ ! -e $HOME/bin/repo ]; then
        curl https://storage.googleapis.com/git-repo-downloads/repo > $HOME/bin/repo
        chmod a+x $HOME/bin/repo
    fi

    echo "# -> [+] Exit from install repo"
    echo "#"
}

# main()

echo "# --------------------------------------------------------"
echo "# 1. Install JDK"
echo "# --------------------------------------------------------"
echo "#"

jdk

echo "# --------------------------------------------------------"
echo "# 2. Install Required Packages"
echo "# --------------------------------------------------------"
echo "#"

#required_packages

echo "# --------------------------------------------------------"
echo "# 3. Install Repo"
echo "# --------------------------------------------------------"
echo "#"

repo

echo "# -> [+] Install finish !"
echo "# --------------------------------------------------------"
