local spec = {
    "folke/which-key.nvim",
    name = "which-key.nvim",
}

local notify = require("core.quick-notify")
local get_icon = require("utils").get_icon

function spec:config()
    local whichkey = require('which-key')

    whichkey.register(
        {
            e = { ":e <C-R>=expand('%:p:h') . '/' <CR>", "Edit file in same dir" },
            v = { ":vsplit <C-R>=expand('%:p:h') . '/' <CR>", "Vsplit file in same dir" }
        },
        { prefix = "," }
    )

    local nvterm = require("nvterm.terminal")
    whichkey.register(
        {
            r = {
                name = "Terminal",
                f = { function() nvterm.toggle("float") end, "float" },
                h = { function() nvterm.toggle("horizontal") end, "horizontal" },
                v = { function() nvterm.toggle("vertical") end, "vertical" },
            },
            f = {
                desc = get_icon("Search") .. "Find",
                -- desc = require("icons.nerd_font").Search .. " Find",
                name = "Files",
                f = { "<cmd>Telescope find_files<cr>", "Find files" },
                F = { "<cmd>Telescope find_files layout_strategy=vertical<cr>", "Find files (vert)" },
                d = { "<cmd>Telescope find_files search_dirs=%:p:h<CR>", "Find Files in same dir", noremap = false },
                g = { "<cmd>Telescope git_branches<cr>", "Git branches" },
                t = { "<cmd>Telescope treesitter<cr>", "treesitter" },
            },

            b = {
                name = "Buffers",
                b = { "<cmd>b#<CR>", "Swap" },
                f = { "<cmd>Telescope buffers<CR>", "Find" },
                c = { "<cmd>close<CR>", "Close" },
                d = { "<cmd>bd<CR>", "Delete" },
                D = { "<cmd>bufdo bd<CR>", "Delete all" },
                m = { "<cmd>MaximizerToggle<CR>", "Maximize (toggle)" },
            },

            c = {
                name = "Config",
                r = { "<cmd>source ~/.config/nvim/init.lua<CR>", "Reload config" },
            },

            g = {
                name = "Git",
                g = { "<cmd>Git<CR>", "vim-fugitive" },
                c = { "<cmd>Git commit<CR>", "commit" },
                a = { "<cmd>Git add -A|Git commit<CR>", "add + commit" },

                l = { function() notify("pulling...", "Git pull") end, "pull" },
                y = { "<cmd>!git pull --all -p<CR>", "sync" },

                p = { function() notify("pushing...", "Git push") end, "push" },
                n = { "<cmd>Dispatch git push --no-verify<CR>", "push --no-verify" },
                m = { "<cmd>Git push --no-verify<CR>", "push --no-verify (2)" },

                s = { "<cmd>!git status --short<CR>", "status" },
                o = { "<cmd>GBrowse<CR>", "open github (browser)" }, -- uses tpope/vim-rhubarb

                x = { "<cmd>Git add -A|Git commit|Git push<CR>", "add + commit + push" },
            },

            d = {
                name = "Diagnostics",
                f = { "<cmd>Telescope diagnostics<CR>", "Open in Telescope" },
                L = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Open in location list" },

                n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next" },
                p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev" },
                d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostic" },
                D = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostic" },
            },

            t = {
                name = "Test",
                n = { "<cmd>TestNearest<cr>", "run test nearest to cursor" },
                f = { "<cmd>TestFile<cr>", "run test file" },
                s = { "<cmd>TestSuite<cr>", "run entire test suite" },
                t = { "<cmd>TestLast<cr>", "run the last test" },
                e = { "<cmd>Other<cr>", "open test file" },
                v = { "<cmd>OtherVSplit<cr>", "open test file in vert split" },
            },

            e = { "<cmd>NvimTreeFindFileToggle<CR>", "File Explorer" },
            w = { "<cmd>w<CR>", "Save" },
            s = { "<cmd>Telescope live_grep<CR>", "Search (live_grep)" },
            n = {
                name = "Sessions",
                l = { "<cmd>lua MiniSessions.select()<CR>", "Load session" },
                w = { "<cmd>lua MiniSessions.write('nil')<CR>", "Write session" },
                d = { "<cmd>lua MiniSessions.select('delete')<CR>", "Delete session" },
            },
        },
        { prefix = "<leader>" }
    )

    whichkey.setup({
        icons = {
            group = vim.g.icons_enabled and "" or "+",
            separator = "",
        },
        disable = { filetypes = { "TelescopePrompt" } },
    })
end

return spec
