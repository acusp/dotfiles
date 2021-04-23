> backup, restore and sync my dot files.

## Usage

cd to your work directory, and run commands as follow:

```
git clone git@github.com:acusp/dotfiles.git
cd dotfiles

# 1. full install
./install.sh

# 2. only copy config file
./install.sh config

# 3. install dependency for web developer
./install.sh web
```

Vim plugin install:

```
vim

:PluginInstall 
```

## Description

### configs

`karabiner.json` ------ Karabiner-Elements configuration file. Karabiner-Elements is a powerful and stable keyboard customizer for macOS.
