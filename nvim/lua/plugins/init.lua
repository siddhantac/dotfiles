local core_mappings = require("core.mappings")

require("lazy").setup({
    require("plugins.git"),
    require("plugins.code_review"),
    require("plugins.coding"),
    require("plugins.treesitter"),
    require("plugins.treesitter_textobjects"),
    require("plugins.pkm"),
    require("plugins.codeium"),
    require("plugins.telescope"),

    require("plugins.lsp"),

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
                stages = "fade",
                top_down = true,
                background_colour = "#000000",
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

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        name = "harpoon",
        event = { "BufRead" },
        keys = core_mappings.harpoon,
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup()

            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end

            vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end,
                { desc = "Menu (telescope)" })
        end,
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

    -- UI
    {
        'aliqyan-21/darkvoid.nvim',
        name = "darkvoid",
        priority = 1000,
        config = function()
            require("darkvoid").setup({
                glow = true,
                show_end_of_buffer = true,
            })
        end
    },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("plugins.catppuccin").setup()
    --     end,
    -- },
    {
        'yorickpeterse/nvim-grey',
    },
    { "fcancelinha/nordern.nvim",      branch = "master", priority = 1000 },
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
        'folke/twilight.nvim',
    },
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        opts = require("plugins.toggleterm").opts,
        keys = core_mappings.terminal_mappings,
    },


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
        'kevinhwang91/nvim-bqf',
        event = 'BufReadPre',
    },
    {
        'stevearc/overseer.nvim',
        opts = {
            templates = { "builtin", "user.pull_request" },
        },
        keys = core_mappings.overseer_mappings,
    },
})
