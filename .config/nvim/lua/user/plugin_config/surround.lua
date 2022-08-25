local ok, surround = pcall(require, 'nvim-surround')
if not ok then
  print('Module not found: nvim-surround')
  return
end

surround.setup()
