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

