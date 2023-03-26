local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

require('lazy').setup({
  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      { 'williamboman/mason-lspconfig.nvim', opts = { ensure_installed = { 'lua_ls', 'pyright' } } },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('user.plugin_config.lspconfig')
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_uninstalled = '✗',
          package_pending = '⟳',
        },
      },
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('user.plugin_config.null-ls')
    end,
  },
  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'lukas-reineke/cmp-under-comparator',
    },
    config = function()
      require('user.plugin_config.cmp')
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    keys = {
      {
        '<tab>',
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
        end,
        expr = true,
        silent = true,
        mode = 'i',
      },
      {
        '<tab>',
        function()
          require('luasnip').jump(1)
        end,
        mode = 's',
      },
      {
        '<s-tab>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = { 'i', 's' },
      },
    },
  },
  -- Editing
  {
    'kylechui/nvim-surround',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      ts_config = { lua = { 'string' }, javascript = { 'string', 'template_string' } },
      disable_filetype = { 'TelescopePrompt', 'vim' },
      map_c_h = true,
    },
  },
  {
    'gbprod/yanky.nvim',
    keys = {
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' } },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' } },
      { '<c-n>', '<Plug>(YankyCycleForward)' },
      { '<c-p>', '<Plug>(YankyCycleBackward)' },
    },
    opt = {
      ring = {
        history_length = 100,
        storage = 'shada',
        sync_with_numbered_registers = true,
        cancel_event = 'update',
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    },
  },
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    opts = {
      hooks = {
        pre = function()
          require('ts_context_commentstring.internal').update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require('mini.comment').setup(opts)
    end,
  },
  {
    'RRethy/vim-illuminate',
    event = { 'CursorHold', 'CursorHoldI' },
    opts = {
      delay = 100,
      filetypes_denylist = {
        'DressingSelect',
        'TelescopePrompt',
        'Trouble',
        'help',
        'neo-tree',
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end

        map({ 'n', 'v' }, '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', 'Reset Hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>hv', gs.preview_hunk, 'Preview Hunk')
        map('n', '<leader>hb', function()
          gs.blame_line({ full = true })
        end, 'Blame This')
        map('n', '<leader>hd', gs.diffthis, 'Blame This')
        map('n', ']h', gs.next_hunk, 'Next Hunk')
        map('n', '[h', gs.prev_hunk, 'Prev Hunk')
      end,
    },
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bd',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>bD',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Delete Buffer (Force)',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'andymass/vim-matchup',
    },
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('user.plugin_config.treesitter')
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      {
        '<leader>fe',
        '<cmd>Neotree toggle reveal<cr>',
        desc = 'Explore the current directory',
      },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    opts = {
      default_component_configs = {
        icon = {
          default = '',
        },
      },
      filesystem = {
        filtered_item = {
          never_show = {
            '.DS_Store',
            'thumbs.db',
          },
        },
        use_libuv_file_watcher = true,
      },
    },
  },
  {
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
    config = function()
      require('user.plugin_config.telescope')
    end,
  },
  {
    'alexghergh/nvim-tmux-navigation',
    opts = {
      disable_when_zoomed = true,
    },
    keys = {
      {
        '<C-t>h',
        function()
          require('nvim-tmux-navigation').NvimTmuxNavigateLeft()
        end,
      },
      {
        '<C-t>j',
        function()
          require('nvim-tmux-navigation').NvimTmuxNavigateDown()
        end,
      },
      {
        '<C-t>k',
        function()
          require('nvim-tmux-navigation').NvimTmuxNavigateUp()
        end,
      },
      {
        '<C-t>l',
        function()
          require('nvim-tmux-navigation').NvimTmuxNavigateRight()
        end,
      },
      {
        '<C-t>\\',
        function()
          require('nvim-tmux-navigation').NvimTmuxNavigateLastActive()
        end,
      },
      {
        '<C-t><Space>',
        function()
          require('nvim-tmux-navigation').NvimTmuxNavigateNext()
        end,
      },
    },
  },
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = 'Delete all Notifications',
      },
    },
    opts = {
      timeout = 2000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
    opt = {
      input = {
        default_prompt = ' ',
        win_options = {
          winhighlight = 'Normal:Normal,NormalNC:Normal',
        },
      },
      select = {
        backend = { 'telescope', 'builtin' },
        builtin = {
          win_options = {
            winhighlight = 'Normal:Normal,NormalNC:Normal',
          },
        },
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-web-devicons' },
    opts = function()
      local icons = require('user.icons')
      return {
        options = {
          theme = 'auto',
          section_separators = { '', '' },
          component_separators = { '|', '|' },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 0,
            },
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = {
                error = icons.diagnostics.error,
                warn = icons.diagnostics.warn,
                info = icons.diagnostics.info,
                hint = icons.diagnostics.hint,
              },
            },
          },
          lualine_y = {
            {
              'diff',
              symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
            },
          },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename ' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'neo-tree' },
      }
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '│',
      filetype_exclude = { 'help', 'neo-tree', 'Trouble' },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'neo-tree', 'Trouble', 'lazy', 'mason' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require('mini.indentscope').setup(opts)
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = function()
      local icons = require('user.icons')
      return {
        signs = {
          error = icons.diagnostics.error,
          warning = icons.diagnostics.warn,
          hint = icons.diagnostics.hint,
          information = icons.diagnostics.info,
        },
      }
    end,
    keys = {
      {
        '<leader>xx',
        '<cmd>TroubleToggle document_diagnostics<cr>',
        desc = 'Document diagnostics',
      },
      {
        '<leader>xX',
        '<cmd>TroubleToggle workspace_diagnostics<cr>',
        desc = 'Workspace diagnostics',
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    config = true,
    keys = {
      { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Search Todos' },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local whichkey = require('which-key')
      whichkey.setup(opts)
      whichkey.register({
        mode = { 'n', 'v' },
        ['g'] = { name = '+goto' },
        ['gz'] = { name = '+surround' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>b'] = { name = '+buffer' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>f'] = { name = '+file/find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunks' },
        ['<leader>q'] = { name = '+quit/session' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>u'] = { name = '+ui' },
        ['<leader>w'] = { name = '+windows' },
        ['<leader>x'] = { name = '+diagnostics/quickfix' },
      })
    end,
  },
  {
    'kyazdani42/nvim-web-devicons',
    lazy = true,
    config = function(_, opts)
      local devicons = require('nvim-web-devicons')
      devicons.setup(opts)
      devicons.set_default_icon('', '#6d8086')
    end,
  },
  -- Colorscheme
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
  },
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    opts = {
      integrations = {
        illuminate = true,
        neotree = true,
        noice = true,
        which_key = true,
      },
    },
  },
})
