local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
end

require('user.options')
require('user.keymaps')
require('user.plugins')
require('user.colorscheme')
require('user.autocmds')
