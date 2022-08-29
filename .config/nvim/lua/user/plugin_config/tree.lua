local ok, tree = pcall(require, 'nvim-tree')
if not ok then
  print('Module not found: nvim-tree')
  return
end

tree.setup({
  sort_by = 'case_sensitive',
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = 'u', action = 'dir_up' },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set('n', '<Leader>fe', ':NvimTreeToggle<CR>', { silent = true })
