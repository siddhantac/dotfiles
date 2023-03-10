
-- TODO
-- Pending plugins
--     vim-go
--     snippets (check nvim-cmp, cmp_luasnip),
--
-- Plugins
-- Run the following command to install packer
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

require('packer').startup({function(use)
    -- tools and utilities
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'numToStr/Comment.nvim'
    use "folke/which-key.nvim"
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'jiangmiao/auto-pairs'
    use 'rcarriga/nvim-notify'
    use 'szw/vim-maximizer'
    use 'ThePrimeagen/harpoon'

    -- the commands are not very useful
    -- but the syntax highlighting is good
    use 'ledger/vim-ledger'

    use {
        "akinsho/toggleterm.nvim",
        tag = '*'
    }

    use {
      'Shatur/neovim-session-manager',
      requires = {'nvim-lua/plenary.nvim'}
    }

    -- appearance
    use 'shaunsingh/nord.nvim'
    use 'rose-pine/neovim'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- snippets
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use  'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    -- lsp
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig', -- Configurations for Nvim LSP
    }
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use({ "glepnir/lspsaga.nvim", 
        branch = "main",
        requires = { 'kyazdani42/nvim-web-devicons' }
    }) -- enhanced lsp uis
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    --
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'vim-test/vim-test'
    use 'tpope/vim-dispatch'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'

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

