export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=vim
export PAGER=less


# ------------------------------------------------------------------------------
# less
# ------------------------------------------------------------------------------
export LESS='--tabs=4 --ignore-case --clear-screen --LONG-PROMPT --RAW-CONTROL-CHARS'
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
        source ~/.zshenv.osx
        ;;
    linux*)
        source ~/.zshenv.linux
        ;;
esac

# ------------------------------------------------------------------------------
# Local settings
# ------------------------------------------------------------------------------
if [[ -f ~/.zshenv.local ]]; then
    source ~/.zshenv.local
fi
