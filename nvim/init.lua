HOME = os.getenv("HOME")

-- Custom settings
vim.g.mapleader = ' '
vim.opt.encoding = "utf8"

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

-- TODO
-- check if this is still required after installing lsp
local augroup = vim.api.nvim_create_augroup('nord-theme-overrides', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'nord',
  group = augroup,
  command = 'highlight Normal guibg=#192029'
})
vim.cmd('colorscheme nord')

-- vim.opt.colorscheme = "nord"
-- vim.opt.laststatus = 2
-- vim.opt.hlsearch = true
-- vim.opt.list = true
-- vim.opt.autowrite = true -- save file when :make or :GoBuild is called


local augroup = vim.api.nvim_create_augroup('numbertoggle', {clear = true})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  group = augroup,
  command = 'set relativenumber'
})
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*',
  group = augroup,
  command = 'set norelativenumber'
})

-- Autosave only when there is something to save,
-- always saving makes build watchers crazy
vim.api.nvim_create_autocmd('FocusLost', {
    pattern = '*',
    command = 'silent! wa'
})

-- Easier Navigation
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')

-- Easier resize
vim.keymap.set('', '<s-LEFT>', ':vertical resize +5 <CR>')
vim.keymap.set('', '<s-RIGHT>', ':vertical resize -5 <CR>')
vim.keymap.set('', '<s-UP>', ':resize +5 <CR>')
vim.keymap.set('', '<s-DOWN>', ':resize -5 <CR>')

-- Easy write
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- Buffers
vim.keymap.set('n', '<leader><leader>', ':b#<CR>') -- buffer switch
vim.keymap.set('n', '<leader>c', ':close<CR>') -- buffer close
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>') -- list git files

-- Opening files
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>') -- list git files
vim.keymap.set('n', '<leader>d', ':Telescope find_files search_dirs=%:p:h<CR>') -- list files in same dir as current file

vim.keymap.set('n', '<leader>s', ':Telescope live_grep<CR>') -- search for a string

-- LSP
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, bufopts) -- lsp references
vim.keymap.set('n', '<leader>lR', ':Telescope lsp_references<CR>') -- lsp references with telescope


-- Plugins
-- Run the following command to install packer
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

require'lspconfig'.gopls.setup{}

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'shaunsingh/nord.nvim'
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Pending plugins
    --     which-key, git, file browser, terminal (?), vim test, vim-go, lsp
end)
