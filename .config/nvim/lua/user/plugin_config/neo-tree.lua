local ok, tree = pcall(require, 'neo-tree')
if not ok then
  print('Module not found: neo-tree')
  return
end

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

tree.setup({
  default_component_configs = {
    icon = {
      default = '',
    },
  },
  filesystem = {
    filtered_item = {
      never_show = {
        '.DS_Store',
        'thumbs.db',
      },
    },
    use_libuv_file_watcher = true,
  },
})

vim.keymap.set('n', '<Leader>fe', ':Neotree toggle reveal<CR>', { silent = true })
