require("lazy").setup({
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

    {
        "ThePrimeagen/harpoon",
        name = "harpoon.nvim",
        event = { "BufRead" },
    },

    -- Golang plugins
    {
        'rgroli/other.nvim',
        lazy = true,
        cmd = { "Other", "OtherSplit", "OtherVSplit", "OtherClear" },
        config = function()
            require("other-nvim").setup({
                mappings = {
                    "golang",
                }
            })
        end,
    },
    {
        "nvim-neotest/neotest-go",
        ft = "*_test.go",
        config = function()
            require("plugins.neotest_go").setup()
        end
    },
    {
        "nvim-neotest/neotest",
        name = "neotest",
        event = "BufEnter *_test.go",
        dependencies = {
            "nvim-neotest/neotest-go",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        },
        config = function()
            require("plugins.neotest").setup()
        end,
    },


    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
        },
        config = function()
            require("plugins.nvim_cmp").setup()
        end,
    },

    {
        'nvim-tree/nvim-tree.lua',
        name = 'nvim-tree',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- file icon
        },
        cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFindFileToggle" },
        config = function()
            require("plugins.nvim_tree").setup()
        end,
    },

    -- Telescope
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        name = "telescope.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require("plugins.telescope").setup()
        end,
    },

    -- UI
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("plugins.catppuccin").setup()
        end,
    },
    { 'nvim-tree/nvim-web-devicons' },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        'szw/vim-maximizer',
        cmd = { "MaximizerToggle" },
    },
    {
        'nvim-lualine/lualine.nvim',
        name = "lualine.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require("plugins.lualine").setup()
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            require("plugins.mini_indentscope").init()
        end,
        opts = require("plugins.mini_indentscope").opts,
    },

    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        opts = require("plugins.toggleterm").opts,
    },

    -- LSP
    require("plugins.lsp"),


    {
        "folke/which-key.nvim",
        name = "which-key.nvim",
        config = function()
            require("plugins.which-key").setup()
        end,
    },

    {
        "echasnovski/mini.nvim",
        event = "VimEnter",
        opts = function()
            require("plugins.mini").opts()
        end,
        config = function()
            require("plugins.mini").config()
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        name = 'treesitter',
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.treesitter").config()
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        name = 'treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.treesitter_textobjects").config()
        end,
    },
})
