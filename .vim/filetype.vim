if exists('did_load_filetypes')
  finish
end

augroup filetpedetect
  autocmd!
  autocmd BufRead,BufNewFile *.scala set filetype scala
  autocmd BufRead,BufNewFile *.go    set filetype go
  autocmd BufRead,BufNewFile *.pxi   set filetype pyrex
  autocmd BufRead,BufNewFile *.map   set filetype map
augroup END
