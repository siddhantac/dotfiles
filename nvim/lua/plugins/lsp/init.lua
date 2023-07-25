return {
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    }, -- vs-code like icons for autocompletion
    {
        'numToStr/Comment.nvim',
        event = { "BufRead" },
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({
                backends = { "treesitter", "lsp", "markdown", "man" },
            })
        end
    },

    {
        'williamboman/mason.nvim',
        name = 'mason.nvim',
        build = ":MasonUpdate",
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        cmd = {
            "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog"
        },
        config = function()
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
                    "jsonls",
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })
        end
    },
}
