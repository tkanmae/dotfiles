return {
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
}
