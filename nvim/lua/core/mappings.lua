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
