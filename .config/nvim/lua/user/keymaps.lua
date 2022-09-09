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

-- Plugin specific key mapping
vim.api.nvim_create_augroup('plugin_keymaps', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  group = 'plugin_keymaps',
  callback = function()
    local packer_ok, _ = pcall(require, 'packer')
    if not packer_ok then
      print('Module not found: packer')
    end

    local is_available = function(plugin)
      return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
    end

    if is_available('telescope.nvim') then
      vim.keymap.set('n', '<leader>uf', function()
        require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })
      end)
      vim.keymap.set('n', '<leader>um', function()
        require('telescope.builtin').oldfiles()
      end)
      vim.keymap.set('n', '<leader>ug', function()
        require('telescope.builtin').live_grep()
      end)
      vim.keymap.set('n', '<leader>ub', function()
        require('telescope.builtin').buffers()
      end)
      vim.keymap.set('n', '<leader>ur', function()
        require('telescope.builtin').resume()
      end)
      vim.keymap.set('n', '<leader>uy', function()
        require('telescope').extensions.yank_history.yank_history({})
      end)
    end

    if is_available('neo-tree.nvim') then
      vim.keymap.set('n', '<Leader>fe', ':Neotree toggle reveal<CR>', { silent = true })
    end

    if is_available('trouble.nvim') then
      vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { silent = true })
    end
  end,
})
