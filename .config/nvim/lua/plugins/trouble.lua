return {
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
}
