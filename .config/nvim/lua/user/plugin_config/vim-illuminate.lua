local ok, _ = pcall(require, 'illuminate')
if not ok then
  print('Module not found: vim-illuminate')
  return
end

require('illuminate').configure({
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  delay = 100,
  filetypes_denylist = {
    'DressingSelect',
    'TelescopePrompt',
    'Trouble',
    'help',
    'neo-tree',
  },
})
