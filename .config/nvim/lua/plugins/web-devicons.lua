return {
  'kyazdani42/nvim-web-devicons',
  lazy = true,
  config = function(_, opts)
    local devicons = require('nvim-web-devicons')
    devicons.setup(opts)
    devicons.set_default_icon('', '#6d8086')
  end,
}
