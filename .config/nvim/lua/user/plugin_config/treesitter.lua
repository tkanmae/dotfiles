local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  print('Module not found: nvim-treesitter')
  return
end

treesitter.setup({
  ensure_installed = 'all',
  sync_install = false,
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
  context_commmentstring = {
    enable = true,
    enable_autocmd = true,
  },
  indent = { enable = true, disable = { 'python', 'yaml' } },
})
