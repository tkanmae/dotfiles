vim.api.nvim_create_augroup('goodies', { clear = true })
-- Disable paste when leaving insert mode.
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = 'goodies',
  pattern = { '*' },
  callback = function()
    if vim.opt.paste then
      vim.opt.paste = false
    end
  end,
})
-- Delete all trailing spaces
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'goodies',
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
