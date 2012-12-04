# Give 644 and 755 for created files and directories respectively.
umask 022

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ------------------------------------------------------------------------------
# General setting
# ------------------------------------------------------------------------------
setopt NO_BEEP
setopt NO_LIST_BEEP
setopt NO_HUP
setopt IGNORE_EOF
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT

# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*:default' list-separator '-->'
zstyle ':completion:*:default' menu select=2
setopt AUTO_LIST
setopt LIST_TYPES
setopt LIST_PACKED
setopt AUTO_MENU
setopt CORRECT
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt MAGIC_EQUAL_SUBST
setopt AUTO_RESUME
setopt BRACE_CCL
setopt PRINT_EIGHT_BIT

autoload -Uz colors && colors

# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------
setopt PROMPT_SUBST
PROMPT="%{$fg[red]%}%n@%m%(!.#.$)%{$reset_color%} "
RPROMPT="%{$fg[green]%}[%~]%{$reset_color%}"
# Title of terminal
case "$TERM" in
  kterm*|xterm*|urxvt*)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
  ;;
esac

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt NO_FLOW_CONTROL

# ------------------------------------------------------------------------------
# CD
# ------------------------------------------------------------------------------
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

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
alias j='jobs -l'
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


# vim: ft=zsh
