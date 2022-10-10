# dotfiles

## Installation

After cloning this repository, you initialize submodules:

    $ git submodule update --init --recursive

Then, you install the configuration files:

    $ ./install.py

This command creates symbolic links in $HOME pointing to the configuration files.

## Updating submodules

If changes were made on the submoduled projects, you can pull the changes by

    $ git submodule foreach --recursive 'git pull origin master'
