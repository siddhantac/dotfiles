return {
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
        event = "LspAttach",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = require("plugins.lsp.lspsaga").opts,
    },
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    },                          -- vs-code like icons for autocompletion
    {
        'stevearc/aerial.nvim', -- code outline
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
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
}
