augroup filetpedetect
  au!
  au BufRead,BufNewFile *.scala setfiletype scala
  au BufRead,BufNewFile *.go    setfiletype go
  au BufRead,BufNewFile *.pxi   setfiletype pyrex
  au BufRead,BufNewFile *.map   setfiletype map
augroup END
