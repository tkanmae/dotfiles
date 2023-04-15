alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias la='ll -A'

alias rm='rm -i'

alias diff='colordiff -urpN'
alias grep='grep --color=auto -D skip --binary-files=without-match --exclude-dir=.svn --exclude-dir=.git'
alias man='LANG=C man'
alias latex='latex --shell-escape $@'

# Global aliases
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'

