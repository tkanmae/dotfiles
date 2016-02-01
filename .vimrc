" Initialization:  "{{{

scriptencoding utf-8

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
set spellfile=$HOME/Dropbox/Apps/Vim/spell/en.utf-8.add

if has("vim_starting")
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand("$HOME/.vim/bundle"))

" NeoBundle  "{{{
NeoBundleFetch 'Shougo/neobundle.vim'

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
  NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ 'autoload': {
        \   'insert': 1,
        \ }}
  NeoBundleFetch 'Shougo/neocomplcache'
else
  NeoBundleFetch 'Shougo/neocomplete.vim'
  NeoBundleLazy 'Shougo/neocomplcache', {
        \ 'autoload': {
        \   'insert': 1,
        \ }}
endif

NeoBundle 'Shougo/unite.vim', {
      \   'commands' : [{'name' : 'Unite',
      \                  'complete' : 'customlist,unite#complete_source'},
      \                 'UniteWithCursorWord', 'UniteWithInput', 'UniteWithBufferDir']
      \ }
NeoBundleLazy 'Shougo/unite-outline', {
      \ 'autoload' : {
      \   'unite_sources' : 'outline'
      \ }}

NeoBundleLazy 'Shougo/neosnippet.vim', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   'filetypes' : 'snippet',
      \   'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
      \ }}
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'ujihisa/neco-look'

NeoBundleLazy 'Shougo/vimfiler.vim', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'commands' : [
      \         {'name' : 'VimFiler',
      \          'complete' : 'customlist,vimfiler#complete' },
      \         {'name' : 'VimFilerExplorer',
      \          'complete' : 'customlist,vimfiler#complete' },
      \         {'name' : 'VimFilerBufferDir',
      \          'complete' : 'customlist,vimfiler#complete' },
      \         {'name' : 'Edit',
      \          'complete' : 'customlist,vimfiler#complete' },
      \         {'name' : 'Write',
      \          'complete' : 'customlist,vimfiler#complete' },
      \         'Read', 'Source'],
      \ 'mappings' : ['<Plug>(vimfiler_)'],
      \ 'explorer' : 1,
      \ }

NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'tpope/vim-surround'
NeoBundleLazy 'tpope/vim-repeat', { 'autoload' : {
      \ 'mappings': '.',
      \ }}

NeoBundle 'LeafCage/yankround.vim'

NeoBundle 'kana/vim-fakeclip'

NeoBundleLazy 'tolecnal/vim-matchit', {
      \ 'autoload' : {
      \   'mappings' : '%',
      \ }}

NeoBundle 'jiangmiao/auto-pairs'

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent', {
      \ 'depends' : 'vim-textobj-user',
      \ }

NeoBundleLazy 'sjl/gundo.vim', {
      \ 'autoload' : {
      \   'commands' : 'GundoToggle'
      \ }}

NeoBundle 'scrooloose/nerdcommenter'

NeoBundle 'godlygeek/tabular'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'thinca/vim-quickrun'

NeoBundle 'vim-scripts/sudo.vim',

NeoBundleLazy 'vim-jp/cpp-vim', {
      \ 'autoload' : {
      \     'filetypes' : ['c','cpp']
      \    },
      \ }
NeoBundleLazy 'Rip-Rip/clang_complete', {
      \ 'autoload' : {
      \     'filetypes' : ['c', 'cpp'],
      \    },
      \ }

NeoBundleLazy 'hynek/vim-python-pep8-indent', {
      \ 'autoload' : {
      \   'filetypes' : ['python', 'python3'],
      \ }}
NeoBundle 'davidhalter/jedi-vim'
NeoBundleLazy 'lambdalisue/vim-pyenv', {
      \ 'depends': ['davidhalter/jedi-vim'],
      \ 'autoload': {
      \   'filetypes': ['python', 'python3'],
      \ }}

NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['css', 'html', 'less']
      \ }}
NeoBundleLazy 'groenewege/vim-less', {
      \ 'autoload' : {
      \   'filetypes' : ['less']
      \ }}

NeoBundleLazy 'pangloss/vim-javascript', {
      \ 'autoload' : {
      \   'filetypes' : ['javascript']
      \ }}
NeoBundleLazy 'jelera/vim-javascript-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['javascript']
      \ }}
NeoBundleLazy 'marijnh/tern_for_vim', {
      \ 'build' : { 'others' : 'npm install' },
      \ 'autoload' : {
      \   'filetypes' : ['javascript']
      \ }}

NeoBundleLazy 'mrk21/yaml-vim', {
      \ 'name' : 'vim-yaml-indent',
      \ 'autoload' : {
      \   'filetypes' : ['yaml']
      \ }}
NeoBundleLazy 'stephpy/vim-yaml', {
      \ 'name' : 'vim-yaml-syntax',
      \ 'autoload' : {
      \   'filetypes' : ['yaml']
      \ }}

NeoBundleLazy 'Glench/Vim-Jinja2-Syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['html']
      \ }}

NeoBundleLazy 'zaiste/tmux.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['tmux']
      \ }}

NeoBundleLazy 'fsouza/go.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['go'],
      \ }}

" NeoBundleLazy 'JuliaLang/julia-vim', {
"       \ 'autoload' : {
"       \   'filetypes' : ['julia'],
"       \ }}

NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', {
      \ 'autoload' : {
      \   'filetypes' : ['tex']
      \ }}

NeoBundleLazy 'tpope/vim-markdown', {
      \ 'autoload' : {
      \   'filetypes' : ['markdown']
      \ }}

NeoBundleLazy 'vim-pandoc/vim-pandoc', {
      \ 'autoload' : {
      \   'filetypes' : ['pandoc']
      \ }}

NeoBundleLazy 'honza/dockerfile.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['dockerfile']
      \ }}

NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'

call neobundle#end()

"}}} NeoBundle

filetype plugin indent on
syntax enable
NeoBundleCheck
"
"}}} Initialization


" Encoding:  "{{{
"
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double
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

set foldmethod=syntax

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

set splitbelow
set splitright
set noequalalways

if !has("gui_running")
  set t_Co=256
  set background=dark
  colorscheme solarized
endif
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


" Plugins:  "{{{
"
if s:meet_neocomplete_requirements()
  if neobundle#tap('neocomplete.vim')  "{{{
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_fuzzy_completion = 0
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#manual_completion_start_length = 0
    let g:neocomplete#min_keyword_length = 3
    let g:neocomplete#syntax#min_length = 3
    let g:neocomplete#enable_cursor_hold_i = 0
    let g:neocomplete#enable_insert_char_pre = 0
    let g:neocomplete#skip_auto_completion_time = '0.5'
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#max_list = 100

    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#force_overwrite_completefunc = 1
    if !exists('g:neocomplete#force_omni_patterns')
      let g:neocomplete#force_omni_patterns = {}
    endif
    if !exists('g:neocomplete#sources#omni#functions')
      let g:neocomplete#sources#omni#functions = {}
    endif

    let g:neocomplete#sources#omni#functions.go = 'gocomplete#Complete'
    let g:neocomplete#sources#omni#input_patterns.go =
          \ '[^.[:digit:] *\t]\.'

    " For clang_complete
    let g:clang_complete_auto = 0
    let g:clang_auto_select = 0
    let g:clang_use_library = 1
    let g:neocomplete#force_omni_patterns.c =
          \ '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#force_omni_patterns.cpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For jedi-vim
    let g:neocomplete#force_omni_patterns.python =
          \ '\h\w*\|[^. \t]\.\w*'

    if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    let g:neocomplete#text_mode_filetypes = {
          \ 'text': 1,
          \ 'tex': 1,
          \ 'markdown': 1,
          \ 'pandoc': 1,
          \ 'gitcommit': 1
          \ }

    " mappings "{{{
    " <C-f>, <C-b>: page move.
    inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
    inoremap <expr><C-b> pumvisible() ? "\<PageUp>"   : "\<Left>"

    inoremap <expr><C-y> pumvisible() ? neocomplete#close_popup() :  "\<C-r>\""
    inoremap <expr><C-e> pumvisible() ? neocomplete#cancel_popup() : "\<End>"
    inoremap <expr><C-h> neocomplete#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS>  neocomplete#smart_close_popup() . "\<C-h>"

    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#smart_close_popup() . "\<CR>"
    endfunction

    inoremap <expr><C-x><C-f>
          \ neocomplete#start_manual_complete('file')

    call neobundle#untap()
  endif  "}}}
else
  if neobundle#tap('neocomplcache') "{{{
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 0
    " Use camel case completion.
    let g:neocomplcache_enable_camel_case_completion = 0
    " Use underbar completion.
    let g:neocomplcache_enable_underbar_completion = 0
    " Use fuzzy completion.
    let g:neocomplcache_enable_fuzzy_completion = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    " Set auto completion length.
    let g:neocomplcache_auto_completion_start_length = 2
    " Set manual completion length.
    let g:neocomplcache_manual_completion_start_length = 0
    " Set minimum keyword length.
    let g:neocomplcache_min_keyword_length = 3
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_enable_cursor_hold_i = 0
    let g:neocomplcache_cursor_hold_i_time = 300
    let g:neocomplcache_enable_insert_char_pre = 0
    let g:neocomplcache_enable_prefetch = 0
    let g:neocomplcache_skip_auto_completion_time = '0.5'
    let g:neocomplcache_max_list = 100

    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
    endif
    if !exists('g:neocomplcache_omni_functions')
      let g:neocomplcache_omni_functions = {}
    endif

    let g:neocomplcache_omni_patterns.go = '[^.[:digit:] *\t]\.'
    let g:neocomplcache_omni_functions.go = 'gocomplete#Complete'

    " For clang_complete
    let g:neocomplcache_force_overwrite_completefunc = 1
    let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:clang_complete_auto = 0
    let g:clang_auto_select = 0
    let g:clang_use_library = 1

    " For jedi-vim
    let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'

    if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
    endif

    let g:neocomplcache_text_mode_filetypes = {
          \ 'text': 1,
          \ 'tex': 1,
          \ 'markdown': 1,
          \ 'pandoc': 1,
          \ 'gitcommit': 1
          \ }

    " mappings
    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
    inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS>  neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><C-y> neocomplcache#close_popup()
    inoremap <expr><C-e> neocomplcache#cancel_popup()

    call neobundle#untap()
  endif "}}}
endif

if neobundle#tap('unite.vim')  "{{{
  function! neobundle#tapped.hooks.on_source(bundle)
    nnoremap [unite] <Nop>
    nmap <Leader>u [unite]
    " List file's directory.
    nnoremap [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    " List buffers.
    nnoremap [unite]b :<C-u>Unite buffer -buffer-name=buffer<CR>
    " List recently used files.
    nnoremap [unite]m :<C-u>Unite file_mru -buffer-name=file_mru<CR>
    " List registers.
    nnoremap [unite]r :<C-u>Unite -buffer-name=register register<CR>
    " List current directory.
    nnoremap [unite]c :<C-u>Unite file -buffer-name=file<CR>
    " List buffers and recently used files.
    nnoremap [unite]u :<C-u>Unite buffer file_mru file_rec<CR>
    " Grep
    nnoremap [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
    " List outline.
    nnoremap [unite]o :<C-u>Unite outline<CR>

    let g:unite_enable_start_insert = 1
    let g:unite_source_file_mru_time_format = ''
    let g:unite_force_overwrite_statusline = 0

    call unite#custom#source('file,file_mru,file_rec', 'ignore_pattern',
          \ '\%(^\|/\)\.\.\?$\|\~$\|\.\%(o|a|exe|dll|bak|DS_Store|zwc|sw[po]\)$' .
          \ '\|\.\%(aux\|bbl\|blg\|loa\|lof\|lot\|fdb_latexmk\|fls\|synctex\.gz\|toc\)$' .
          \ '\|\.\%(pyc\|pyo\)$')

    if executable('ag')
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
      let g:unite_source_grep_recursive_opt = ''
    endif

    autocmd Filetype unite call s:unite_settings()
    function! s:unite_settings()
      " Key mapping in unite.vim
      imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
      nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
      inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
      nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
      inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
      nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
      inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
    endfunction

  endfunction
  call neobundle#untap()
endif  "}}}

if neobundle#tap('vimfiler.vim') "{{{
  nnoremap <silent><Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
  nnoremap <silent><Leader>fi :<C-u>VimFilerExplorer<CR>

  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimfiler_ignore_pattern = '^\.' .
        \ '\|\.\%(pyc|pyo\)$' .
        \ '\|\.\%(aux\|bbl\|blg\|loa\|lof\|lot\|fdb_latexmk\|fls\|synctex\.gz\|toc\)$'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet.vim') "{{{
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  call neobundle#untap()
endif  "}}}

" vim-airline  "{{{
let g:airline_theme = "solarized"
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline_inactive_collapse = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
"}}}  vim-airline

" syntastic  "{{{
let g:syntastic_check_on_open = 1
let g:syntastic_auto_jump = 0
let g:syntastic_c_compiler = 'clang'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_cpp_config_file = '.clang_complete'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['tex'] }
"}}}  syntastic

if neobundle#tap('vim-quickrun')  "{{{
  let g:quickrun_config = {}
  let g:quickrun_config['cpp'] = {
        \   'cmdopt': '-Wall -Wextra -pedantic -std=c++11'
        \ }

  call neobundle#untap()
endif  "}}}

if neobundle#tap('jedi-vim')  "{{{
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#documentation_command = '<Leader>k'
  let g:jedi#use_tabs_not_buffers = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#show_all_signatures = "0"

  call neobundle#untap()
endif  "}}}

" NERD_comments.vim
let NERDShutUp=1
let NERDSpaceDelims=1

if neobundle#tap('yankround.vim')
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)

  call neobundle#untap()
endif

" Gundo.vim
let g:gundo_prefer_python3 = 1
nnoremap U :<C-u>GundoToggle<CR>

" tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" python.vim
let python_highlight_all = 1

if neobundle#tap('LaTeX-Box')  "{{{
  let g:tex_flavor = "latex"
  let g:LatexBox_ref_pattern = '\c\\\a*ref\*\?\_\s*{'
  let g:LatexBox_viewer = "open -a Skim.app"
  let g:LatexBox_latexmk_preview_continuously = 1
  let g:LatexBox_split_width = 40
  let g:LatexBox_split_side = "rightbelow"
  let g:LatexBox_complete_inlineMath = 1
  map <silent> <Leader>ls :silent
        \ !/Applications/Skim.app/Contents/SharedSupport/displayline
        \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
        \ "%:p" <CR>

  call neobundle#untap()
endif "}}}

" clang_complete
if has("mac")
  " This variable have to be set outside neobundle's hooks._on_source().
  let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
endif
let g:clang_user_options = '-std=c++11'

"}}}  Plugins


" Key mapping:  "{{{
"
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

"}}}  Key mapping


" vim: foldmethod=marker :
