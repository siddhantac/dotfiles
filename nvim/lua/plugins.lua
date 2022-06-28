
-- TODO
-- packer in floating window
-- Pending plugins
--     vim test, vim-go, terminal (?), snippets (check nvim-cmp, cmp_luasnip),
--     vim surround, airline
--
-- Plugins
-- Run the following command to install packer
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

require('packer').startup({function()
    use 'wbthomason/packer.nvim'
    use 'shaunsingh/nord.nvim'
    use 'tpope/vim-fugitive'
    use 'numToStr/Comment.nvim' 
    use "folke/which-key.nvim" 

    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use {
        'L3MON4D3/LuaSnip', -- Snippets plugin
        config = function()
            require('luasnip').setup{}
        end
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      }
    }

end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

