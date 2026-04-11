-- Custom settings
vim.g.mapleader = ' '
vim.opt.encoding = "utf8"
vim.opt.updatetime = 500 -- affects CursorHold time (to highlight a text object)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.signcolumn = "yes" -- stops flickering from the LSP code-action lightbulb icon

vim.opt.splitright = true
vim.opt.splitbelow = true

-- TODO: disabled these so that I can add Undotree later via vim-pack
-- vim.opt.undofile = true -- maintain undo history between sessions
-- vim.opt.undodir = HOME .. '/.lvim/undodir'

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

vim.opt.expandtab = true
vim.opt.tabstop = 4     -- show existing tab with 4 spaces width
vim.opt.shiftwidth = 4  -- when indenting with '>', use 4 spaces width
vim.opt.softtabstop = 4 -- control <tab> and <bs> keys to match tabstop
vim.opt.numberwidth = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.listchars = "tab:\\ ,trail:·"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.lazyredraw = false -- 2023-08-02: disabled as https://github.com/folke/noice.nvim was throwing an error
vim.opt.syntax = "on"
vim.opt.timeoutlen = 500   -- controls how long to wait before showing which-key menu
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.swapfile = false

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99

vim.opt.hlsearch = false
-- vim.opt.laststatus = 2
-- vim.opt.list = true

vim.opt.list = true
vim.opt.listchars = { leadmultispace = "│   ", tab = "│ ", }

vim.opt.conceallevel = 2


---------------------------------------------------------------------------------
-- xxx
---------------------------------------------------------------------------------

vim.pack.add({
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/rebelot/kanagawa.nvim",
    'https://github.com/stevearc/overseer.nvim',
    "https://github.com/folke/which-key.nvim",
})

-- rcarriga/nvim-notify
require("notify").setup({
    stages = "fade",
    top_down = true,
    background_colour = "#000000",
})
vim.notify = require("notify")

function get_icon(name)
    return ""
end

local wk = require("which-key")
wk.setup({
        icons = {
            -- group = vim.g.icons_enabled and "" or "+",
            group = "",
            separator = "",
        },
        disable = { filetypes = { "TelescopePrompt" } },
})
wk.add({
    -- Sections
    { "<leader>g",  group = "Git",                                               icon = get_icon("Git") },
    { "<leader>r",  group = "Terminal",                                          icon = get_icon("Terminal") },
    { "<leader>t",  group = "Test",                                              icon = get_icon("Debugger") },
    { "<leader>b",  group = "Buffers",                                           icon = get_icon("Tab") },
    { "<leader>d",  group = "Diagnostics",                                       icon = get_icon("Diagnostic") },
    { "<leader>l",  group = "LSP",                                               icon = get_icon("ActiveLSP") },
    { "<leader>u",  group = "Plugins",                                           icon = get_icon("Package") },
    { "<leader>f",  group = "Find (telescope)",                                  icon = get_icon("Search") },
    { "<leader>h",  group = "Harpoon",                                           icon = get_icon("Hook") },
    { "<leader>u",  group = "UI",                                                icon = get_icon("GitUntracked") },
    { "<leader>o",  group = "Overseer",                                          icon = get_icon("CommandPalette") },

    { "<leader>ga", "<cmd>Git add -A|Git commit<CR>",                            desc = "Add & Commit",            mode = "n" },
    { "<leader>z",  function() lazy.home() end,                                  desc = "Lazy",                    mode = "n" },
    { "<leader>w",  "<cmd>w<CR>",                                                desc = "Save",                    mode = "n", icon = get_icon("Save") },
    { "<leader>e",  function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, desc = "File explorer",           mode = "n", icon = get_icon("FolderClosed") },
    { "<leader>x",  group = "Git conflict",                                      icon = get_icon("Git") },
})


-- colorscheme
vim.cmd.colorscheme "kanagawa"


-- keymaps
local nmap = function(tbl)
    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.add({ tbl[1], tbl[2], desc = tbl[3].desc, mode = "n", icon = tbl[3].icon })
    else
        vim.keymap.set('n', tbl[1], tbl[2], tbl[3])
    end
end

icons = require("nerd_font")

-- Overseer
nmap({ "<leader>oo", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer", icon = icons["Toggle"] } })
nmap({ "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run Overseer" } })
