autoload colors && colors;

function _install_plugin() {
  local name="$1"
  local github_repo="$2"

  echo "Installing $name plugin..."
  mise plugin install "$name" "$github_repo"
  echo "Done!"
}

function _install() {
  local name="$1"
  local version="$2"

  echo "Installing $name..."
  mise install "$name@$version" && mise use --global "$name" "$version"
  echo "Done!"
}

function() {
  if [[ ! -e ${HOME}/.local/bin/mise ]]; then
    echo "Installing mise..."
    curl https://mise.jdx.dev/install.sh | sh
    echo "Done!"
  fi
  eval "$(~/.local/bin/mise activate zsh)"

  local plugin_name
  declare -A local installed_plugins
  for plugin_name in $(mise plugin ls); do
    installed_plugins[$plugin_name]=1
  done

  if [[ -z $installed_plugins[fzf] ]]; then
    _install_plugin fzf https://github.com/kompiro/asdf-fzf.git
    _install fzf latest
  fi

  if [[ -z $installed_plugins[delta] ]]; then
    _install_plugin delta https://github.com/andweeb/asdf-delta.git
    _install delta latest
  fi

  local os_arch="$(uname | tr '[:upper:]' '[:lower:]')-$(uname -m)"

  if [[ $os_arch == 'darwin-arm64' ]]; then
    if ! command -v bat >/dev/null; then
      echo "$fg[yellow]Please install bat with Homebrew."
    fi
    if ! command -v fd >/dev/null; then
      echo "$fg[yellow]Please install fd with Homebrew."
    fi
  else
    if [[ -z $installed_plugins[bat] ]]; then
      _install_plugin bat https://gitlab.com/wt0f/asdf-bat.git
      _install bat latest
    fi
    if [[ -z $installed_plugins[fd] ]]; then
      _install_plugin fd https://gitlab.com/wt0f/asdf-fd.git
      _install fd latest
    fi
  fi
}

unfunction _install_plugin
unfunction _install
