return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'ibl',
  opts = {
    indent = {
      char = '│',
    },
    scope = { enabled = false },
    exclude = { filetypes = { 'help', 'neo-tree', 'Trouble', 'lazy', 'mason', 'notify' } },
  },
}
