local core_mappings = require("core.mappings")

-- vim.lsp.config.gopls = {
--     cmd = { 'gopls' },
--     root_markers = { 'go.mod', 'go.sum' },
--     filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
-- }

-- vim.lsp.enable({
--     "gopls",
--     "pyright",
-- })

vim.diagnostic.config({
    severity_sort = true,
    virtual_lines = {
        current_line = true,
        severity = { min = vim.diagnostic.severity.ERROR }
    },
    virtual_text = true
})

return {
    {
        "maxandron/goplements.nvim",
        ft = "go",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            display_package = true,
        },
        keys = {
            { "<leader>li", "<cmd>GoplementsToggle<cr>", desc = "Go impl hint toggle" },
        },
    },
    {
        'neovim/nvim-lspconfig', -- Configurations for Nvim LSP
        name = "lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        },
        config = function()
            require("plugins.lsp.lspconfig").setup()
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        name = 'lspsaga.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = require("plugins.lsp.lspsaga").opts,
        keys = core_mappings.lspsaga_mappings,
    },
    {
        "onsails/lspkind.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },                          -- vs-code like icons for autocompletion
    {
        'stevearc/aerial.nvim', -- code outline
        event = { "BufReadPre", "BufNewFile" },
        -- Optional dependencies
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        opts = require("plugins.lsp.aerial").opts,
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
            require("plugins.lsp.mason").setup()
        end
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = core_mappings.trouble_mappings,
    }
}
