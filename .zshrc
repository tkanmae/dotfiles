typeset -U path cdpath fpath manpath

# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
path=(
    # local
    ${HOME}/.local/bin(N-/)
    # GNU tools via Homebrew
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    /usr/local/opt/gnu-tar/libexec/gnubin(N-/)
    # MacTeX
    /usr/local/texlive/2015/bin/x86_64-darwin(N-/)
    # Linuxbrew
    ${HOME}/.linuxbrew/bin(N-/)
    ${path}
)


# ------------------------------------------------------------------------------
# MANPATH
# ------------------------------------------------------------------------------
manpath=(
    # GNU coreutils via Homebrew
    /usr/local/opt/coreutils/libexec/gnuman(N-/)
    # MacTeX
    /usr/local/texlive/2015/texmf-dist/doc/man(N-/)
    # Linuxbrew
    ${HOME}/.linuxbrew/share/man(N-/)
    # System-wide
    /usr/local/share/man(N-)
    /usr/share/man(N-/)
    # System-wide on Mac OS X.
    /opt/X11/share/man(N-/)
    /Library/TeX/Distributions/.DefaultTeX/Contents/Man(N-)
    ${manpath}
)


# ------------------------------------------------------------------------------
# Node
# ------------------------------------------------------------------------------
if [[ -f ${HOME}/.nvm/nvm.sh ]]; then
    source ${HOME}/.nvm/nvm.sh
fi


# ------------------------------------------------------------------------------
# rbenv
# ------------------------------------------------------------------------------
if [[ -d ${HOME}/.rbenv ]]; then
    path=(${HOME}/.rbenv/bin(N-/) ${path})
    eval "$(rbenv init -)"
fi


# ------------------------------------------------------------------------------
# pyenv
# ------------------------------------------------------------------------------
if [[ -d ${HOME}/.pyenv ]]; then
    path=(${HOME}/.pyenv/bin(N-/) ${path})
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


# ------------------------------------------------------------------------------
# virtualenvwrapper
# ------------------------------------------------------------------------------
which virtualenvwrapper.sh >/dev/null 2>&1 && source `which virtualenvwrapper.sh`

# ------------------------------------------------------------------------------
# Prezto
# ------------------------------------------------------------------------------
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# ------------------------------------------------------------------------------
# Percol
# ------------------------------------------------------------------------------
if [[ -s "${HOME}/.zsh/peco.zsh" ]]; then
    which peco >/dev/null 2>&1 && source "${HOME}/.zsh/peco.zsh"
fi
bindkey '^R' peco-select-history


# ------------------------------------------------------------------------------
# Directory
# ------------------------------------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt CDABLE_VARS
setopt AUTO_NAME_DIRS
setopt MULTIOS
setopt EXTENDED_GLOB
unsetopt CLOBBER


# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------
setopt MAGIC_EQUAL_SUBST

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_BEEP
setopt HIST_REDUCE_BLANKS

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
# bindkey '^R' history-incremental-pattern-search-backward
# bindkey '^S' history-incremental-pattern-search-forward

# ------------------------------------------------------------------------------
# Key binding
# ------------------------------------------------------------------------------
bindkey -e

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
GREP_OPTIONS="--color=auto -D skip --binary-files=without-match"
GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=.svn --exclude-dir=.git"

alias diff='colordiff -urpN'
alias grep='grep $GREP_OPTIONS'
alias man='LANG=C man'
alias latex='latex --shell-escape $@'

# Global aliases
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'

# Clean up
unset GREP_OPTIONS

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

# ------------------------------------------------------------------------------
# Platform specific settings
# ------------------------------------------------------------------------------
case "$OSTYPE" in
    darwin*)
        source ~/.zshrc.osx
        ;;
    linux*)
        source ~/.zshrc.linux
        ;;
esac


