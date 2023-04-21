# dotfiles

## Installation

After cloning this repository, you initialize submodules:

```console
git submodule update --init --recursive
```

Then, you install the configuration files:

```console
./install.py
```

This command creates symbolic links in $HOME pointing to the configuration files.

## Updating submodules

If changes were made on the submoduled projects, you can pull the changes by

```console
git submodule foreach --recursive 'git pull origin master'
```

## Enabling curly underlines in iTerm2

Dump the current terminfo to a text file.

```console
infocmp $TERM > $TERM.ti
```

Edit the file and insert `Smulx=\E[4\:%p1%dm` after `smul` entry.

```console
nvim $TERM.ti
```

Install the modified terminfo file.

```console
tic -x $TERM.ti
```

This command creates a new entry under `~/.terminfo`.
