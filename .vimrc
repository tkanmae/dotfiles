set nocompatible
filetype off

if has("vim_starting")
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand("~/.vim/bundle"))

NeoBundle "Shougo/neobundle.vim"
NeoBundle "Shougo/vimproc"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/neocomplcache"
NeoBundle "Shougo/neosnippet"
NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-repeat"
NeoBundle "vim-scripts/YankRing.vim"
NeoBundle "scrooloose/nerdcommenter"
NeoBundle "kana/vim-fakeclip"
NeoBundle "tsaleh/vim-matchit"
NeoBundle "kana/vim-smartword"
NeoBundle "godlygeek/tabular"
NeoBundle "majutsushi/tagbar"
NeoBundle "vim-pandoc/vim-pandoc"
" Unite
NeoBundle "Shougo/unite.vim"
NeoBundle "h1mesuke/unite-outline"
" Git
NeoBundle "tpope/vim-git"
NeoBundle "tpope/vim-fugitive"
" Python
NeoBundle "davidhalter/jedi-vim"
NeoBundle "vim-scripts/python.vim--Vasiliev"
NeoBundle "mitechie/pyflakes-pathogen"
" LaTeX
NeoBundle "LaTeX-Box-Team/LaTeX-Box"
" JavaScript
NeoBundle "pangloss/vim-javascript"
NeoBundle "jelera/vim-javascript-syntax"
" Go
NeoBundle "fsouza/go.vim"
" Color scheme
NeoBundle "vim-scripts/wombat256.vim"
NeoBundle "altercation/vim-colors-solarized"

filetype plugin on
filetype indent off

augroup vimrc
  autocmd!
augroup END


" Basic
set shortmess&
set shortmess+=I
set backspace=indent,eol,start
set scrolloff=3
set sidescrolloff=5
set noswapfile
set history=128
set hidden
set autoread
set autochdir
set wildmenu
set wildignore=*.o,*.a,*.so,*.pyc
set cmdheight=1
set laststatus=2
set lazyredraw
set clipboard=unnamed
set showmode

set t_Co=256

set textwidth=0
set tabstop=8
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent

set timeoutlen=500
set title
set ruler
set cursorline
set showmatch
set matchtime=3
set noequalalways
set splitbelow
set splitright

set hlsearch
set incsearch
set wrapscan

let mapleader=","
let maplocalleader=","

" Encoding
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double

" Status line
set statusline=[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}
set statusline+=%{fugitive#statusline()}
set statusline+=\ %f%=\ [%<%{fnamemodify(expand('%'),':~:h')}]\ (%l,%c%V)\ %6P

set background=dark
colorscheme solarized

set virtualedit=block
set grepprg=grep\ -nH\ $*
set spellfile=$HOME/Dropbox/home/.vim/spell/en.utf-8.add

" Completion
set completeopt=longest,menuone
set complete=.,w,b,t
set pumheight=20                " Set the pop-up menu height to 20 lines.
" IME
set imdisable
set iminsert=0
set imsearch=0
" Appearance
syntax on
set linebreak                   " Wrap at 'breakat' instead of the last char
set foldmethod=syntax           " Fold text according to syntax.


" Plugins {{{

" unite
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_time_format = ''
" List file's directory
nnoremap [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" List buffers
nnoremap [unite]b :<C-u>Unite buffer -buffer-name=buffer<CR>
" List recently used files
nnoremap [unite]m :<C-u>Unite file_mru -buffer-name=file_mru<CR>
" List current directory
nnoremap [unite]c :<C-u>Unite file -buffer-name=file<CR>
" List buffers and recently used files
nnoremap [unite]u :<C-u>Unite buffer file_mru file_rec<CR>
" List outline
nnoremap [unite]o :<C-u>Unite outline<CR>
" Key mapping in unite.vim
autocmd Filetype unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_max_list = 20
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.go =  '\h\w*\%.'
let g:neocomplcache_omni_functions.go = 'gocomplete#Complete'

" neosnippet
if !exists("g:neosnippet#snippets_directory")
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
endif
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" YankRing
set viminfo+=!
let g:yankring_history_file='.yankring_history'

" NERD_comments.vim
let NERDShutUp=1
let NERDSpaceDelims=1

" tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" tagbar
let g:tagbar_width = 35
let g:tagbar_sort = 0
nnoremap <silent> <F8> :TagbarToggle<CR>

" python.vim
let python_highlight_all = 1
let python_print_as_function = 1

" jedi-vim
let g:jedi#auto_initialization = 1
let g:jedi#show_function_definition = 1
let g:jedi#popup_on_dot = 0

" LaTeX-Box
let g:tex_flavor = "tex"
let g:LatexBox_ref_pattern = '\c\\\a*ref\*\?\_\s*{'
let g:LatexBox_viewer = "open -a Skim.app"
let g:LatexBox_latexmk_options = '-pvc'
let g:LatexBox_split_width = 40
let g:LatexBox_split_side = "rightbelow"
map <silent> <Leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline
\ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>" "%:p" <CR>""")"'')

" }}} Plugins


" Auto commands {{{

" Close the help window by typing q.
au vimrc FileType help nnoremap <buffer> q <C-w>c
" Delete trailing white spaces in buffer.
au vimrc BufWritePre * :%s/\s\+$//e

augroup file_type_options
  au!
  au InsertLeave * set nopaste
  au FileType c,cpp setl et ai cin sta sw=2 sts=2
  au FileType Makefile setl noet
  au FileType gitcommit setl spell
  au FileType python setl et sw=4 sts=4 tw=80
  au FileType python setl ai si cinwords=if,elif,else,for,while,try,except,finally,def,class
  au FileType python let b:did_ftplugin = 1
  au FileType vim setl sw=2
  au FileType tex setl spell nocin nosi tw=80 sw=2
  au FileType tex setl wrap fo=tcq
  au FileType txt setl spell wrap nocin nosi
  au FileType bib setl sw=2
  au FileType rest setl spell nocin nosi
  au FileType markdown setl spell nocin nosi
  au FileType pandoc setl spell nocin nosi
  au FileType yaml setl sw=2
  au FileType html setl sw=2
  au FileType css setl sw=2
  au FileType javascript setl sw=2
  au FileType go setl ts=4
augroup END

" }}}  Auto commands

" ==============================================================================
" Backup
" ==============================================================================
" {{{
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
" }}}
" ==============================================================================


" Key bindings {{{

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
inoremap <C-k> <Esc>lc$

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

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

" }}}  Key bindings
