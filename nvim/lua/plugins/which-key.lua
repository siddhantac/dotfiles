local spec          = {
    "folke/which-key.nvim",
    name = "which-key.nvim",
}

local get_icon      = require("utils").get_icon
local telescope     = require("telescope")
local tscopebuiltin = require("telescope.builtin")
local Terminal      = require('toggleterm.terminal').Terminal
local lazygit       = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local gitsigns      = require("gitsigns")
local lazy          = require("lazy")
-- local resession     = require("resession")
local sessions = require("mini.sessions")

local gitpush       = function()
    local orig = vim.notify("Pushing...", "info", {
        title = "Git", render = "compact" })

    local result = vim.fn.system("git push")
    if vim.v.shell_error == 0 then
        vim.notify("Pushing... success!", "info", { replace = orig })
    else
        vim.notify("Pushing... failed!" .. result, "error", { replace = orig })
        vim.notify(result, "error", { title = "Git" })
    end
end

local gitpull       = function()
    local orig = vim.notify("Pulling...", "info", {
        title = "Git", render = "compact" })

    local result = vim.fn.system("git pull")
    if vim.v.shell_error == 0 then
        vim.notify("Pulling... success!", "info", { replace = orig })
    else
        vim.notify("Pulling... failed!" .. result, "error", { replace = orig })
        vim.notify(result, "error", { title = "Git" })
    end
end

function spec:config()
    local whichkey = require('which-key')

    whichkey.register({
        -- find with telescope
        ["<leader>f"]     = { name = "Find", desc = get_icon("Search") .. "Find" },
        ["<leader>ff"]    = { function() tscopebuiltin.find_files() end, "Find files" },
        ["<leader>f<CR>"] = { function() tscopebuiltin.resume() end, "Resume previous search" },
        ["<leader>f'"]    = { function() tscopebuiltin.marks() end, "Find marks" },
        ["<leader>f/"]    = { function() tscopebuiltin.current_buffer_fuzzy_find()() end, "Find words in current buffer" },
        ["<leader>fb"]    = { function() tscopebuiltin.buffers() end, "Find buffers" },
        ["<leader>fc"]    = { function() tscopebuiltin.grep_string() end, "Find word under cursor" },
        ["<leader>fC"]    = { function() tscopebuiltin.commands() end, "Find commands" },
        ["<leader>fF"]    = {
            function() tscopebuiltin.find_files { hidden = true, no_ignore = true } end,
            "Find all files",
        },
        ["<leader>fh"]    = { function() tscopebuiltin.help_tags() end, "Find help" },
        ["<leader>fk"]    = { function() tscopebuiltin.keymaps() end, "Find keymaps" },
        ["<leader>fm"]    = { function() tscopebuiltin.man_pages() end, "Find man" },
        ["<leader>fn"]    = { function() telescope.extensions.notify.notify() end, "Find notifications" },
        ["<leader>fo"]    = { function() tscopebuiltin.oldfiles() end, "Find history" },
        ["<leader>fr"]    = { function() tscopebuiltin.registers() end, "Find registers" },
        ["<leader>ft"]    = { function() tscopebuiltin.colorscheme { enable_preview = true } end, "Find themes" },
        ["<leader>fw"]    = { function() tscopebuiltin.live_grep() end, "Find words" },
        ["<leader>fW"]    = {
            function()
                tscopebuiltin.live_grep {
                    additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                }
            end,
            "Find words in all files",
        },

        -- Git stuff
        ["<leader>g"]     = { name = "Git", desc = get_icon("Git") .. "Git" },
        ["<leader>gb"]    = { function() tscopebuiltin.git_branches { use_file_path = true } end, "Git branches" },
        -- c = { "<cmd>Git commit<CR>", "commit" },
        ["<leader>gc"]    = {
            function() tscopebuiltin.git_commits { use_file_path = true } end,
            "Git commits (repository)",
        },
        ["<leader>gC"]    = {
            function() tscopebuiltin.git_bcommits { use_file_path = true } end,
            "Git commits (current file)",
        },
        ["<leader>gt"]    = {
            function() tscopebuiltin.git_status { use_file_path = true } end,
            "Git status"
        },
        ["<leader>go"]    = { "<cmd>GBrowse<CR>", "Open github (browser)" },
        ["<leader>gg"]    = { "<cmd>Git<CR>", "fugitive" },
        ["<leader>ga"]    = { "<cmd>Git add -A|Git commit<CR>", "Add & Commit" },
        ["<leader>gl"]    = { gitpull, "Pull" },
        ["<leader>gp"]    = { gitpush, "Push" },
        -- y = { "<cmd>!git pull --all -p<CR>", "sync" },

        -- Gitsigns
        ["]g"]            = { function() gitsigns.next_hunk() end, "Next Git hunk" },
        ["[g"]            = { function() gitsigns.prev_hunk() end, "Previous Git hunk" },
        -- ["<leader>gl"] = { function() gitsigns.blame_line() end, "View Git blame" },
        -- ["<leader>gL"] = { function() gitsigns.blame_line { full = true } end, "View full Git blame" },
        ["<leader>gh"]    = { function() gitsigns.preview_hunk() end, "Preview Git hunk" },
        -- ["<leader>gh"] = { function() gitsigns.reset_hunk() end, "Reset Git hunk" },
        -- ["<leader>gr"] = { function() gitsigns.reset_buffer() end, "Reset Git buffer" },
        ["<leader>gs"]    = { function() gitsigns.stage_hunk() end, "Stage Git hunk" },
        ["<leader>gS"]    = { function() gitsigns.stage_buffer() end, "Stage Git buffer" },
        ["<leader>gu"]    = { function() gitsigns.undo_stage_hunk() end, "Unstage Git hunk" },
        ["<leader>gd"]    = { function() gitsigns.diffthis() end, "View Git diff" },
        ["<leader>gG"]    = { function() lazygit:toggle() end, "Lazygit" },

        -- Terminal
        ["<leader>r"]     = { name = "Terminal", desc = get_icon("Terminal") .. "Terminal" },
        ["<leader>rf"]    = { "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float" },
        ["<leader>rh"]    = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split" },
        ["<leader>rv"]    = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split" },

        -- Test
        ["<leader>t"]     = { name = "Test", desc = get_icon("Debugger") .. "Test" },
        ["<leader>tr"]    = { function() require("neotest").run.run() end, "Run nearest" },
        ["<leader>tl"]    = { function() require("neotest").run.run_last() end, "Run last" },
        ["<leader>tf"]    = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Run file" },
        ["<leader>to"]    = { function() require("neotest").output_panel.toggle() end, "Output panel" },
        ["<leader>ts"]    = { function() require("neotest").summary.toggle() end, "Summary panel" },
        ["<leader>te"]    = { "<cmd>Other<cr>", "open test file" },
        ["<leader>tv"]    = { "<cmd>OtherVSplit<cr>", "open test file in vert split" },

        -- Buffers
        ["<leader>b"]     = { name = "Buffers", desc = get_icon("Tab") .. "Buffers" },
        ["]b"]            = { "<cmd>bnext<CR>", "Next buffer" },
        ["[b"]            = { "<cmd>bprev<CR>", "Prev buffer" },
        ["<leader>bb"]    = { "<cmd>b#<CR>", "Swap" },
        ["<leader>bf"]    = { "<cmd>Telescope buffers<CR>", "Find" },
        ["<leader>bc"]    = { "<cmd>close<CR>", "Close" },
        ["<leader>bd"]    = { "<cmd>bd<CR>", "Delete" },
        ["<leader>bD"]    = { "<cmd>bufdo bd<CR>", "Delete all" },
        ["<leader>bm"]    = { "<cmd>MaximizerToggle<CR>", "Maximize (toggle)" },

        -- Plugins
        ["<leader>u"]     = { name = "Plugins", desc = get_icon("Package") .. "Plugins" },
        ["<leader>uu"]    = { function() lazy.home() end, "Plugins Status" },

        -- Sessions
        ["<leader>s"]     = { name = "Sessions", desc = get_icon("Session") .. "Sessions" },
        ["<leader>ss"]    = { function () sessions.select("write") end, "Save" },
        ["<leader>sl"]    = { function () sessions.select("read") end, "Load" },
        ["<leader>sd"]    = { function () sessions.select("delete") end, "Delete" },

        -- Diagnostics
        ["<leader>d"]     = { name = "Diagnostics", desc = get_icon("Diagnostic") .. "Diagnostics" },
        ["<leader>dd"]    = { function() tscopebuiltin.diagnostics() end, "Search diagnostics" },
        ["<leader>dh"]    = { function() vim.diagnostic.open_float() end, "Hover diagnostics" },
        ["]d"]            = { function() vim.diagnostic.goto_next() end, "Next diagnostic" },
        ["[d"]            = { function() vim.diagnostic.goto_prev() end, "Prev diagnostic" },
        -- n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next" },
        -- p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev" },
        -- d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostic" },
        -- D = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostic" },

        -- LSP
        ["<leader>l"] = { name = "LSP", desc = get_icon("ActiveLSP") .. "LSP" },
        ["<leader>ll"] = {"<cmd>LspInfo<CR>", "LSP Info"},
    })

    whichkey.register(
        {
            e = { "<cmd>NvimTreeFindFileToggle<CR>", "File Explorer" },
            w = { "<cmd>w<CR>", "Save" },
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
