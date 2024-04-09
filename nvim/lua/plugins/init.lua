local core_mappings = require("core.mappings")

require("lazy").setup({
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                stages = "static",
                top_down = false,
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
        event = { "BufReadPre", "BufNewFile" },
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
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('litee.lib').setup()
            require('litee.gh').setup()
        end,
    },
    {
        "NeogitOrg/neogit",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true,
        keys = core_mappings.neogit_mappings,
    },
    {
        -- works better than tpope/vim-rhubarb
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {},
        keys = core_mappings.gitlinker_mappings,
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'tpope/vim-fugitive',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end,
        keys = core_mappings.gitsigns_mappings,
    },
    {
        'pwntester/octo.nvim',
        dependencies = {
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
        keys = core_mappings.harpoon,
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
        keys = core_mappings.other_mappings,
    },
    {
        "nvim-neotest/neotest-go",
        ft = "*_test.go",
        config = function()
            require("plugins.neotest_go").setup()
        end,
        keys = core_mappings.neotest_mappings,
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

    -- {
    --     'nvim-tree/nvim-tree.lua',
    --     name = 'nvim-tree',
    --     dependencies = {
    --         'nvim-tree/nvim-web-devicons', -- file icon
    --     },
    --     cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFindFileToggle" },
    --     config = function()
    --         require("plugins.nvim_tree").setup()
    --     end,
    --     keys = core_mappings.nvimtree_mappings,
    -- },

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
        keys = core_mappings.telescope_mappings,
        event = "VeryLazy",
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
    -- {
    --     "echasnovski/mini.indentscope",
    --     version = false, -- wait till new 0.7.0 release to put it back on semver
    --     event = { "BufReadPre", "BufNewFile" },
    --     init = function()
    --         require("plugins.mini_indentscope").init()
    --     end,
    --     opts = require("plugins.mini_indentscope").opts,
    -- },

    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        opts = require("plugins.toggleterm").opts,
        keys = core_mappings.terminal_mappings,
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
        config = require("plugins.mini").setup,
        dependencies = {
            'mrquantumcodes/configpulse',
        },
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
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'BufReadPre',
        keys = {
            { '[x', function() require('treesitter-context').go_to_context() end },
        },
    },

    {
        'Exafunction/codeium.vim',
        -- event = 'BufReadPre',
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        end
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                -- bottom_search = true,         -- use a classic bottom cmdline for search
                -- command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },

    {
        'kevinhwang91/nvim-bqf',
        event = 'BufReadPre',
    },
})
