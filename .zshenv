export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
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
