return {
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    }, -- vs-code like icons for autocompletion
    {
        'stevearc/aerial.nvim',
        opts = {
            attach_mode = "global",
            backends = { "lsp", "treesitter", "markdown", "man" },
            -- disable_max_lines = vim.g.max_file.lines,
            -- disable_max_size = vim.g.max_file.size,
            layout = { min_width = 28 },
            show_guides = true,
            filter_kind = false,
            guides = {
                mid_item = "├ ",
                last_item = "└ ",
                nested_top = "│ ",
                whitespace = "  ",
            },
            keymaps = {
                ["[y"] = "actions.prev",
                ["]y"] = "actions.next",
                ["[Y"] = "actions.prev_up",
                ["]Y"] = "actions.next_up",
                ["{"] = false,
                ["}"] = false,
                ["[["] = false,
                ["]]"] = false,
            },
        },

        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
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
