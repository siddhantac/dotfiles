return {
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        cmd = { "Octo" },
        config = function()
            require "octo".setup({
                mappings = {
                    submit_win = {
                        approve_review = { lhs = "<leader>a", desc = "approve review" },
                        comment_review = { lhs = "<leader>m", desc = "comment review" },
                        request_changes = { lhs = "<leader>r", desc = "request changes review" },
                        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
                    },
                }
            })
        end,
    },
    {
        'ldelossa/gh.nvim',
        dependencies = { 'ldelossa/litee.nvim' },
        -- event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('litee.lib').setup()
            require('litee.gh').setup()
        end,
        cmd = { "GHOpenPR", "GHOpenToPR" },
    },
    {
        'daliusd/ghlite.nvim',
        cmd = { "GHLitePRSelect" },
        config = function()
            require('ghlite').setup({
                debug = false,           -- if set to true debugging information is written to ~/.ghlite.log file
                view_split = 'vsplit',   -- set to empty string '' to open in active buffer
                diff_split = 'vsplit',   -- set to empty string '' to open in active buffer
                comment_split = 'split', -- set to empty string '' to open in active buffer
                open_command = 'open',   -- open command to use, e.g. on Linux you might want to use xdg-open
                merge = {
                    approved = '--squash',
                    nonapproved = '--auto --squash',
                },
                keymaps = { -- override default keymaps with the ones you prefer
                    diff = {
                        open_file = 'gf',
                        open_file_tab = 'gt',
                        open_file_split = 'gs',
                        open_file_vsplit = 'gv',
                        approve = '<C-A>',
                    },
                    comment = {
                        send_comment = '<C-CR>'
                    },
                    pr = {
                        approve = '<C-A>',
                        merge = '<C-M>',
                    },
                },
            })
        end,
        -- keys = core_mappings.ghlite_mappings,
    },
}
