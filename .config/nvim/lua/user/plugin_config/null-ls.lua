local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  print('Module not found: null-ls')
  return
end

local augroup = vim.api.nvim_create_augroup('lsp_formatting', { clear = true })

null_ls.setup({
  diagnostics_format = '[#{c}] #{m}',
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(_client)
              return _client.name == 'null-ls'
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.formatting.prettier,
    -- Python
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    -- Lua
    null_ls.builtins.formatting.stylua,
    -- Text
    null_ls.builtins.diagnostics.textlint.with({
      filetypes = { 'markdown', 'asciidoc' },
      condition = function(utils)
        return vim.fn.executable('textlint') > 0 and utils.root_has_file({ '.textlintrc' })
      end,
    }),
  },
})
