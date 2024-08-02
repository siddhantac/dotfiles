local get_icon = require("utils").get_icon

--[[
╭────────────────────────────────────────────────────────────────────────────╮
│  Str  │  Help page   │  Affected modes                           │  VimL   │
│────────────────────────────────────────────────────────────────────────────│
│  ''   │  mapmode-nvo │  Normal, Visual, Select, Operator-pending │  :map   │
│  'n'  │  mapmode-n   │  Normal                                   │  :nmap  │
│  'v'  │  mapmode-v   │  Visual and Select                        │  :vmap  │
│  's'  │  mapmode-s   │  Select                                   │  :smap  │
│  'x'  │  mapmode-x   │  Visual                                   │  :xmap  │
│  'o'  │  mapmode-o   │  Operator-pending                         │  :omap  │
│  '!'  │  mapmode-ic  │  Insert and Command-line                  │  :map!  │
│  'i'  │  mapmode-i   │  Insert                                   │  :imap  │
│  'l'  │  mapmode-l   │  Insert, Command-line, Lang-Arg           │  :lmap  │
│  'c'  │  mapmode-c   │  Command-line                             │  :cmap  │
│  't'  │  mapmode-t   │  Terminal                                 │  :tmap  │
╰────────────────────────────────────────────────────────────────────────────╯
--]]

local map = function(tbl)
    vim.keymap.set(tbl[1], tbl[2], tbl[3], tbl[4])
end

---@diagnostic disable-next-line: unused-local, unused-function
local imap = function(tbl)
    vim.keymap.set('i', tbl[1], tbl[2], tbl[3])
end

local nmap = function(tbl)
    vim.keymap.set('n', tbl[1], tbl[2], tbl[3])
end

local vmap = function(tbl)
    vim.keymap.set('v', tbl[1], tbl[2], tbl[3])
end

local tmap = function(tbl)
    vim.keymap.set('t', tbl[1], tbl[2], tbl[3])
end

nmap({ '<C-H>', '<C-W><C-H>' })
nmap({ '<C-J>', '<C-W><C-J>' })
nmap({ '<C-K>', '<C-W><C-K>' })
nmap({ '<C-L>', '<C-W><C-L>' })

-- Easier resize
map({ '', '<s-LEFT>', ':vertical resize +5 <CR>' })
map({ '', '<s-RIGHT>', ':vertical resize -5 <CR>' })
map({ '', '<s-UP>', ':resize +5 <CR>' })
map({ '', '<s-DOWN>', ':resize -5 <CR>' })

-- Keep cursor centered when moving by pages.
nmap({ '<C-f>', '<C-f>zz' })
nmap({ '<C-d>', '<C-d>zz' })

-- When pasting, don't overwrite the register with the deleted text.
-- Sends the deleted text into the void register instead.
map({ "x", "<leader>p", "\"_dP", { desc = "Paste (no overwrite)" } })

nmap({ "]q", ":cnext<CR>zz", { desc = "Next quickfix item" } })
nmap({ "[q", ":cprev<CR>zz", { desc = "Prev quickfix item" } })
nmap({ "<C-c>", ":cclose<CR>" })

nmap({ "]t", ":tabnext<CR>", { desc = "Next tab" } })
nmap({ "[t", ":tabprev<CR>", { desc = "Prev tab" } })

imap({ "jj", "<Esc>" })
imap({ "kk", "<Esc>" })

nmap({ "<leader>w", ":w<CR>" })

nmap({ "<leader>ul", "<cmd>Twilight<cr>", { desc = "Toggle twilight" } })

-- Buffers
nmap({ "]b", "<cmd>bnext<CR>", { desc = "Next buffer" } })
nmap({ "[b", "<cmd>bprev<CR>", { desc = "Prev buffer" } })
nmap({ "<leader>bb", "<cmd>b#<CR>", { desc = "Swap" } })
nmap({ "<leader>bc", "<cmd>close<CR>", { desc = "Close" } })
nmap({ "<leader>bD", "<cmd>bufdo bd<CR>", { desc = "Delete all" } })
nmap({ "<leader>bm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize (toggle)" } })
nmap({ "<leader>bd", function()
    local bd = require("mini.bufremove").delete
    if vim.bo.modified then
        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
        if choice == 1 then -- Yes
            vim.cmd.write()
            bd(0)
        elseif choice == 2 then -- No
            bd(0, true)
        end
    else
        bd(0)
    end
end, { desc = "Delete" } })

-- Diagnostics
nmap({ "<leader>dh", function() vim.diagnostic.open_float() end, { desc = "Hover diagnostics" } })

-- LSP
nmap({ "gd", vim.lsp.buf.definition, { desc = "Go to def" } })

-- Git
local utils = require("utils")
nmap({ "<leader>gl", utils.gitpull, { desc = "Pull" } })
nmap({ "<leader>gp", utils.gitpush, { desc = "Push" } })

local M = {}

function M.telescope_mappings()
    local ok, telescope = pcall(require, "telescope")
    if not ok then
        vim.notify("failed to load telescope", "error")
    end

    local ok, tscopebuiltin = pcall(require, "telescope.builtin")
    if not ok then
        vim.notify("failed to load telescope builtin", "error")
    end

    nmap({ "<leader>bf", "<cmd>Telescope buffers<CR>", { desc = "Find" } })

    nmap({ "<leader>ff", function() tscopebuiltin.find_files({ default_text = "!mocks " }) end, { desc = "Files" } })
    nmap({ "<leader>f<CR>", function() tscopebuiltin.resume() end, { desc = "Resume previous search" } })
    nmap({ "<leader>f'", function() tscopebuiltin.marks() end, { desc = "Marks" } })
    nmap({ "<leader>f/", function() tscopebuiltin.current_buffer_fuzzy_find()() end,
        { desc = "Find words in current buffer" } })
    nmap({ "<leader>fb", function() tscopebuiltin.buffers() end, { desc = "Buffers" } })
    nmap({ "<leader>fc", function() tscopebuiltin.grep_string() end, { desc = "Word under cursor" } })
    nmap({ "<leader>fC", function() tscopebuiltin.commands() end, { desc = "Commands" } })
    nmap({ "<leader>fF", function() tscopebuiltin.find_files({ hidden = true, no_ignore = true }) end,
        { desc = "All files" } })
    nmap({ '{<leader>f.', function() tscopebuiltin.find_files({ cwd = vim.fn.expand('%:p:h') }) end,
        { desc = "Find files in dir" } }) -- find files in dir of the current file
    nmap({ "<leader>fh", function() tscopebuiltin.help_tags() end, { desc = "Help" } })
    nmap({ "<leader>fk", function() tscopebuiltin.keymaps() end, { desc = "Keymaps" } })
    nmap({ "<leader>fm", function() tscopebuiltin.man_pages() end, { desc = "Man" } })
    nmap({ "<leader>fn", function() telescope.extensions.notify.notify() end, { desc = "Notifications" } })
    nmap({ "<leader>fo", function() tscopebuiltin.oldfiles() end, { desc = "History" } })
    nmap({ "<leader>fr", function() tscopebuiltin.registers() end, { desc = "Registers" } })
    nmap({ "<leader>fs", function() tscopebuiltin.colorscheme { enable_preview = true } end, { desc = "Themes" } })
    nmap({ "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todos" } })
    nmap({ "<leader>fw", function() tscopebuiltin.live_grep() end, { desc = "Words" } })
    nmap({ "<leader>fW",
        function()
            tscopebuiltin.live_grep {
                additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
        end,
        { desc = "Words in all files" }
    })

    nmap({ "<leader>dd", function() tscopebuiltin.diagnostics() end, { desc = "Search diagnostics" } })

    nmap({ "<leader>gb", function() tscopebuiltin.git_branches { use_file_path = true } end, { desc = "Branches" } })
    nmap({ "<leader>gC", function() tscopebuiltin.git_commits { use_file_path = true } end, { desc = "Commits", } })
    nmap({ "<leader>gt", function() tscopebuiltin.git_status { use_file_path = true } end, { desc = "Status" } })

    nmap({ "<leader>lm", "<cmd>Telescope lsp_implementations show_line=false default_text=!mocks<cr>",
        { desc = "Implementation" } })
    nmap({ "<leader>lr", '<cmd>Telescope lsp_references show_line=false default_text=!_test.go<CR>',
        { desc = "Refs" } })

    nmap({
        "<leader>ls",
        function()
            local aerial_avail, _ = pcall(require, "aerial")
            if aerial_avail then
                telescope.extensions.aerial.aerial()
            else
                tscopebuiltin.lsp_document_symbols()
            end
        end,
        { desc = "Symbols" },
    })
    -- S = { '<cmd>Telescope lsp_workspace_symbols<CR>', "Workspace symbols" },

    nmap({ "<leader>lo", "<cmd>AerialToggle<CR>", { desc = "Show outline" } })
    nmap({ "<leader>j", function() tscopebuiltin.jumplist { show_line = false } end, { desc = "Jumplist" } })
end

function M.gitsigns_mappings()
    local ok, gitsigns = pcall(require, "gitsigns")
    if not ok then
        vim.notify("failed to load gitsigns", "error")
        return
    end

    nmap({ "]g", function() gitsigns.next_hunk() end, { desc = "Next Git hunk" } })
    nmap({ "[g", function() gitsigns.prev_hunk() end, { desc = "Previous Git hunk" } })
    -- ["<leader>gl"] = { function() gitsigns.blame_line() end, "View Git blame" },
    -- ["<leader>gL"] = { function() gitsigns.blame_line { full = true } end, "View full Git blame" },
    nmap({ "<leader>gh", function() gitsigns.preview_hunk() end, { desc = "Preview Git hunk" } })
    -- ["<leader>gh"] = { function() gitsigns.reset_hunk() end, "Reset Git hunk" },
    -- ["<leader>gr"] = { function() gitsigns.reset_buffer() end, "Reset Git buffer" },
    nmap({ "<leader>gs", function() gitsigns.stage_hunk() end, { desc = "Stage Git hunk" } })
    nmap({ "<leader>gS", function() gitsigns.stage_buffer() end, { desc = "Stage Git buffer" } })
    nmap({ "<leader>gu", function() gitsigns.undo_stage_hunk() end, { desc = "Unstage Git hunk" } })
    nmap({ "<leader>gd", function() gitsigns.diffthis() end, { desc = "View Git diff" } })
end

function M.neotest_mappings()
    local ok, neotest = pcall(require, "neotest")
    if not ok then
        vim.notify("failed to load neotest", "warn")
        return
    end

    -- shortcuts
    nmap({ "<leader>tt", function()
        neotest.summary.open()
        neotest.run.run()
    end, { desc = "Test" } })
    nmap({ "<leader>tc", function() neotest.summary.close() end, { desc = "Close summary panel" } })

    -- everything else
    nmap({ "<leader>tr", function() neotest.run.run() end, { desc = "Run nearest" } })
    nmap({ "<leader>tl", function() neotest.run.run_last() end, { desc = "Run last" } })
    nmap({ "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run file" } })
    nmap({ "<leader>to", function() neotest.output_panel.toggle() end, { desc = "Output panel" } })
    nmap({ "<leader>ts", function() neotest.summary.toggle() end, { desc = "Summary panel (toggle)" } })
    nmap({ "<leader>tw", function() neotest.watch.toggle() end, { desc = "Toggle watch" } })
end

function M.neogit_mappings()
    local ok, neogit = pcall(require, "neogit")
    if not ok then
        vim.notify("failed to load neogit", "warn")
        return
    end

    nmap({ "<leader>gc", function() neogit.open({ "commit" }) end, { desc = "Commit" } })
    nmap({ "<leader>gg", function() neogit.open({ kind = "split" }) end, { desc = "neogit" } })
end

-- function M.neotree_mappings()
--     local ok, neotree = pcall(require, "neo-tree")
--     if not ok then
--         vim.notify("failed to load neotree", "warn")
--         return
--     end
--
--     nmap({ "<leader>e", "<cmd>Neotree source=filesystem reveal=true position=float<CR>", { desc = "File Explorer" } })
-- end

function M.terminal_mappings()
    local ok, toggleterm = pcall(require, "toggleterm")
    if not ok then
        vim.notify("failed to load toggleterm", "warn")
        return
    end

    nmap({ "<leader>rf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" } })
    nmap({ "<leader>rh", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" } })
    nmap({ "<leader>rv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" } })
end

function M.other_mappings()
    local ok, other = pcall(require, "other-nvim")
    if not ok then
        vim.notify("failed to load other.nvim", "warn")
        return
    end

    nmap({ "<leader>te", "<cmd>Other<cr>", { desc = "open test file" } })
    nmap({ "<leader>tv", "<cmd>OtherVSplit<cr>", { desc = "open test file in vert split" } })
end

function M.gitlinker_mappings()
    local ok, gitlinker = pcall(require, "gitlinker")
    if not ok then
        vim.notify("failed to load gitlinker", "warn")
        return
    end
    local actions = gitlinker.actions

    nmap({ "<leader>gy", '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>', { desc = "copy Github url" } })
    vmap({ "<leader>gy", '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>', { desc = "copy Github url" } })
end

function M.lspsaga_mappings()
    nmap({ "<leader>ld", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek def" } })
    nmap({ "<leader>ly", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek type def" } })
    nmap({ "<leader>ln", "<cmd>Lspsaga rename<CR>", { desc = "Rename" } })
    nmap({ "<leader>lx", "<cmd>Lspsaga finder<CR>", { desc = "Finder" } })
    nmap({ "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "Code action" } })
    nmap({ "<leader>li", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Incoming calls" } })
    nmap({ "<leader>lu", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Outgoing calls" } })
end

function M.harpoon()
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then
        vim.notify("failed to load harpoon", "warn")
        return
    end

    nmap({ "<leader>ha", function()
        harpoon:list():add()
        vim.notify(" " .. get_icon("Hook") .. "harpooned!", vim.log.levels.INFO, { title = "Harpoon" })
    end, { desc = "Add file" } })
    nmap({ "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Menu" } })
    nmap({ "<leader>h1", function() harpoon:list():select(1) end, { desc = "Select 1" } })
    nmap({ "<leader>h2", function() harpoon:list():select(2) end, { desc = "Select 2" } })
    nmap({ "<leader>h3", function() harpoon:list():select(3) end, { desc = "Select 3" } })
    nmap({ "<leader>h4", function() harpoon:list():select(4) end, { desc = "Select 4" } })
    nmap({ "<leader>hp", function() harpoon:list():prev() end, { desc = "Cycle prev" } })
    nmap({ "<leader>hn", function() harpoon:list():next() end, { desc = "Cycle next" } })
    nmap({ "[h", function() harpoon:list():prev() end, { desc = "Cycle prev" } })
    nmap({ "]h", function() harpoon:list():next() end, { desc = "Cycle next" } })
end

function M.trouble_mappings()
    return {
        {
            "<leader>lg",
            "<cmd>Trouble diagnostics toggle filter.buf=0 win.position=bottom<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>lG",
            "<cmd>Trouble diagnostics toggle win.position=bottom<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>lS",
            "<cmd>Trouble symbols toggle focus=false win.position=right<cr>",
            desc = "Symbols (Trouble)",
        },
        -- {
        --     "<leader>xL",
        --     "<cmd>Trouble loclist toggle<cr>",
        --     desc = "Location List (Trouble)",
        -- },
        -- {
        --     "<leader>xQ",
        --     "<cmd>Trouble qflist toggle<cr>",
        --     desc = "Quickfix List (Trouble)",
        -- },
    }
end

return M
