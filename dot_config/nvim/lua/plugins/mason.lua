local spec = {
    'williamboman/mason.nvim',
    name = 'mason.nvim',
    build = ":MasonUpdate",
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
    },
    cmd = {
        "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog"
    },
    event = { "VeryLazy" },
}

function spec:config()
    local mason = require("mason")
    mason.setup() -- enable mason

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        "lua_ls",
        "gopls",
        "vimls",
        "terraformls",
        "pyright",
        "dockerls",
        "clangd",
        "jsonls",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
end

return spec
