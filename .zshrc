# ------------------------------------------------------------------------------
# Prezto
# ------------------------------------------------------------------------------
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
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
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# ------------------------------------------------------------------------------
# Key binding
# ------------------------------------------------------------------------------
bindkey -e

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
alias diff='colordiff -urpN'
alias man='LANG=C man'
alias latex='latex --shell-escape $@'

# Global aliases
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'

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
        source ~/.zsh/.zshrc.macosx
        ;;
    linux*)
        source ~/.zsh/.zshrc.linux
        ;;
esac
