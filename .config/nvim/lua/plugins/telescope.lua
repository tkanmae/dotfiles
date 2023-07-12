return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1 },
    'gbprod/yanky.nvim',
  },
  keys = {
    {
      '<leader>sf',
      function()
        require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })
      end,
      desc = 'Search files',
    },
    {
      '<leader>sr',
      function()
        require('telescope.builtin').oldfiles()
      end,
      desc = 'Search recently opened files',
    },
    {
      '<leader>sg',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Search by Grep',
    },
    {
      '<leader>sb',
      function()
        require('telescope.builtin').buffers()
      end,
      desc = 'Search buffers',
    },
    {
      '<leader>sh',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = 'Search help pages',
    },
    {
      '<leader>sk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = 'Search key maps',
    },
    {
      '<leader>ss',
      function()
        require('telescope.builtin').lsp_document_symbols()
      end,
      desc = 'Search document symbols',
    },
    {
      '<leader>sy',
      function()
        require('telescope').extensions.yank_history.yank_history({})
      end,
      desc = 'Search yanked items',
    },
    {
      '<leader>sR',
      function()
        require('telescope.builtin').resume()
      end,
      desc = 'Resume',
    },
  },
  opts = {
    defaults = {
      prompt_prefix = ' ',
      selection_caret = ' ',
      file_ignore_patterns = { 'node_modules' },
      mappings = {
        n = {
          ['q'] = function(...)
            require('telescope.actions').close(...)
          end,
        },
      },
      multi_icon = ' ',
    },
    pickers = {
      buffers = {
        mappings = {
          n = {
            ['d'] = function(...)
              require('telescope.actions').delete_buffer(...)
            end,
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('yank_history')
  end,
}
