autoload colors && colors;

function _install_plugin() {
  local name="$1"
  local github_repo="$2"

  echo "Installing asfd-$name plugin..."
  asdf plugin add "$name" "$github_repo"
  echo "Done!"
}

function _install() {
  local name="$1"
  local version="$2"

  echo "Installing $name..."
  if [[ $name == direnv ]]; then
    asdf direnv setup --shell zsh --version "$version" >/dev/null
    asdf global direnv "$version"
  else
    asdf install "$name" "$version" && asdf global "$name" "$version"
  fi
  echo "Done!"
}

function () {
  if [[ ! -d ${HOME}/.asdf ]]; then
      echo "Installing asfd..."
      git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3 >/dev/null
      echo "Done!"
  fi
  source "${HOME}/.asdf/asdf.sh"
  fpath=(${ASDF_DIR}/completions ${fpath})

  local plugin_name
  declare -A local installed_plugins
  for plugin_name in $(asdf plugin list); do
    installed_plugins[$plugin_name]=1
  done

  if [[ -z $installed_plugins[python] ]]; then
    _install_plugin python https://github.com/danhper/asdf-python.git
  fi

  if [[ -z $installed_plugins[nodejs] ]]; then
    _install_plugin nodejs https://github.com/asdf-vm/asdf-nodejs.git
  fi

  if [[ -z $installed_plugins[direnv] ]]; then
    _install_plugin direnv https://github.com/asdf-vm/asdf-direnv.git
    _install direnv latest
  fi
  source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
  eval "$(direnv hook zsh)"

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
