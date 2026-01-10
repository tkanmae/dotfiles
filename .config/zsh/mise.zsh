autoload colors && colors;

function _install() {
  echo "Installing $1..."
  mise use -g "$1" >/dev/null
  echo "Done!"
}

function() {
  local os_arch="$(uname | tr '[:upper:]' '[:lower:]')-$(uname -m)"

  if [[ ! -e ${HOME}/.local/bin/mise ]]; then
    echo "Installing mise..."
    curl https://mise.jdx.dev/install.sh | sh
    echo "Done!"
  fi
  eval "$(~/.local/bin/mise activate zsh)"

  if ! command -v fzf >/dev/null; then
    _install "fzf@latest"
  fi

  if ! command -v delta >/dev/null; then
    _install "delta@latest"
  fi

  if ! command -v usage >/dev/null; then
    _install "usage@latest"
  fi

  if ! command -v starship >/dev/null; then
    _install "starship@latest"
  fi
  znap eval starthip-init 'starship init zsh'

  if ! command -v bat >/dev/null; then
    if [[ $os_arch == 'darwin-arm64' ]] then
      echo "$fg[yellow]Please install bat with Homebrew."
    else
      _install "bat@latest"
    fi
  fi

  if ! command -v fd >/dev/null; then
    if [[ $os_arch == 'darwin-arm64' ]] then
      echo "$fg[yellow]Please install fd with Homebrew."
    else
      _install "fd@latest"
    fi
  fi

  if ! command -v zoxide >/dev/null; then
    if [[ $os_arch == 'darwin-arm64' ]] then
      echo "$fg[yellow]Please install zoxide with Homebrew."
    else
      _install "zoxide@latest"
    fi
  fi
  command -v zoxide >/dev/null && znap eval zoxide-init 'zoxide init --cmd cd zsh'
}

unfunction _install
