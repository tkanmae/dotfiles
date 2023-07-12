return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  opts = {
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
    ensure_installed = {
      'black',
      'isort',
      'lua-language-server',
      'shfmt',
      'stylua',
      'typescript-language-server',
    },
  },
  config = function(_, opts)
    require('mason').setup(opts)

    local registry = require('mason-registry')
    local function install()
      for _, name in ipairs(opts.ensure_installed) do
        local pkg = registry.get_package(name)
        if not pkg.is_installed(pkg) then
          pkg:install()
        end
      end
    end

    if registry.refresh then
      registry.refresh(install)
    else
      install()
    end
  end,
}
