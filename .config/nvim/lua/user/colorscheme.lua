vim.cmd([[
try
  colorscheme catppuccin-macchiato
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
