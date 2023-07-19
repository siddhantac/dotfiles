local spec          = {
    "folke/which-key.nvim",
    name = "which-key.nvim",
}

local notify        = require("core.quick-notify")
local get_icon      = require("utils").get_icon
local telescope     = require("telescope")
local tscopebuiltin = require("telescope.builtin")
local Terminal      = require('toggleterm.terminal').Terminal
local lazygit       = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
    lazygit:toggle()
end

function spec:config()
    local whichkey = require('which-key')

    whichkey.register(
        {
            e = { ":e <C-R>=expand('%:p:h') . '/' <CR>", "Edit file in same dir" },
            v = { ":vsplit <C-R>=expand('%:p:h') . '/' <CR>", "Vsplit file in same dir" }
        },
        { prefix = "," }
    )

    -- find with telescope
    whichkey.register({
        ["<leader>f"] = { name = "Find", desc = get_icon("Search") .. "Find" },
        ["<leader>ff"] = { function() tscopebuiltin.find_files() end, "Find files" },
        ["<leader>f<CR>"] = { function() tscopebuiltin.resume() end, "Resume previous search" },
        ["<leader>f'"] = { function() tscopebuiltin.marks() end, "Find marks" },
        ["<leader>f/"] = { function() tscopebuiltin.current_buffer_fuzzy_find()() end, "Find words in current buffer" },
        ["<leader>fb"] = { function() tscopebuiltin.buffers() end, "Find buffers" },
        ["<leader>fc"] = { function() tscopebuiltin.grep_string() end, "Find word under cursor" },
        ["<leader>fC"] = { function() tscopebuiltin.commands() end, "Find commands" },
        ["<leader>fF"] = {
            function() tscopebuiltin.find_files { hidden = true, no_ignore = true } end,
            "Find all files",
        },
        ["<leader>fh"] = { function() tscopebuiltin.help_tags() end, "Find help" },
        ["<leader>fk"] = { function() tscopebuiltin.keymaps() end, "Find keymaps" },
        ["<leader>fm"] = { function() tscopebuiltin.man_pages() end, "Find man" },
        ["<leader>fn"] = { function() telescope.extensions.notify.notify() end, "Find notifications" },
        ["<leader>fo"] = { function() tscopebuiltin.oldfiles() end, "Find history" },
        ["<leader>fr"] = { function() tscopebuiltin.registers() end, "Find registers" },
        ["<leader>ft"] = { function() tscopebuiltin.colorscheme { enable_preview = true } end, "Find themes" },
        ["<leader>fw"] = { function() tscopebuiltin.live_grep() end, "Find words" },
        ["<leader>fW"] = {
            function()
                tscopebuiltin.live_grep {
                    additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                }
            end,
            "Find words in all files",
        },

        -- Git stuff
        ["<leader>g"] = { name = "Git", desc = get_icon("Git") .. "Git" },
        ["<leader>gb"] = { function() tscopebuiltin.git_branches { use_file_path = true } end, "Git branches" },
        -- c = { "<cmd>Git commit<CR>", "commit" },
        ["<leader>gc"] = {
            function() tscopebuiltin.git_commits { use_file_path = true } end,
            "Git commits (repository)",
        },
        ["<leader>gC"] = {
            function() tscopebuiltin.git_bcommits { use_file_path = true } end,
            "Git commits (current file)",
        },
        ["<leader>gs"] = {
            function() tscopebuiltin.git_status { use_file_path = true } end,
            "Git status"
        },
        ["<leader>go"] = { "<cmd>GBrowse<CR>", "Open github (browser)" },
        ["<leader>gg"] = { "<cmd>Git<CR>", "fugitive" },
        ["<leader>ga"] = { "<cmd>Git add -A|Git commit<CR>", "Add & Commit" },
        ["<leader>gl"] = { function() notify("pulling...", "Git pull") end, "Pull" },
        ["<leader>gp"] = { function() notify("pushing...", "Git push") end, "Push" },
        -- y = { "<cmd>!git pull --all -p<CR>", "sync" },

        -- Terminal
        ["<leader>t"] = { name = "Terminal", desc = get_icon("Terminal") .. "Terminal" },
        ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float" },
        ["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split" },
        ["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split" },

        ["<leader>gG"] = { "<cmd>lua _lazygit_toggle()<CR>", "Lazygit" },

    })

    whichkey.register(
        {
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

            d = {
                name = "Diagnostics",
                f = { "<cmd>Telescope diagnostics<CR>", "Open in Telescope" },
                L = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Open in location list" },

                n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next" },
                p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev" },
                d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostic" },
                D = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostic" },
            },

            s = {
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
            -- group = vim.g.icons_enabled and "" or "+",
            group = "",
            separator = "",
        },
        disable = { filetypes = { "TelescopePrompt" } },
    })
end

return spec
