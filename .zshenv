export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

command -v nvim >/dev/null 2>&1 && export EDITOR=nvim || export EDITOR=vim
export PAGER=less


# ------------------------------------------------------------------------------
# less
# ------------------------------------------------------------------------------
export LESS='--tabs=4 --ignore-case --quit-if-one-screen --no-init --LONG-PROMPT --RAW-CONTROL-CHARS'
export LESSCHARSET='utf-8'


# ------------------------------------------------------------------------------
# Google Test
# ------------------------------------------------------------------------------
export GTEST_COLOR=1


# ------------------------------------------------------------------------------
# Platform specific settings
# ------------------------------------------------------------------------------
case ${OSTYPE} in
    darwin*)
        source ${HOME}/.zsh/.zshenv.osx
        ;;
    linux*)
        source ${HOME}/.zsh/.zshenv.linux
        ;;
esac

# ------------------------------------------------------------------------------
# Local settings
# ------------------------------------------------------------------------------
if [[ -f ${HOME}/.zsh/.zshenv.local ]]; then
    source ${HOME}/.zsh/.zshenv.local
fi
