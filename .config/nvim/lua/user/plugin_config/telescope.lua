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
    multi_icon = ' ',
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
