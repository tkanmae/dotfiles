local ok, mason = pcall(require, 'mason')
if not ok then
  print('Module not found: mason')
  return
end

local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok then
  print('Module not found: mason-lspconfig')
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_uninstalled = '✗',
      package_pending = '⟳',
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'pyright' },
})
