return {
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
}
