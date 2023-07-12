return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local lspconfig = require('lspconfig')

    -- The following is equivalent to calling require('cmp-nvim-lsp').update_capabilities().
    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities()
    )

    lspconfig.util.default_config = vim.tbl_deep_extend(
      'force',
      lspconfig.util.default_config,
      { flags = { debounce_text_changes = 150 }, capabilities = capabilities }
    )

    require('mason-lspconfig').setup_handlers({
      ['cssls'] = function()
        lspconfig.cssls.setup({})
      end,
      ['lua_ls'] = function()
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
      end,
      ['pyright'] = function()
        lspconfig.pyright.setup({})
      end,
      ['tailwindcss'] = function()
        lspconfig.tailwindcss.setup({
          root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
        })
      end,
      ['tsserver'] = function()
        lspconfig.tsserver.setup({
          filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
        })
      end,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buffer
        local client = vim.lsp.get_client_by_id(args.data.clien_id)

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
        end

        map('n', '<leader>gd', '<cmd>Telescope lsp_definitions<cr>', 'Definition')
        map('n', '<leader>gr', '<cmd>Telescope lsp_references<cr>', 'References')
        map('n', '<leader>gt', '<cmd>Telescope type_definitions<cr>', 'Type definition')
        map('n', '<leader>gi', '<cmd>Telescope lsp_incoming_calls<cr>', 'Incoming calls')
        map('n', '<leader>go', '<cmd>Telescope lsp_outgoing_calls<cr>', 'Outgoing calls')
        map('n', '<leader>gD', vim.lsp.buf.declaration, 'Declaration')
        map('n', '<leader>gI', vim.lsp.buf.implementation, 'Implementation')

        map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')

        map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
        map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

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
    })
  end,
}
