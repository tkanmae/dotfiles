vim.opt.clipboard = 'unnamedplus' -- Allow NeoVim to access the system clipboard
vim.opt.cmdheight = 1
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.formatoptions:append({ 'm', 'M' }) -- Enable to format multi-byte strings
vim.opt.fileencoding = 'utf-8'
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.listchars = { trail = '-', tab = '»-', extends = '»', precedes = '«', nbsp = '&', eol = '↲' }
vim.opt.mouse = 'a'
vim.opt.pumheight = 20 -- Set the pop-up menu height
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2 -- Two spaces inserted on each indentation
vim.opt.showbreak = '...' -- String to put at the start of lines that have been wrapped
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.shiftround = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.spelllang = { 'en', 'cjk' } -- Ignore CJK languages in spell checking
vim.opt.swapfile = false
vim.opt.tabstop = 2 -- Two spaces for a tab
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000 -- Time to wait for a key mapping sequence to complete
vim.opt.title = true
vim.opt.updatetime = 100 -- Faster completion (default: 4000)

-- Filetype specific options
vim.api.nvim_create_augroup('filetype_options', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = 'filetype_options',
  pattern = { 'txt', 'markdown', 'asciidoc', 'rest', 'pandoc' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.smartindent = false
    vim.opt_local.wrap = true
  end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = 'filetype_options',
  pattern = { 'gitcommit' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.smartindent = false
    vim.opt_local.textwidth = 72
  end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = 'filetype_options',
  pattern = { 'python' },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = 'filetype_options',
  pattern = { 'Makefile' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = 'filetype_options',
  pattern = { 'help', 'qf', 'lspinfo' },
  callback = function()
    vim.keymap.set('n', 'q', ':close<CR>', { silent = true, buffer = true })
  end,
})
