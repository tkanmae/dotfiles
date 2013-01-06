" Initialization:  "{{{
"
" Diable vim compatible mode.
set nocompatible

" Use ',' instead of '\'.
let mapleader=','
" Use <Leader> in global plugins.
let g:mapleader=','
" Use <LocalLeader> in filetype plugins.
let g:maplocalleader=','

" Reset augroup.
augroup vimrc
  autocmd!
augroup END

" Set spellfile location.
set spellfile=$HOME/Dropbox/home/.vim/spell/en.utf-8.add

if has("vim_starting")
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand("~/.vim/bundle"))

" neobundle.vim  "{{{
NeoBundle "Shougo/neobundle.vim"
NeoBundle "Shougo/neocomplcache"
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/vimfiler"
NeoBundle "h1mesuke/unite-outline"
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundleLazy "tpope/vim-surround"
NeoBundleLazy "tpope/vim-repeat", { 'autoload' : {
      \ 'mappings': '.',
      \ }}
NeoBundle "kana/vim-fakeclip"
NeoBundleLazy "tsaleh/vim-matchit", '', 'same', { 'autoload' : {
      \ 'mappings' : '%',
      \ }}
NeoBundleLazy 'kana/vim-smartword', '', 'same', { 'autoload' : {
      \ 'mappings' : [
      \   '<Plug>(smartword-w)', '<Plug>(smartword-b)', '<Plug>(smartword-ge)']
      \ }}
NeoBundleLazy 'sjl/gundo.vim', { 'autoload' : {
      \ 'commands' : 'GundoToggle'
      \ }}
NeoBundle "scrooloose/nerdcommenter"
NeoBundle "godlygeek/tabular"

" Python
NeoBundleLazy 'davidhalter/jedi-vim', { 'autoload' : {
      \ 'filetypes' : ['python', 'python3'],
      \ }}
NeoBundleLazy "mitechie/pyflakes-pathogen", { 'autoload' : {
      \ 'filetypes' : ['python']
      \ }}

" JavaScript
NeoBundleLazy "pangloss/vim-javascript", { 'autoload' : {
      \ 'filetypes' : ['javascript']
      \ }}
NeoBundleLazy "jelera/vim-javascript-syntax", { 'autoload' : {
      \ 'filetypes' : ['javascript']
      \ }}

" Go
NeoBundleLazy "fsouza/go.vim", { 'autoload' : {
      \ 'filetypes' : ['go'],
      \ }}

" LaTeX
NeoBundleLazy "LaTeX-Box-Team/LaTeX-Box", { 'autoload' : {
      \ 'filetypes' : ['tex']
      \ }}

" Pandoc
NeoBundle "vim-pandoc/vim-pandoc"

" Color scheme
NeoBundle "vim-scripts/wombat256.vim"
NeoBundle "altercation/vim-colors-solarized"

"}}}  neobundle.vim

filetype plugin indent on
syntax enable
"
" }}} Initialization


" Encoding:  "{{{
"
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double
"
" }}} Encoding


" Search:  "{{{
"
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
"
"}}} Search


" Edit:  "{{{
"
set noswapfile

set clipboard& clipboard+=unnamed

" Re-load if files are modified.
set autoread

set backspace=indent,eol,start

set smarttab
set expandtab
set shiftround
set hidden
set foldmethod=syntax
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

" Delete trailing white spaces in buffer.
autocmd vimrc BufWritePre * :%s/\s\+$//e

" Set up backup.
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
set shortmess&
set shortmess+=I

set linebreak
set showbreak=>>>
set breakat=\ \	;:,!?

set list
set listchars=tab:>-,trail:-,extends:>,precedes:<

set wrap
set whichwrap+=h,l,<,>,[,],b,s,~

set laststatus=2
set cmdheight=2
set cmdwinheight=5
set showcmd
set ruler
set cursorline
set title
set lazyredraw

set scrolloff=3
set sidescrolloff=5

set nowildmenu
set wildmode=list:longest,full
set history=128

" Completion
set completeopt=menuone
" Dont't complete from other buffers.
set complete=.
" Set pop-up menu height
set pumheight=20

set splitbelow
set splitright
set noequalalways

set statusline=[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}
set statusline+=\ %f%=\ [%<%{fnamemodify(expand('%'),':~:h')}]\ (%l,%c%V)\ %6P

set t_Co=256

set background=dark
colorscheme solarized
"
"}}} View


" Syntax:  "{{{
"
set autoindent
set smartindent

augroup vimrc
  autocmd FileType c,cpp setlocal cindent shiftwidth=2
  autocmd FileType Makefile setlocal noexpandtab
  autocmd FileType gitcommit setlocal spell
  autocmd FileType python setlocal shiftwidth=4 textwidth=80
  autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType vim setlocal shiftwidth=2
  autocmd FileType yaml setlocal shiftwidth=2
  autocmd FileType html setlocal shiftwidth=2
  autocmd FileType css setlocal shiftwidth=2
  autocmd FileType javascript setlocal shiftwidth=2
  autocmd FileType go setlocal tabstop=4
  autocmd FileType txt,tex,rest,markdown,pandoc setlocal spell wrap nosmartindent
  autocmd FileType tex setlocal shiftwidth=2 textwidth=80 noautoindent formatoptions=tcq
  autocmd FileType bib setlocal shiftwidth=2
augroup END

" Python
let g:python_highlight_all = 1

" Close the help window by typing q.
au vimrc FileType help nnoremap <buffer> q <C-w>c
"
" }}}  Syntax


" Plugins:  "{{{
"
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
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.go =  '\h\w*\%.'
let g:neocomplcache_omni_functions.go = 'gocomplete#Complete'

" For jedi-vim
let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 0
autocmd vimrc FileType python*
    \ NeoBundleSource jedi-vim | let b:did_ftplugin = 1
let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'

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

" smartword.vim
" Replace w and others with smartword-mappings
nmap w  <Plug>(smartword-w)
nmap b  <Plug>(smartword-b)
nmap ge <Plug>(smartword-ge)
xmap w  <Plug>(smartword-w)
xmap b  <Plug>(smartword-b)
omap w  <Plug>(smartword-w)
omap b  <Plug>(smartword-b)
omap ge <Plug>(smartword-ge)

" Gundo.vim
nnoremap U :<C-u>GundoToggle<CR>

" tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" python.vim
let python_highlight_all = 1

" LaTeX-Box
let g:tex_flavor = "tex"
let g:LatexBox_ref_pattern = '\c\\\a*ref\*\?\_\s*{'
let g:LatexBox_viewer = "open -a Skim.app"
let g:LatexBox_latexmk_options = '-pvc'
let g:LatexBox_split_width = 40
let g:LatexBox_split_side = "rightbelow"
map <silent> <Leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline
\ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>" "%:p" <CR>""")"'')
"
"}}}  Plugins


" Key mapping:  "{{{
"
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

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-y> <C-r>*

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
"
"}}}  Key bindings


" vim: foldmethod=marker :
