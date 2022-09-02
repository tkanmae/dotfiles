local PACKER_PATH = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- Automatically install packer
if vim.fn.empty(vim.fn.glob(PACKER_PATH)) > 0 then
  PACKER_BOOTSTRAPPED = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    PACKER_PATH,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim when you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use('nvim-lua/plenary.nvim')
  use('nvim-lua/popup.nvim')

  -- Colorscheme
  use({ 'ellisonleao/gruvbox.nvim' })

  -- Completion
  use({
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = [[require("user.plugin_config.cmp")]],
  })
  use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lsp' })

  -- LSP
  use({
    'neovim/nvim-lspconfig',
    config = [[require("user.plugin_config.lspconfig")]],
  })
  use('williamboman/mason.nvim')
  use({
    'williamboman/mason-lspconfig.nvim',
    after = { 'mason.nvim', 'nvim-lspconfig' },
    config = [[require("user.plugin_config.mason")]],
  })
  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = [[require("user.plugin_config.null-ls")]],
  })
  use({ 'folke/lsp-colors.nvim', after = 'nvim-lspconfig' })
  use({
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require("user.plugin_config.trouble")]],
  })

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    after = { 'yanky.nvim' },
    config = [[require("user.plugin_config.telescope")]],
  })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead', 'BufNewFile' },
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = [[require("user.plugin_config.treesitter")]],
  })
  use({
    'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'nvim-treesitter',
  })
  use({
    'lewis6991/spellsitter.nvim',
    after = 'nvim-treesitter',
    config = function()
      require('spellsitter').setup()
    end,
  })

  -- Git
  use({
    'lewis6991/gitsigns.nvim',
    config = [[require("user.plugin_config.gitsigns")]],
  })

  -- Editing
  use({
    'kylechui/nvim-surround',
    config = [[require("user.plugin_config.surround")]],
  })
  use({
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = [[require("user.plugin_config.autopairs")]],
  })
  use({
    'gbprod/yanky.nvim',
    config = [[require("user.plugin_config.yanky")]],
  })
  use({
    'numToStr/Comment.nvim',
    keys = { 'gc', 'gb', 'g<', 'g>' },
    config = [[require("user.plugin_config.comment")]],
  })

  -- Goodies
  use({
    'kyazdani42/nvim-web-devicons',
    event = 'VimEnter',
    config = [[require("user.plugin_config.web-devicons")]],
  })
  use({
    'alexghergh/nvim-tmux-navigation',
    config = [[require("user.plugin_config.tmux-navigation")]],
  })

  -- Filer
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = [[require("user.plugin_config.neo-tree")]],
  })

  -- Status bar
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = [[require("user.plugin_config.lualine")]],
  })

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAPPED then
    require('packer').sync()
  end
end)
