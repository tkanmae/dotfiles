local ok, telescope = pcall(require, 'telescope')
if not ok then
  print('Module not found: telescope')
  return
end

local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ['q'] = actions.close,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['d'] = actions.delete_buffer,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('yank_history')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>uf', function()
  builtin.find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })
end)
vim.keymap.set('n', '<leader>um', function()
  builtin.oldfiles()
end)
vim.keymap.set('n', '<leader>ug', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '<leader>ub', function()
  builtin.buffers()
end)
vim.keymap.set('n', '<leader>ur', function()
  builtin.resume()
end)
vim.keymap.set('n', '<leader>uy', function()
  telescope.extensions.yank_history.yank_history({})
end)
