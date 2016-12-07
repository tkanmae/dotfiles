" Initialization:  "{{{

scriptencoding utf-8

" Use ',' instead of '\'.
let mapleader=','
" Use <Leader> in global plugins.
let g:mapleader=','
" Use <LocalLeader> in filetype plugins.
let g:maplocalleader=','

" Set spellfile location.
set spellfile=$HOME/Dropbox/Apps/Vim/spell/en.utf-8.add

" Reset augroup.
augroup vimrc
  autocmd!
augroup END

" Set up dein.vim
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

let s:plugin_dir = expand('~/.vim/bundle/')
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_dir

if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_dir)
endif

if dein#load_state(s:plugin_dir)
  call dein#begin(s:plugin_dir)

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})

  call dein#add('Shougo/neocomplete.vim', { 'if' : has('lua'), 'on_i' : 1, 'lazy': 1})
  call dein#add('ujihisa/neco-look', {'depends': ['neocomplete.vim']})

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets', {'depends': ['neosnippet']})

  call dein#add('Shougo/unite.vim', {'depends': ['vimproc.vim'], 'on_cmd': ['Unite'], 'lazy': 1})
  call dein#add('Shougo/neomru.vim', {'depends': ['unite.vim']})
  call dein#add('Shougo/unite-outline', {'depends': ['unite.vim']})
  call dein#add('Shougo/vimfiler.vim')

  call dein#add('jiangmiao/auto-pairs')
  call dein#add('kana/vim-fakeclip')
  call dein#add('Konfekt/FastFold')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-repeat')
  call dein#add('thinca/vim-visualstar')
  call dein#add('LeafCage/yankround.vim')
  call dein#add('tolecnal/vim-matchit', {'lazy': 1, 'on_map': ['%']})
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('godlygeek/tabular')
  call dein#add('kana/vim-textobj-user')
  call dein#add('kana/vim-textobj-indent', {'depends': 'vim-textobj-user'})
  call dein#add('Shougo/context_filetype.vim')
  call dein#add('sudo.vim')

  call dein#add('scrooloose/syntastic')

  call dein#add('tpope/vim-fugitive')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('vim-scripts/wombat256.vim', {'script_type': 'colors'})
  call dein#add('w0ng/vim-hybrid', {'script_type': 'colors'})
  call dein#add('altercation/vim-colors-solarized', {'script_type': 'colors'})

  call dein#add('vim-jp/cpp-vim', {'on_ft': ['c', 'cpp']})
  call dein#add('Rip-Rip/clang_complete', {'on_ft': ['c', 'cpp']})

  call dein#add('fsouza/go.vim', {'on_ft': ['go']})

  call dein#add('davidhalter/jedi-vim', {'on_ft': ['python', 'python3']})
  call dein#add('hynek/vim-python-pep8-indent', {'on_ft' : ['python', 'python3']})
  call dein#add('lambdalisue/vim-pyenv', {'depends': ['jedi-vim'], 'on_ft': ['python', 'python3']})

  call dein#add('jalvesaq/Nvim-R', {'on_ft': ['R']})

  call dein#add('zaiste/tmux.vim', {'on_ft': ['tmux']})

  call dein#add('honza/dockerfile.vim', {'on_ft': ['dockerfile']})

  call dein#add('pangloss/vim-javascript', {'on_ft': ['javascript']})
  call dein#add('jelera/vim-javascript-syntax', {'on_ft': ['javascript']})
  call dein#add('marijnh/tern_for_vim', {'build' : 'npm install', 'on_ft' : ['javascript']})

  call dein#add('othree/html5.vim', {'on_ft' : ['html']})
  call dein#add('hail2u/vim-css3-syntax', {'on_ft' : ['css', 'html', 'less']})
  call dein#add('Glench/Vim-Jinja2-Syntax', {'on_ft': ['html']})
  call dein#add('groenewege/vim-less', {'on_ft': ['less']})

  call dein#add('mrk21/yaml-vim', {'name': 'yaml-indent', 'on_ft': ['yaml']})
  call dein#add('stephpy/vim-yaml', {'name': 'yaml-syntax', 'on_ft': ['yaml']})

  call dein#add('LaTeX-Box-Team/LaTeX-Box', {'on_ft': ['tex']})

  call dein#add('tpope/vim-markdown', {'on_ft': ['markdown']})

  call dein#add('vim-pandoc/vim-pandoc', {'on_ft': ['pandoc']})

  call dein#end()
  call dein#save_state()
endif


filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
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

" set foldmethod=syntax

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
" Ignore the case of matching text.
set infercase

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
if dein#tap('neocomplete.vim')  "{{{
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

  " mappings
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
endif  "}}}

if dein#tap('unite.vim')  "{{{
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

  let s:unite_ignore_pattern = '\.\(gif\|jpe\?g\|png\|webp\)$' .
        \ '\|\%(^\|/\)\.\.\?$\|\~$\|\.\%(o|a|exe|dll|bak|DS_Store|zwc|sw[po]\)$' .
        \ '\|\.\%(aux\|bbl\|blg\|loa\|lof\|lot\|fdb_latexmk\|fls\|synctex\.gz\|toc\)$' .
        \ '\|\.\%(pyc\|pyo\)$'
  call unite#custom#source('file_rec/async', 'ignore_pattern', s:unite_ignore_pattern)
  call unite#custom#source('file_rec/git', 'ignore_pattern', s:unite_ignore_pattern)

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
endif  "}}}

if dein#tap('vimfiler.vim') "{{{
  nnoremap <silent><Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
  nnoremap <silent><Leader>fi :<C-u>VimFilerExplorer<CR>

  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimfiler_ignore_pattern = '^\.' .
        \ '\|\.\%(pyc|pyo\)$' .
        \ '\|\.\%(aux\|bbl\|blg\|loa\|lof\|lot\|fdb_latexmk\|fls\|synctex\.gz\|toc\)$'
endif "}}}

if dein#tap('neosnippet.vim') "{{{
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
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

if dein#tap('vim-quickrun')  "{{{
  let g:quickrun_config = {}
  let g:quickrun_config['cpp'] = {
        \   'cmdopt': '-Wall -Wextra -pedantic -std=c++11'
        \ }
endif  "}}}

if dein#tap('jedi-vim')  "{{{
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#documentation_command = '<Leader>k'
  let g:jedi#use_tabs_not_buffers = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#show_call_signatures = "0"
endif  "}}}

" NERD_comments.vim
let NERDShutUp=1
let NERDSpaceDelims=1

if dein#tap('yankround.vim')
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
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

if dein#tap('LaTeX-Box')  "{{{
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
