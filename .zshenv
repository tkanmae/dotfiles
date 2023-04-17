export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZDOTDIR=${XDG_CONFIG_HOME:=~/.config}/zsh

# ------------------------------------------------------------------------------
# Local settings
# ------------------------------------------------------------------------------
if [[ -f $ZDOTDIR/.zshenv.local ]]; then
    source $ZDOTDIR/.zshenv.local
fi
