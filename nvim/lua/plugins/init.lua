require("lazy").setup({
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("plugins.catppuccin").setup()
        end,
    },

    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                stages = "static",
            })

            vim.notify = require("notify")
            -- TODO:: call mappings from here
            -- https://github.com/dkarter/dotfiles/blob/57c6a4c2e98c0cd6ed851aa5791351591eb34df5/config/nvim/lua/plugins/init.lua#L799
        end,
    },

    { 'christoomey/vim-tmux-navigator' },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    -- Git plugins
    {
        'ldelossa/gh.nvim',
        dependencies = { 'ldelossa/litee.nvim' },
        config = function()
            require('litee.lib').setup()
            require('litee.gh').setup()
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },
    {
        -- works better than tpope/vim-rhubarb
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {},
    },
    { 'tpope/vim-fugitive' },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        cmd = { "Octo" },
        config = function()
            require "plugins.octo".setup()
        end,
    },
})
