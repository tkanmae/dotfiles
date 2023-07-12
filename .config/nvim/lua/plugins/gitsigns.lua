return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
      end

      map({ 'n', 'v' }, '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage Hunk')
      map({ 'n', 'v' }, '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', 'Reset Hunk')
      map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
      map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
      map('n', '<leader>hv', gs.preview_hunk, 'Preview Hunk')
      map('n', '<leader>hb', function()
        gs.blame_line({ full = true })
      end, 'Blame This')
      map('n', '<leader>hd', gs.diffthis, 'Blame This')
      map('n', ']h', gs.next_hunk, 'Next Hunk')
      map('n', '[h', gs.prev_hunk, 'Prev Hunk')
    end,
  },
}
