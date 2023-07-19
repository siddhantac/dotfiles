return {
    'nvim-lualine/lualine.nvim',
    name = "lualine.nvim",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        local lualine = require('lualine')
        lualine.setup {
            options = { theme = 'catppuccin' },
        }
    end
}
