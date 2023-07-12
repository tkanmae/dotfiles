return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  config = true,
  keys = {
    { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
    { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Search Todos' },
  },
}
