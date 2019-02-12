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
    /usr/local/texlive/2016/bin/x86_64-darwin(N-/)
    # Linuxbrew
    ${HOME}/.linuxbrew/bin(N-/)
    # Sytem-wide
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    /opt/X11/bin(N-/)
)


# ------------------------------------------------------------------------------
# MANPATH
# ------------------------------------------------------------------------------
manpath=(
    # GNU coreutils via Homebrew
    /usr/local/opt/coreutils/libexec/gnuman(N-/)
    # MacTeX
    /usr/local/texlive/2016/texmf-dist/doc/man(N-/)
    # Linuxbrew
    ${HOME}/.linuxbrew/share/man(N-/)
    # System-wide
    /usr/local/share/man(N-)
    /usr/share/man(N-/)
    # System-wide on OS X.
    /opt/X11/share/man(N-/)
    /Library/TeX/Distributions/.DefaultTeX/Contents/Man(N-)
)


# ------------------------------------------------------------------------------
# Node
# ------------------------------------------------------------------------------
if [[ -f ${HOME}/.nvm/nvm.sh ]]; then
    source ${HOME}/.nvm/nvm.sh
fi


# ------------------------------------------------------------------------------
# Yarn
# ------------------------------------------------------------------------------
if [[ -d ${HOME}/.yarn/bin ]]; then
    path=(${HOME}/.yarn/bin(N-/) ${path})
fi


# ------------------------------------------------------------------------------
# rbenv
# ------------------------------------------------------------------------------
if [[ -d ${HOME}/.rbenv ]]; then
    path=(${HOME}/.rbenv/bin(N-/) ${path})
    eval "$(rbenv init --no-rehash -)"
fi


# ------------------------------------------------------------------------------
# Conda
# ------------------------------------------------------------------------------
if [[ -f ${HOME}/.miniconda3/etc/profile.d/conda.sh ]]; then
    . ${HOME}/.miniconda3/etc/profile.d/conda.sh
fi


typeset -U path manpath


# ------------------------------------------------------------------------------
# Prezto
# ------------------------------------------------------------------------------
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# ------------------------------------------------------------------------------
# Percol
# ------------------------------------------------------------------------------
which peco >/dev/null 2>&1
if [[ $? -eq 0 ]] && [[ -s "${HOME}/.zsh/peco.zsh" ]]; then
  source "${HOME}/.zsh/peco.zsh"
  bindkey '^R' peco-select-history
else
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^S' history-incremental-pattern-search-forward
fi


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
SAVEHIST=100000
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
# Kubernetes
# ------------------------------------------------------------------------------
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# ------------------------------------------------------------------------------
# Platform specific settings
# ------------------------------------------------------------------------------
case "$OSTYPE" in
    darwin*)
        source ${HOME}/.zsh/.zshrc.osx
        ;;
    linux*)
        source ${HOME}/.zsh/.zshrc.linux
        ;;
esac
