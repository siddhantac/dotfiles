return {
    { 'nvim-tree/nvim-web-devicons' },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                stages = "static",
            })
        end,
    },

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
            local lualine = require('lualine')
            lualine.setup {
                options = { theme = 'catppuccin' },
            }
        end
    } }
