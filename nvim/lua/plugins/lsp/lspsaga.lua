local M = {}
M.opts = {
    lightbulb = {
        sign = false,
    },
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
        keys = {
            edit = "<CR>",
            vsplit = '<C-v>',
            split = '<C-h>',
            tabe = '<C-t>',
            quit = 'q',
            close = "<Esc>",
        },
    },

    rename = {
        in_select = false,
        auto_save = true,
    },
}

return M
