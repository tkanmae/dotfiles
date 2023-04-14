source ~/.zsh/paths.zsh

if [[ $OSTYPE = darwin* ]]; then
  source ~/.zsh/zsh-notify/notify.plugin.zsh
fi

# ------------------------------------------------------------------------------
# Zinit
# ------------------------------------------------------------------------------
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
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

zinit ice from"gh-r" as"program"
zinit load "junegunn/fzf-bin"
zinit ice as'program' pick'bin/fzf-tmux' multisrc'shell/{completion,key-bindings}.zsh' lucid
zinit light -b "junegunn/fzf"
zinit ice from"gh-r" as"program" mv"direnv* -> direnv" pick"direnv"
zinit light "direnv/direnv"

zinit ice wait lucid
zinit light -b "b4b4r07/enhancd"

zinit ice pick"async.zsh" src"pure.zsh"
zinit light "sindresorhus/pure"

zinit ice atclone"dircolors -b LS_COLORS > ls_colors.zsh" atpull'%atclone' pick"ls_colors.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

zinit ice wait"0" atinit"zpcompinit; zpcdreplay" lucid
zinit light "zdharma-continuum/fast-syntax-highlighting"

zinit ice wait"1" blockf as"completion" lucid
zinit snippet "OMZ::plugins/pip/_pip"
zinit ice wait"1" blockf atpull"zinit creinstall -q" lucid
zinit light "esc/conda-zsh-completion"

# The following commnds released on GitHub do not provide executables for Apple Silicon.
if ! type "bat" >/dev/null; then
  zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
  zinit light "sharkdp/bat"
fi
if ! type "fd" >/dev/null; then
  zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
  zinit light "sharkdp/fd"
fi
if ! type "delta" >/dev/null; then
  zinit ice lucid wait"0" as"program" from"gh-r" pick"delta*/delta"
  zinit light 'dandavison/delta'
fi

# ------------------------------------------------------------------------------
# asdf
# ------------------------------------------------------------------------------
if [[ ! -d ${HOME}/.asdf ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
fi
source "${HOME}/.asdf/asdf.sh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
fpath=(${ASDF_DIR}/completions ${fpath})


# ------------------------------------------------------------------------------
# direnv
# ------------------------------------------------------------------------------
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi


# ------------------------------------------------------------------------------
# npm
# ------------------------------------------------------------------------------
if command -v npm &>/dev/null; then
    path=($(npm bin --global) ${path})
fi


# ------------------------------------------------------------------------------
# Yarn
# ------------------------------------------------------------------------------
if [[ -d ${HOME}/.yarn/bin ]]; then
    path=(${HOME}/.yarn/bin(N-/) ${path})
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
export BAT_THEME="Nord"
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
