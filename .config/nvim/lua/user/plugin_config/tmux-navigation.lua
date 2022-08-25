local ok, tmux_nav = pcall(require, 'nvim-tmux-navigation')
if not ok then
  print('Module not found: nvim-tmux-navigation')
  return
end

tmux_nav.setup({
  disable_when_zoomed = true,
  keybindings = {
    left = '<C-t>h',
    down = '<C-t>j',
    up = '<C-t>k',
    right = '<C-t>l',
    last_active = '<C-t>\\',
    next = '<C-t>Space',
  },
})
