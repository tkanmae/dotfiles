dotfiles
========

## Installation

After cloning this repository, you need to initialize submodules:

    $ git submodule update --init --recursive

Then, you set up NeoBundle, a plugin manager for Vim:

    $ mkdir .vim/bundle
    $ git clone https://github.com/Shougo/neobundle.vim .vim/bundle/neobundle.vim

Finally, you can install the configuration files:

    $ ./install.py

This command creates symbolic links in $HOME pointing to the configuration
files.


## Updating submodules

If changes were made on the submoduled projects, you can pull the changes by

    $ git submodule foreach --recursive 'git pull origin master'
