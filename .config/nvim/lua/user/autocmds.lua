vim.api.nvim_create_augroup('goodies', { clear = true })
-- Delete all trailing spaces
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = 'goodies',
  pattern = { '*' },
  callback = function()
    if vim.opt.paste then
      vim.opt.paste = false
    end
  end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'goodies',
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
