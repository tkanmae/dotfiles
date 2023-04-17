WORDCHARS=''

bindkey -e

function fzf_history() {
    BUFFER=$(history -nr 1 | \
        FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --tiebreak=index --query ${(qqq)LBUFFER} +m" fzf)
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N fzf_history
bindkey '^R' fzf_history

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

