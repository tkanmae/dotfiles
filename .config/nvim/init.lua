require('user.options')
require('user.keymaps')
require('user.plugins')
require('user.colorscheme')
require('user.autocmds')

local function first_to_upper(str)
  return (str:gsub('^%l', string.upper))
end

for name, icon in pairs(require('user.icons').diagnostics) do
  name = 'DiagnosticSign' .. first_to_upper(name)
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
end
