local function is_installable_with_mason(server_name)
  local installable_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
  return vim.tbl_contains(installable_servers, server_name)
end

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  opts = {
    servers = {
      ['cssls'] = {},
      ['lua_ls'] = {
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
      },
      ['pyright'] = {},
      ['tailwindcss'] = {},
      ['tsserver'] = {},
    },
    setup = {},
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')

    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities()
    )

    local function setup_server(server_name)
      local server_opts = vim.tbl_deep_extend('force', {
        capabilities = vim.deepcopy(capabilities),
      }, opts.servers[server_name] or {})

      if opts.setup[server_name] then
        if opts.setup[server_name](server_name, server_opts) then
          return
        end
      end
      lspconfig[server_name].setup(server_opts)
    end

    local servers_to_install = {}
    for server_name, _ in pairs(opts.servers) do
      if is_installable_with_mason(server_name) then
        servers_to_install[#servers_to_install + 1] = server_name
      else
        setup_server(server_name)
      end
    end
    mason_lspconfig.setup({ ensure_installed = servers_to_install, handlers = { setup_server } })

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
