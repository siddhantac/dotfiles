require('plugins')
require('plugins.lualine')
require('plugins.comment')
require('plugins.treesitter')
require('plugins.nvim-tree')
require('plugins.which-key')
require('plugins.lspinstaller')
require('plugins.lspconfig')
require('plugins.nvim-cmp')
require('plugins.vim-test')
require('plugins.alpha')
require('plugins.session-manager')
require('plugins.toggle-term')
-- require('plugins.luasnip')

require('autocmds') -- autocmds must come before options so that Nord bg color is set properly
require('options')
require('mappings')

