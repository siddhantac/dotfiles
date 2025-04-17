return {
    {
        'mfussenegger/nvim-dap',
        keys = require("core.mappings").dap(),
    },
    {
        'leoluz/nvim-dap-go',
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            require("dap-go").setup()
        end,
        ft = "go",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "folke/lazydev.nvim",
        },
        keys = require("core.mappings").dapui(),
        config = function()
            require("dapui").setup()
            require("lazydev").setup({
                library = { "nvim-dap-ui" }
            })

            -- automatic opening and closing of UI
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    {
        "quolpr/quicktest.nvim",
        config = function()
            local qt = require("quicktest")

            qt.setup({
                -- Choose your adapter, here all supported adapters are listed
                adapters = {
                    require("quicktest.adapters.golang")({}),
                    require("quicktest.adapters.vitest")({}),
                },
                -- split or popup mode, when argument not specified
                default_win_mode = "split",
                use_experimental_colorizer = true
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        keys = require("core.mappings").quicktest_mappings,
    },

    -- auto completion
    {
        "L3MON4D3/LuaSnip",
        event = { "InsertEnter" },
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ include = "go" })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "L3MON4D3/LuaSnip",         -- snippet engine
            "saadparwaiz1/cmp_luasnip", -- for autocompletion
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind.nvim", -- optional dependency
        },
        config = function()
            require("plugins.nvim_cmp").setup()
        end,
    },
}
