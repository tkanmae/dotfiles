function() {
  local znap_dir=$ZDOTDIR/plugins/zsh-snap

  if [[ ! -f $znap_dir/znap.zsh ]]; then
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $znap_dir
  fi
  source $znap_dir/znap.zsh

  znap source zsh-users/zsh-autosuggestions
  znap source zsh-users/zsh-syntax-highlighting
  znap source zsh-users/zsh-completions
  znap source hlissner/zsh-autopair
  znap source trapd00r/LS_COLORS

  znap prompt sindresorhus/pure
}
