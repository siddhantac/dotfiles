HOME = os.getenv("HOME")

-- Custom settings
vim.g.mapleader = ' '
vim.opt.encoding = "utf8"

vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.numberwidth = 5

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true -- maintain undo history between sessions
vim.opt.undodir = HOME .. '/.lvim/undodir'

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.expandtab = true
vim.opt.tabstop = 4 -- show existing tab with 4 spaces width
vim.opt.shiftwidth = 4 -- when indenting with '>', use 4 spaces width
vim.opt.softtabstop = 4 -- control <tab> and <bs> keys to match tabstop
vim.opt.numberwidth = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.listchars = "tab:\\ ,trail:·"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.syntax = "on"
vim.opt.timeoutlen = 500 -- controls how long to wait before showing which-key menu
vim.opt.hidden = true
vim.opt.autoread = true

vim.cmd('colorscheme nord')
vim.notify = require("notify")

vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99
-- vim.opt.laststatus = 2
-- vim.opt.hlsearch = true
-- vim.opt.list = true

-- required to highlight the word under cursor (see in autocmds.lua)
vim.cmd([[hi LspReferenceRead cterm=bold ctermbg=red guibg=#5E81AC]])
vim.cmd([[hi LspReferenceText cterm=bold ctermbg=red guibg=#5E81AC]])
vim.cmd([[hi LspReferenceWrite cterm=bold ctermbg=red guibg=#5E81AC]])

