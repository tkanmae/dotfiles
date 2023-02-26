local ok, lualine = pcall(require, 'lualine')
if not ok then
  print('Module not found: lualine')
  return
end

lualine.setup({
  options = {
    theme = 'catppuccin',
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
        symbols = { error = ' ', warn = ' ', info = ' ', hint = '' },
      },
    },
    lualine_y = { 'diff' },
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
  extensions = { 'fugitive' },
})
