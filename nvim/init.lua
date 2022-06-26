-- Plugins
-- Run the following command to install packer
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'shaunsingh/nord.nvim'

    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    -- Pending plugins
    --     which-key, git, file browser, vim test, vim-go, lsp, terminal (?)
end)

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
vim.opt.timeoutlen = 500 -- controls how long to wait before showing which-key menu

-- TODO
-- check if this is still required after installing lsp
local augroup = vim.api.nvim_create_augroup('nord-theme-overrides', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'nord',
  group = augroup,
  command = 'highlight Normal guibg=#192029'
})
vim.cmd('colorscheme nord')

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

require('lspconfig').gopls.setup{}
require ('which-key').register(
  {
      f = {
            name = "Files",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            d = { "<cmd>Telescope find_files search_dirs=%:p:h<CR>", "Find Files in same dir", noremap=false },
          },
      b = {
          name = "Buffers",
          b = {"<cmd>b#<CR>", "Swap"},
          f = {"<cmd>Telescope buffers<CR>", "Find"},
          c = {"<cmd>close<CR>", "Close"},
          d = {"<cmd>bd<CR>", "Delete"},
      },
      l = {
          name = "LSP",
          i = {vim.lsp.buf.implementation, "Implementation"},
          s = {vim.lsp.buf.signature_help, "Signature help"},
          h = {vim.lsp.buf.hover, "Hover"},
          y = {vim.lsp.buf.type_definition, "Go to type def"},
          d = {vim.lsp.buf.definition, "Go to def"},
          n = {vim.lsp.buf.rename, "Rename"},
          r = {vim.lsp.buf.references, "References in loc list"},
          R = {':Telescope lsp_references<CR>', "References in Telescope"},

      },
      w = {"<cmd>w<CR>", "Save"},
      s = {"<cmd>Telescope live_grep<CR>", "Search"}
    }, 
    { prefix = "<leader>" }
)

