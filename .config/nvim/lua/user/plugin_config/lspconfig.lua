local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  print('Module not found: lspconfig')
  return
end

-- The following is equivalent to calling require('cmp-nvim-lsp').update_capabilities().
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

local default_config = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, default_config)

lspconfig.pyright.setup({})

lspconfig.tsserver.setup({
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
})

lspconfig.cssls.setup({})
lspconfig.tailwindcss.setup({
  root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      format = {
        -- Use StyLua via null-ls instead
        enable = false,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
})
