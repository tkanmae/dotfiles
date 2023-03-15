local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  print('Module not found: nvim-treesitter')
  return
end

treesitter.setup({
  ensure_installed = 'all',
  sync_install = false,
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
  context_commmentstring = {
    enable = true,
    enable_autocmd = false,
  },
  indent = { enable = true, disable = { 'python', 'yaml' } },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
  matchup = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<C-space>',
      node_incremental = '<C-space>',
      scope_incremental = '<nop>',
      node_decremental = '<bs>',
    },
  },
})
