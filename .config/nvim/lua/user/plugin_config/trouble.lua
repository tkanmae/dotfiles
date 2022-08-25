local ok, trouble = pcall(require, 'trouble')
if not ok then
  print('Module not found: trouble')
  return
end

trouble.setup({
  signs = {
    error = 'E',
    warning = 'W',
    hint = 'H',
    information = 'I',
    other = 'O',
  },
})

vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true })
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true })
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true })
vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { silent = true })
vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { silent = true })
