return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        name = "telescope.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local actions  = require "telescope.actions"
            local get_icon = require("utils").get_icon

            require('telescope').setup {
                defaults = {
                    prompt_prefix = get_icon("Search"),
                    selection_caret = get_icon("Selected"),
                    path_display = { "truncate" },
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = { prompt_position = "top", preview_width = 0.55 },
                        vertical = { mirror = false },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    mappings = {
                        i = {
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ['<c-d>'] = require('telescope.actions').delete_buffer,
                            -- ["<esc>"] = require('telescope.actions').close, -- replaced this with 'q' in normal mode
                        },
                        n = { q = actions.close },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    },
                    fzf = {
                        fuzzy = true,           -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('ui-select')
        end

    },
}
