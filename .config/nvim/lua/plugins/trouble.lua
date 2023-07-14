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
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Previous trouble/quickfix item',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Next trouble/quickfix item',
    },
  },
}
