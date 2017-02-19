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

