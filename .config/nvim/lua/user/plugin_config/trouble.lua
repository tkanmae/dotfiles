local ok, trouble = pcall(require, 'trouble')
if not ok then
  print('Module not found: trouble')
  return
end

trouble.setup({
  signs = {
    error = 'E',
    warning = 'W',
    hint = 'H',
    information = 'I',
    other = 'O',
  },
})
