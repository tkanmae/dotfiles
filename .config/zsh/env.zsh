typeset -U path manpath

function _brew_prefix() {
  case $OSTYPE in
    linux*)
      echo -n "$HOME/.linuxbrew"
      ;;
    darwin*)
      if [[ $(uname -m) = arm64 ]]; then
        echo -n "/opt/homebrew"
      else
        echo -n "/usr/local"
      fi
      ;;
    *)
      echo -n "UNKNOWN"
      ;;
  esac
}

function() {
  local brew_prefix=$(_brew_prefix)

  path=(
    # Local
    $HOME/.local/bin(N-/)
    # Yarn
    $HOME/.yarn/bin(N-/)
    # Homebrew or Linuxbrew
    $brew_prefix/bin(N-/)
    $brew_prefix/opt/coreutils/libexec/gnubin(N-/)
    $brew_prefix/opt/findutils/libexec/gnubin(N-/)
    $brew_prefix/opt/gnu-tar/libexec/gnubin(N-/)
    # Sytem-wide
    /usr/local/cuda/bin(N-/)
    /usr/cuda/bin(N-/)
    $path
  )

  manpath=(
    # Homebrew or Linuxbrew
    $brew_prefix/share/man(N-)
    # System-wide
    /usr/local/share/man(N-)
    /usr/share/man(N-/)
  )

  if [[ $OSTYPE = linux* ]]; then
    typeset -Tx LD_LIBRARY_PATH ld_library_path
    typeset -U ld_library_path
    ld_library_path=(
      /usr/local/cuda/lib64(N-/)
      /usr/cuda/lib64(N-/)
    )
  fi

  command -v nvim >/dev/null && export EDITOR=nvim || export EDITOR=vim
  export PAGER=less
  export LESS='--tabs=4 --ignore-case --quit-if-one-screen --no-init --LONG-PROMPT --RAW-CONTROL-CHARS'
  export LESSCHARSET='utf-8'

  # Homebrew or Linuxbrew
  command -v brew >/dev/null && znap eval brew-shellenv 'brew shellenv'

  # zsh-autosuggestions
  export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=60"
  export ZSH_AUTOSUGGEST_USE_ASYNC=1

  # enhancd
  export ENHANCD_FILTER="fzf"
  export ENHANCD_HYPHEN_NUM=32
  export ENHANCD_COMPLETION_BEHAVIOR="list"

  # fzf
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  export FZF_DEFAULT_OPTS='--height 50% --reverse --border'

  # bat
  export BAT_THEME="Catppuccin-macchiato"
  export BAT_STYLE="plain"

  # GoogleTest
  export GTEST_COLOR=1
}

unfunction _brew_prefix
