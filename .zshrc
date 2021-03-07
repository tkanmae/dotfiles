typeset -U path cdpath fpath manpath

# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
path=(
    # local
    ${HOME}/.local/bin(N-/)
    # GNU tools via Homebrew (Apple Silicon)
    /opt/homebrew/opt/coreutils/libexec/gnubin(N-/)
    /opt/homebrew/opt/gnu-tar/libexec/gnubin(N-/)
    # GNU tools via Homebrew
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    /usr/local/opt/gnu-tar/libexec/gnubin(N-/)
    # MacTeX
    /usr/local/texlive/2019/bin/x86_64-darwin(N-/)
    # Linuxbrew
    ${HOME}/.linuxbrew/bin(N-/)
    # Homebrew (Apple Silicon)
    /opt/homebrew/bin(N-/)
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
    /usr/local/texlive/2019/texmf-dist/doc/man(N-/)
    # Linuxbrew
    ${HOME}/.linuxbrew/share/man(N-/)
    # Homebrew (Apple Silicon)
    /opt/homebrew/share/man(N-)
    # System-wide
    /usr/local/share/man(N-)
    /usr/share/man(N-/)
    # System-wide on OS X.
    /opt/X11/share/man(N-/)
    /Library/TeX/Distributions/.DefaultTeX/Contents/Man(N-)
)

# ------------------------------------------------------------------------------
# Zinit
# ------------------------------------------------------------------------------
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit snippet "PZT::modules/environment/init.zsh"
zinit snippet "PZT::modules/editor/init.zsh"
zinit snippet "PZT::modules/completion/init.zsh"

zinit ice wait blockf atpull"zinit creinstall -q ." lucid
zinit light "zsh-users/zsh-completions"
zinit ice wait"1" atload"_zsh_autosuggest_start" lucid
zinit light "zsh-users/zsh-autosuggestions"
zinit ice wait lucid
zinit light -b "hlissner/zsh-autopair"

zinit ice wait'0' lucid
zinit light "lukechilds/zsh-nvm"

zinit ice from"gh-r" as"program"
zinit load "junegunn/fzf-bin"
zinit ice as'program' pick'bin/fzf-tmux' multisrc'shell/{completion,key-bindings}.zsh' lucid
zinit light -b "junegunn/fzf"
zinit ice  from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
zinit light "sharkdp/bat"
zinit ice from"gh-r" as"program" mv"direnv* -> direnv" atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv" src"zhook.zsh"
zinit light "direnv/direnv"

zinit ice wait as"program" pick"bin/git-dsf" lucid
zinit light "zdharma/zsh-diff-so-fancy"

zinit ice wait lucid
zinit light -b "b4b4r07/enhancd"

zinit ice pick"async.zsh" src"pure.zsh"
zinit light "sindresorhus/pure"

zinit ice atclone"dircolors -b LS_COLORS > ls_colors.zsh" atpull'%atclone' pick"ls_colors.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

zinit ice wait"0" atinit"zpcompinit; zpcdreplay" lucid
zinit light "zdharma/fast-syntax-highlighting"

zinit ice wait"1" blockf as"completion" lucid
zinit snippet "OMZ::plugins/pip/_pip"
zinit ice wait"1" blockf atpull"zinit creinstall -q" lucid
zinit light "esc/conda-zsh-completion"


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


# ------------------------------------------------------------------------------
# pyenv
# ------------------------------------------------------------------------------
if [[ -d ${HOME}/.pyenv ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    path=($PYENV_ROOT/bin(N-/) ${path})
    eval "$(pyenv init  -)"
    eval "$(pyenv virtualenv-init -)"
fi


typeset -U path manpath


# ------------------------------------------------------------------------------
# zsh-autosuggestions
# ------------------------------------------------------------------------------
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=60"
export ZSH_AUTOSUGGEST_USE_ASYNC=1


# ------------------------------------------------------------------------------
# fzf
# ------------------------------------------------------------------------------
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 50% --reverse --border'

function fzf_history() {
    BUFFER=$(history -nr 1 | \
        FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --tiebreak=index --query ${(qqq)LBUFFER} +m" fzf)
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N fzf_history
bindkey '^r' fzf_history


# ------------------------------------------------------------------------------
# enhancd
# ------------------------------------------------------------------------------
export ENHANCD_FILTER="fzf"
export ENHANCD_HYPHEN_NUM=32
export ENHANCD_COMPLETION_BEHAVIOR="list"


# ------------------------------------------------------------------------------
# bat
# ------------------------------------------------------------------------------
export BAT_THEME="Solarized (dark)"
export BAT_STYLE="plain"


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
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
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

alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias la='ll -A'

alias rm='rm -i'

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
        source ${HOME}/.zsh/.zshrc.osx
        ;;
    linux*)
        source ${HOME}/.zsh/.zshrc.linux
        ;;
esac
