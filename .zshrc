source ~/.zsh/plugins.zsh
source ~/.zsh/env.zsh
source ~/.zsh/asdf.zsh
source ~/.zsh/options.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh



# ------------------------------------------------------------------------------
# fzf
# ------------------------------------------------------------------------------
function fzf_history() {
    BUFFER=$(history -nr 1 | \
        FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --tiebreak=index --query ${(qqq)LBUFFER} +m" fzf)
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N fzf_history
bindkey '^r' fzf_history

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end


# ------------------------------------------------------------------------------
# Key binding
# ------------------------------------------------------------------------------
bindkey -e
