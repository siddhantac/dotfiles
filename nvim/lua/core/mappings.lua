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

-- When pasting, don't overwrite
-- the register with the deleted text.
-- Sends the deleted text into the void register instead.
map({ "x", "<leader>p", "\"_dP" })

nmap({ "]c", ":cnext<CR>zz" })
nmap({ "[c", ":cprev<CR>zz" })
nmap({ "<C-c>", ":cclose<CR>" })

nmap({ "]t", ":tabnext<CR>" })
nmap({ "[t", ":tabprev<CR>" })

imap({ "jj", "<Esc>" })
imap({ "kk", "<Esc>" })


-- Buffers
nmap({ "]b", "<cmd>bnext<CR>", { desc = "Next buffer" } })
nmap({ "[b", "<cmd>bprev<CR>", { desc = "Prev buffer" } })
nmap({ "<leader>bb", "<cmd>b#<CR>", { desc = "Swap" } })
nmap({ "<leader>bf", "<cmd>Telescope buffers<CR>", { desc = "Find" } })
nmap({ "<leader>bc", "<cmd>close<CR>", { desc = "Close" } })
nmap({ "<leader>bd", "<cmd>bd<CR>", { desc = "Delete" } })
nmap({ "<leader>bD", "<cmd>bufdo bd<CR>", { desc = "Delete all" } })
nmap({ "<leader>bm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize (toggle)" } })

local M = {}
function M.telescope_mappings()
    local ok, telescope = pcall(require("telescope"))
    if not ok then
        vim.notify("failed to load telescope", "error")
    end

    local ok, tscopebuiltin = pcall(require("telescope.builtin"))

    if ok then
        nmap({ "<leader>ff", function() tscopebuiltin.find_files() end, { desc = "Find files" } })
        nmap({ "<leader>f<CR>", function() tscopebuiltin.resume() end, { desc = "Resume previous search" } })
        nmap({ "<leader>f'", function() tscopebuiltin.marks() end, { desc = "Find marks" } })
        nmap({ "<leader>f/", function() tscopebuiltin.current_buffer_fuzzy_find()() end,
            { desc = "Find words in current buffer" } })
        nmap({ "<nmap{eader>fb", function() tscopebuiltin.buffers() end, { desc = "Find buffers" } })
        nmap({ "<leader>fc", function() tscopebuiltin.grep_string() end, { desc = "Find word under cursor" } })
        nmap({ "<leader>fC", function() tscopebuiltin.commands() end, { desc = "Find commands" } })
        nmap({ "<leader>fF", function() tscopebuiltin.find_files({ hidden = true, no_ignore = true }) end,
            { desc = "Find all files" } })
        nmap({ "<leader>fh", function() tscopebuiltin.help_tags() end, { desc = "Find help" } })
        nmap { "<leader>fk", function() tscopebuiltin.keymaps() end, { desc = "Find keymaps" } }
        nmap { "<leader>fm", function() tscopebuiltin.man_pages() end, { desc = "Find man" } }
        nmap { "<leader>fn", function() telescope.extensions.notify.notify() end, { desc = "Find notifications" } }
        nmap { "<leader>fo", function() tscopebuiltin.oldfiles() end, { desc = "Find history" } }
        nmap { "<leader>fr", function() tscopebuiltin.registers() end, { desc = "Find registers" } }
        nmap { "<leader>fs", function() tscopebuiltin.colorscheme { enable_preview = true } end, { desc = "Find themes" } }
        nmap { "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" } }
        nmap { "<leader>fw", function() tscopebuiltin.live_grep() end, { desc = "Find words" } }
        nmap { "<leader>fW",
            function()
                tscopebuiltin.live_grep {
                    additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                }
            end,
            { desc = "Find words in all files" },
        }
    else
        vim.notify("failed to load telescope mappings", "error")
    end
end

return M
