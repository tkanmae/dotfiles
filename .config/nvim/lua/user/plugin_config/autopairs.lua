local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
  print('Module not found: nvim-autopairs')
  return
end

autopairs.setup({
  check_ts = true,
  ts_config = { lua = { 'string' }, javascript = { 'string', 'template_string' } },
  disable_filetype = { 'TelescopePrompt', 'vim' },
})
