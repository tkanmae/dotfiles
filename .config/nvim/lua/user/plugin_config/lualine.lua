local ok, lualine = pcall(require, 'lualine')
if not ok then
  print('Module not found: lualine')
  return
end

local icons = require('user.icons')

lualine.setup({
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
})
