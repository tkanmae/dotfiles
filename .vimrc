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

let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim/bin/python'

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


" Keymapping: "{{{
"
" Use ',' instead of '\'.
let mapleader=','
" Use <Leader> in global plugins.
let g:mapleader=','
" Use <LocalLeader> in filetype plugins.
let g:maplocalleader=','

nnoremap Q <Nop>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <C-k> <Esc>lc$

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-y> <C-r>*

" Move the cursor at the center of window during search.
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Delete highlights
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" Toggle paste
set pastetoggle=<F10>

" Open the current buffer with Marked.app
if has('macunix')
  nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>
endif
"
" }}} Keymapping

" Encoding:  "{{{
"
scriptencoding utf-8

set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac
"
"}}} Encoding


" Search: "{{{
"
set ignorecase
set smartcase
set incsearch
set wrapscan
"
"}}} Search


" Edit:  "{{{
"
set backspace=indent,eol,start

" Use clipboard register.
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" Re-load if files are modified.
set autoread
set hidden
set switchbuf=useopen

set shiftwidth=4
set smarttab
set expandtab
set shiftround

set virtualedit=block

set grepprg=grep\ -nH\ $*

set showmatch
set matchtime=3
set matchpairs+=<:>

set imdisable
set iminsert=0
set imsearch=0

" Key mapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100

" Disable paste when leaving insert mode.
autocmd vimrc InsertLeave * if &paste | set nopaste | endif
" Update diff.
autocmd vimrc InsertLeave * if &l:diff | diffupdate | endif
" Delete trailing white spaces in buffer.
autocmd vimrc BufWritePre * :%s/\s\+$//e

" Set up backup.
set noswapfile
set backup
set backupdir=$HOME/.vim-backup
autocmd vimrc BufWritePre,FileWritePre,FileAppendPre * call UpdateBackupFile()
function! UpdateBackupFile()
  let basedir = "$HOME/.vim-backup"
  let dir = strftime(basedir . "/%Y-%m/%d", localtime())
  if !isdirectory(dir)
    let retval = system("mkdir -p " . dir)
    let retval = system("chown takeshi:staff " . dir)
  endif
  exe "set backupdir=" . dir
  let time = strftime("%H%M", localtime())
  exe "set backupext=." . time
endfunction
"
"}}} Edit


" View:  "{{{
"
set termguicolors

set shortmess&
set shortmess+=I

set linebreak
set showbreak=...
set breakat=\ \	;:,!?

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

set wrap
set whichwrap+=h,l,<,>,[,],b,s,~

set laststatus=2
set cmdheight=1
set cmdwinheight=5
set showcmd
set ruler
set cursorline
set title
set lazyredraw
set updatetime=100

set scrolloff=2
set sidescrolloff=5

set nowildmenu
set wildmode=list:longest,full
set history=128

" Completion
set completeopt-=preview
set completeopt=menuone
" Dont't complete from other buffers.
set complete=.
" Set pop-up menu height
set pumheight=20
" Ignore the case of matching text.
set infercase

set splitbelow
set splitright
set noequalalways
"
"}}} View


" Syntax:  "{{{
"
set autoindent
set smartindent

augroup vimrc
  autocmd FileType c,cpp setlocal cindent shiftwidth=2
  autocmd FileType Makefile setlocal noexpandtab
  autocmd FileType gitcommit setlocal spell textwidth=72
  autocmd FileType txt,tex,rest,markdown,pandoc setlocal spell nosmartindent
  autocmd FileType tex setlocal formatoptions=tcq
  autocmd FileType python setlocal omnifunc=jedi#completions

  let g:markdown_fenced_languages = [
        \ 'python',
        \ 'css',
        \ 'javascript',
        \ 'yaml',
        \ ]

  " Close the help window by typing q.
  autocmd vimrc FileType help nnoremap <buffer> q <C-w>c
augroup END

" Python
let g:python_highlight_all = 1
"
"}}}  Syntax

" Set spellfile location.
set spellfile=$HOME/Dropbox/Apps/Vim/spell/en.utf-8.add

call s:source_rc('dein.rc.vim')

syntax on
filetype plugin indent on
