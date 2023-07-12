return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    ts_config = { lua = { 'string' }, javascript = { 'string', 'template_string' } },
    disable_filetype = { 'TelescopePrompt', 'vim' },
    map_c_h = true,
  },
}
