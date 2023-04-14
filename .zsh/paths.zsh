typeset -U path manpath

function() {
  path=(
      # Local
      ${HOME}/.local/bin(N-/)
      # Linuxbrew
      ${HOME}/.linuxbrew/bin(N-/)
      # Homebrew (Apple Silicon)
      /opt/homebrew/bin(N-/)
      /opt/homebrew/opt/coreutils/libexec/gnubin(N-/)
      /opt/homebrew/opt/findutils/libexec/gnubin(N-/)
      /opt/homebrew/opt/gnu-tar/libexec/gnubin(N-/)
      # Homebrew
      /usr/local/opt/coreutils/libexec/gnubin(N-/)
      /usr/local/opt/findutils/libexec/gnubin(N-/)
      /usr/local/opt/gnu-tar/libexec/gnubin(N-/)
      # Sytem-wide
      /usr/local/bin(N-/)
      /usr/local/sbin(N-/)
      /usr/bin(N-/)
      /bin(N-/)
      /usr/sbin(N-/)
      /sbin(N-/)
  )

  manpath=(
      # Linuxbrew
      ${HOME}/.linuxbrew/share/man(N-/)
      # Homebrew (Apple Silicon)
      /opt/homebrew/opt/coreutils/libexec/gnuman(N-/)
      /opt/homebrew/opt/findutils/libexec/gnuman(N-/)
      /opt/homebrew/opt/gnu-tar/libexec/gnuman(N-/)
      /opt/homebrew/share/man(N-)
      # Homebrew
      /usr/local/opt/coreutils/share/man(N-)
      /usr/local/opt/findutils/share/man(N-)
      /usr/local/opt/gnu-tar/share/man(N-)
      # System-wide
      /usr/local/share/man(N-)
      /usr/share/man(N-/)
  )

  if [[ $OSTYPE = linux* ]]; then
    path+=(
      /usr/local/cuda/bin(N-/)
      /usr/cuda/bin(N-/)
    )

    typeset -Tx LD_LIBRARY_PATH ld_library_path
    typeset -U ld_library_path
    ld_library_path=(
      /usr/local/cuda/lib64(N-/)
      /usr/cuda/lib64(N-/)
    )
  fi
}
