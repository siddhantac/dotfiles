require('autocmds') -- autocmds must come before options so that Nord bg color is set properly
require('options')
require('mappings')

-- TODO
-- packer in floating window
-- Pending plugins
--     vim test, vim-go, terminal (?), snippets (check nvim-cmp, cmp_luasnip)
--
-- Plugins
-- Run the following command to install packer
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

require('packer').startup({function()
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

    use 'tpope/vim-fugitive'

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
   }
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

-- lspconfig setup
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

require('plugins.nvim-cmp')
require('plugins.comment')
require('plugins.treesitter')
require('plugins.nvim-tree')
require('plugins.which-key')
