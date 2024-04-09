HOME = os.getenv("HOME")

-- Custom settings
vim.g.mapleader = ' '
vim.opt.encoding = "utf8"
vim.opt.updatetime = 500 -- affects CursorHold time (to highlight a text object)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true -- maintain undo history between sessions
vim.opt.undodir = HOME .. '/.lvim/undodir'

vim.opt.scrolloff = 5
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

vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99
vim.opt.hlsearch = false
-- vim.opt.laststatus = 2
-- vim.opt.list = true

-- vim.g.copilot_assume_mapped = true
-- vim.g.copilot_no_tab_map = true

vim.opt.list = true
vim.opt.listchars = { leadmultispace = "│   ", tab = "│ ", }

vim.opt.conceallevel = 2
