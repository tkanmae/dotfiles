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

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })

-- Move selected lines up and down
vim.keymap.set('v', 'K', ":move '<-2<CR>gv-gv", { silent = true })
vim.keymap.set('v', 'J', ":move '>+1<CR>gv-gv", { silent = true })

-- Clear highlight
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { remap = true, silent = true })

-- Filetype specific key mapping
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

    if is_available('yanky.nvim') then
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
      -- Yank-ring
      vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleForward)')
      vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleBackward)')
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

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buffer
    local client = vim.lsp.get_client_by_id(args.data.clien_id)

    local opts = { silent = true, buffer = bufnr }

    vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Automatically show diagnostics on hover
    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end,
})
