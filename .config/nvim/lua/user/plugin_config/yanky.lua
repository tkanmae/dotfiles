local ok, yanky = pcall(require, 'yanky')
if not ok then
  print('Module not found: yanky')
end

yanky.setup({
  ring = {
    history_length = 100,
    storage = 'shada',
    sync_with_numbered_registers = true,
    cancel_event = 'update',
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  preserve_cursor_position = {
    enabled = true,
  },
})
