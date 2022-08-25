local ok, icons = pcall(require, 'nvim-web-devicons')
if not ok then
  print('Module not found: nvim-web-devicons')
  return
end

icons.setup()
icons.set_default_icon('', '#6d8086')
