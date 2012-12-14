set guioptions&
set guioptions+=a
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=e

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

set background=dark
colorscheme solarized
