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

  if command -v brew >/dev/null; then
    eval $(brew shellenv)
  fi
}

unfunction _brew_prefix
