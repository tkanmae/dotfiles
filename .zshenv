# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
typeset -U path
path=(# User
      $HOME/.local/bin(N-/)
      # System
      /usr/local/bin(N-/)
      # Qt
      /usr/local/Trolltech/Qt-4.8.0/bin(N-/)
      # MacPorts
      /opt/local/bin(N-/)
      # GNU tools (MacPorts)
      /opt/local/libexec/gnubin(N-/)
      # Python (MacPorts)
      /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin(N-/)
      # Go
      /usr/local/go/bin(N-)
      $HOME/.local/go/bin(N-)
      # MOSART
      $HOME/.local/MOSART/bin(N-)
      # MacTeX
      /usr/local/texlive/2012/bin/x86_64-darwin(N-/)
      # System
      /usr/sbin(N-/)
      /usr/bin(N-/)
      /sbin(N-)
      /bin(N-))

# ------------------------------------------------------------------------------
# MANPATH
# ------------------------------------------------------------------------------
typeset -U manpath
manpath=(# system
         /usr/local/share/man(N-/)
         # Qt
         /usr/local/Trolltech/Qt-4.8.0/share(N-/)
         # MacPorts
         /opt/local/share/man(N-/)
         # system
         /usr/share/man(N-/))

export LANG=ja_JP.UTF-8
export LC_TIME=C
export EDITOR=vim
export PAGER=less

# ------------------------------------------------------------------------------
# Python
# ------------------------------------------------------------------------------
export PYTHONUSERBASE=$HOME/.local

# ------------------------------------------------------------------------------
# Google Test
# ------------------------------------------------------------------------------
export GTEST_COLOR=1

# ------------------------------------------------------------------------------
# Go
# ------------------------------------------------------------------------------
export GOPATH=$HOME/.local/go

# ------------------------------------------------------------------------------
# Platform Specific
# ------------------------------------------------------------------------------
if [[ $OSTYPE == linux* ]]; then
    # LD_LIBRARY_PATH
    typeset -xT LD_LIBRARY_PATH ld_library_path
    typeset -U ld_library_path
    ld_library_path=(# system
                     /usr/local/lib(N-/)
                     # Qt
                     /usr/local/Trolltech/Qt-4.7.3/lib(N-/))

    # Java
    export JAVA_HOME=/usr/lib/jvm/java-6-sun

    # Scala
    export SCALA_HOME=/usr/local/scala-2.9.1
    path=($path /usr/local/scala-2.9.1/bin(N-/))

    # Unidata LDM
    if [[ `whoami` = 'ldm' ]]; then
        path=($path $HOME/ldm-6.9.7/bin(N-))
    fi

    # TeX
    export TEXINPUTS=.//:$HOME/Dropbox/home/.texmf/tex//:
    export BSTINPUTS=.//:$HOME/Dropbox/home/.texmf/bibtex/bst//:

elif [[ $OSTYPE == darwin* ]]; then
    # GNU Source Highlight
    if [[ -x /opt/local/bin/src-hilite-lesspipe.sh ]]; then
        export LESSOPEN='| /opt/local/bin/src-hilite-lesspipe.sh %s'
    fi

fi
