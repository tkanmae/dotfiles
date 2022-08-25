local ok, devicon = pcall(require, 'nvim-web-devicon')
if not ok then
  print('Module not found: nvim-web-devicon')
  return
end

devicon.setup()
