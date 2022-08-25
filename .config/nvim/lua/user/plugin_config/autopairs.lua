local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
  print('Module not found: nvim-autopairs')
  return
end

autopairs.setup({
  disable_filetype = { 'TelescopePrompt', 'vim' },
})
