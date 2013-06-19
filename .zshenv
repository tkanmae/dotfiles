export LANG=ja_JP.UTF-8
export LC_TIME=C
export EDITOR=vim
export PAGER=less

# ------------------------------------------------------------------------------
# Google Test
# ------------------------------------------------------------------------------
export GTEST_COLOR=1

# ------------------------------------------------------------------------------
# Platform specific settings
# ------------------------------------------------------------------------------
case $OSTYPE in
    darwin*)
        source ~/.zsh/.zshenv.macosx
        ;;
    linux*)
        source ~/.zsh/.zshenv.linux
        ;;
esac
