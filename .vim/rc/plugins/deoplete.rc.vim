call deoplete#custom#option('async_timeout', 0)
call deoplete#custom#option('auto_complete_delay', 0)
call deoplete#custom#option('auto_refresh_delay', 10)
call deoplete#custom#option('camel_case', v:true)
call deoplete#custom#option('refresh_always', v:true)
call deoplete#custom#option('ignore_sources',
      \ {'_': ['buffer']})
call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_]\k*\(?',
      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
      \ })

call deoplete#custom#source('_', 'matchers',
      \ ['matcher_fuzzy', 'matcher_length'])
call deoplete#custom#source('look', 'filetypes', ['help', 'gitcommit'])
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'matcher_length',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-j>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <expr><C-k>  pumvisible() ? "\<C-p>" : "\<C-k>"

inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-g> deoplete#refresh()
inoremap <expr><C-e> deoplete#cancel_popup()
inoremap <silent><expr><C-l> deoplete#complete_common_string()
"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

inoremap <expr> '  pumvisible() ? deoplete#close_popup() : "'"
