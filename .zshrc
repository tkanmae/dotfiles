# ------------------------------------------------------------------------------
# antigen
# ------------------------------------------------------------------------------
source ~/.zshrc.antigen

# ------------------------------------------------------------------------------
# autojump
# ------------------------------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
    export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
    if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
        . /opt/local/etc/profile.d/autojump.sh
    fi
fi

# ------------------------------------------------------------------------------
# Override some of the settings that oh-my-zsh sets
# ------------------------------------------------------------------------------
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>''})]'
unsetopt correct_all

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt no_flow_control

# ------------------------------------------------------------------------------
# Key binding
# ------------------------------------------------------------------------------
bindkey -e
# History search
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
if [[ $OSTYPE == darwin* ]]; then
    # Add aliases for Mac OS X here.
    [[ -x /opt/local/bin ]] && alias ls='gls -F --color=auto'
    alias gvim='open -a /Applications/MacVim.app'
elif [[ $OSTYPE == linux* ]]; then
    # Add aliases for Linux here.
    alias ls='ls -F --color=auto'
fi

alias rm='nocorrect rm -i'
alias mv='nocorrect mv -i -v'
alias cp='nocorrect cp -i'
alias df='df -h'
alias du='du -h'
alias h='history'
alias ll='ls -la'
alias la='ls -A'
alias lk="ls -la | grep '^l'"
alias lf="ls -la | grep '^-'"
alias lx="ls -la | grep '^-..x'"
alias diff='colordiff -urpN'
alias vi='vim'
alias man='LANG=C man'
alias tgif='LANG=C tgif'
alias latex='latex --shell-escape $@'

# Global aliases
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g W='| wc'

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
GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=.svn"
GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=.git"

# ------------------------------------------------------------------------------
# Node
# ------------------------------------------------------------------------------
if [[ -f $HOME/.nvm/nvm.sh ]]; then
    source $HOME/.nvm/nvm.sh
    nvm alias default "v0.10.5" >/dev/null
fi

# ------------------------------------------------------------------------------
# virtualenvwrapper
# ------------------------------------------------------------------------------
source `which virtualenvwrapper.sh`

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Call ipython with a per-project profile.  It assumes that .ipython directory
# is in the top level directory of a project managed by git.
function ipython() {
    local project_root_dir

    # If the user specifies `IPYTHONDIR` either by giving --ipython-dir
    # option or by an environmental variable IPYTHONDIR, then the specified
    # directory should have precedence over per-project `IPYTHONDIR`.
    if [[ $* =~ --ipython-dir || -n $IPYTHONDIR ]]; then
        command ipython $*
    else
        project_root_dir=$(git rev-parse --show-toplevel 2>/dev/null)
        if [[ -d "$project_root_dir/.ipython" ]]; then
            command ipython $* --ipython-dir="$project_root_dir/.ipython"
        else
            command ipython $*
        fi
    fi
}
