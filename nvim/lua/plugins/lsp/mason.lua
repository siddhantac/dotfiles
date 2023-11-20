local M = {}
M.setup = function()
    local mason = require("mason")
    mason.setup() -- enable mason

    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })

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
            "jsonls",
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
    })
end
return M
