# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallois"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# autojump
if [[ $OSTYPE == darwin* ]]; then
    export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
    if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
        . /opt/local/etc/profile.d/autojump.sh
    fi
fi

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
