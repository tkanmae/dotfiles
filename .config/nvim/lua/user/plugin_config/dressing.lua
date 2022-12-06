local ok, dressing = pcall(require, 'dressing')
if not ok then
  print('Module not found: dressing')
end

dressing.setup({
  input = {
    default_prompt = '> ',
    win_options = {
      winhighlight = 'Normal:Normal,NormalNC:Normal',
    },
  },
  select = {
    backend = { 'telescope', 'builtin' },
    builtin = {
      win_options = {
        winhighlight = 'Normal:Normal,NormalNC:Normal',
      },
    },
  },
})
