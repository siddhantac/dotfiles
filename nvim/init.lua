-- TODO
-- Pending plugins
--     git, file browser, vim test, vim-go, terminal (?), snippets (check nvim-cmp, cmp_luasnip)
--
-- Plugins
-- Run the following command to install packer
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'shaunsingh/nord.nvim'

    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup { }
      end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
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


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls' } -- 'clangd', 'rust_analyzer', 'pyright', 'tsserver' 
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- treesitter setup
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

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

