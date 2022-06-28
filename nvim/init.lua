require('autocmds') -- autocmds must come before options so that Nord bg color is set properly
require('options')
require('mappings')

require('plugins')
require('plugins.lspconfig')
require('plugins.nvim-cmp')
require('plugins.comment')
require('plugins.treesitter')
require('plugins.nvim-tree')
require('plugins.which-key')
