local spec = {
    "glepnir/lspsaga.nvim",
    name = 'lspsaga.nvim',
    event = "LspAttach",
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    config = function()
        -- import lspsaga safely
        local saga = require("lspsaga")

        saga.setup({
            -- keybinds for navigation in lspsaga window
            move_in_saga = { prev = "<C-k>", next = "<C-j>" },
            -- use enter to open file with finder
            finder = {
                keys = {
                    open = "<CR>",
                    vsplit = '<C-v>',
                    split = '<C-h>',
                    tabe = '<C-t>',
                    quit = { 'q', '<ESC>' },
                    close_in_preview = "<Esc>",
                }
            },
            -- use enter to open file with definition preview
            definition = {
                edit = "<CR>",
                vsplit = '<C-v>',
                split = '<C-h>',
                tabe = '<C-t>',
                quit = 'q',
                close = "<Esc>",
            },

            rename = {
                in_select = false,
                auto_save = true,
            },
        })
    end
}

return spec
