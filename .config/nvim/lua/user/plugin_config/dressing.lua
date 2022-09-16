local ok, dressing = pcall(require, 'dressing')
if not ok then
  print('Module not found: dressing')
end

dressing.setup({
  input = {
    default_prompt = '> ',
    winhighlight = 'Normal:Normal,NormalNC:Normal',
  },
  select = {
    backend = { 'telescope', 'builtin' },
    builtin = { winhighlight = 'Normal:Normal,NormalNC:Normal' },
  },
})
