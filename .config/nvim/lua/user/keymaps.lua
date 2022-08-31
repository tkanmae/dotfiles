vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'gj', 'g', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'gk', 'k', { silent = true })

-- Emacs-like key mapping in insert and command mode
vim.keymap.set({ 'i', 'c' }, '<C-f>', '<Right>', { silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>', { silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>', { silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-e>', '<End>', { silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>', { silent = true })
vim.keymap.set({ 'i' }, '<C-h>', '<BS>', { silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-k>', '<Esc>lc$', { silent = true })

-- Move the cursor at the center of window during search
vim.keymap.set('n', 'n', 'nzz', { remap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzz', { remap = true, silent = true })
vim.keymap.set('n', '*', '*zz', { remap = true, silent = true })
vim.keymap.set('n', '#', '#zz', { remap = true, silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { remap = true, silent = true })

-- Clear highlight
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { remap = true, silent = true })

-- Filetype specific options
vim.api.nvim_create_augroup('filetype_keymaps', { clear = true })
-- Open Marked 2 on macOS to preview Markdown files.
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = 'filetype_keymaps',
  pattern = { 'markdown' },
  callback = function()
    if vim.fn.has('macunix') then
      vim.keymap.set(
        'n',
        '<leader>m',
        ":silent !open -a Marked\\ 2.app '%:p'<CR>",
        { remap = true, silent = true, buffer = true }
      )
    end
  end,
})
