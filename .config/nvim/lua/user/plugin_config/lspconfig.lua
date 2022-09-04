local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  print('Module not found: lspconfig')
  return
end

local cmp_lsp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_lsp_ok then
  print('Module not found: cmp_nvim_lsp')
  return
end

local default_config = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><x-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Automatically show diagnostics on hover
    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end,
}

lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, default_config)

lspconfig.pyright.setup({})

lspconfig.tsserver.setup({
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  on_attach = function(client, bufnr)
    default_config.on_attach(client, bufnr)
    -- Disable typescript-language-server's formatting capabilities so that
    -- Prettier provided via null-ls becomes the only formatter.
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
})

lspconfig.sumneko_lua.setup({
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
  on_attach = function(client, bufnr)
    default_config.on_attach(client, bufnr)
    -- Disable smuneko_lsp's formatting capabilities so that StyLua provided
    -- via null-ls becomes the only formatter.
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
})
