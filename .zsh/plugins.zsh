function() {
  local znap_dir=${XDG_CONFIG_HOME:=$HOME/.config}/zsh/plugins/zsh-snap

  if [[ ! -f $znap_dir/znap.zsh ]]; then
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $znap_dir
  fi
  source $znap_dir/znap.zsh

  znap source zsh-users/zsh-autosuggestions
  znap source zsh-users/zsh-syntax-highlighting
  znap source zsh-users/zsh-completions
  znap source hlissner/zsh-autopair
  znap source trapd00r/LS_COLORS
  znap source b4b4r07/enhancd

  znap prompt sindresorhus/pure
}
