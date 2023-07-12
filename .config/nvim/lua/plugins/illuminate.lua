return {
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
}
