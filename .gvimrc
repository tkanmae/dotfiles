set guioptions&    " Initialize guioptions
set guioptions+=a  " Copy the selected text to the system clipborad
set guioptions-=T  " no tool bar
set guioptions-=r  " no rhs scroll-bar
set guioptions-=L  " no lhs scroll-bar when vsplit'd
set guioptions-=e  " no gui tab

highlight CursorIM guibg=Purple guifg=NONE
highlight Search guibg=DarkBlue guifg=NONE

" Platform specific settings
if has("gui_macvim")
  set columns=90 lines=90
  set gfn=Ricty:h12
elseif has("gui_gtk")
  winpos 0 0
  set columns=90 lines=95
  set gfn=Ricty\ 10
endif
