if &compatible
  set nocompatible
endif

" Reset augroup.
augroup vimrc
  autocmd!
augroup END

function! s:source_rc(path, ...) abort
  let l:use_global = get(a:000, 0, !has('vim_starting'))
  let l:abspath = resolve(expand('~/.vim/rc/' . a:path))
  if !l:use_global
    execute 'source' fnameescape(l:abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let l:content = map(readfile(l:abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  " create tempfile and source the tempfile
  let l:tempfile = tempname()
  try
    call writefile(l:content, l:tempfile)
    execute 'source' fnameescape(l:tempfile)
  finally
    if filereadable(l:tempfile)
      call delete(l:tempfile)
    endif
  endtry
endfunction"}}}

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

let g:python3_host_prog = $HOME . '/.miniconda3/envs/neovim/bin/python'

" Load dein.
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir !=# '' || &runtimepath !~# '/dein.vim'
  if s:dein_dir ==# '' && &runtimepath !~# '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

call s:source_rc('mapping.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('dein.rc.vim')

syntax on
filetype plugin indent on
