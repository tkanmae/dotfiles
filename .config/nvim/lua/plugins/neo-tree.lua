return {
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
}
