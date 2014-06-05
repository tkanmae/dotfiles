typeset -U path cdpath fpath manpath

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=vim
export PAGER=less


# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
path=(/usr/local/bin(N-/) /usr/local/sbin(N-/) ${path})
path=(
    # local
    ${HOME}/.local/bin(N-/)
    # GNU tools via Homebrew
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    /usr/local/opt/gnu-tar/libexec/gnubin(N-/)
    # MacTeX
    /usr/local/texlive/2013/bin/x86_64-darwin(N-/)
    ${path}
)
path=(${HOME}/.rbenv/bin(N-/) ${path})


# ------------------------------------------------------------------------------
# MANPATH
# ------------------------------------------------------------------------------
manpath=(/usr/local/share/man(N-/) /usr/share/man(N-/) ${manpath})
manpath=(
    # GNU coreutils via Homebrew
    /usr/local/opt/coreutils/libexec/gnuman(N-/)
    # MacTeX
    /usr/local/texlive/2013/texmf-dist/doc/man(N-/)
    ${manpath}
)


# ------------------------------------------------------------------------------
# less
# ------------------------------------------------------------------------------
export LESS='--tabs=4 --ignore-case --clear-screen --LONG-PROMPT --RAW-CONTROL-CHARS'
export LESSCHARSET='utf-8'


# ------------------------------------------------------------------------------
# grep
# ------------------------------------------------------------------------------
export GREP_OPTIONS
GREP_OPTIONS="--color=auto -D skip --binary-files=without-match"
GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=.svn --exclude-dir=.git"


# ------------------------------------------------------------------------------
# Node
# ------------------------------------------------------------------------------
if [[ -f ${HOME}/.nvm/nvm.sh ]]; then
    source ${HOME}/.nvm/nvm.sh
fi


# ------------------------------------------------------------------------------
# virtualenvwrapper
# ------------------------------------------------------------------------------
which virtualenvwrapper.sh >/dev/null 2>&1 && source `which virtualenvwrapper.sh`


# ------------------------------------------------------------------------------
# rbenv
# ------------------------------------------------------------------------------
if [[ -d ${HOME}/.rbenv ]]; then
    eval "$(rbenv init -)"
fi


# ------------------------------------------------------------------------------
# Google Test
# ------------------------------------------------------------------------------
export GTEST_COLOR=1


# ------------------------------------------------------------------------------
# Platform specific settings
# ------------------------------------------------------------------------------
case ${OSTYPE} in
    darwin*)
        source ~/.zsh/.zshenv.macosx
        ;;
    linux*)
        source ~/.zsh/.zshenv.linux
        ;;
esac

# ------------------------------------------------------------------------------
# Local settings
# ------------------------------------------------------------------------------
[[ -s ~/.zsh/.zshenv.local ]] && source ~/.zsh/.zshenv.local
