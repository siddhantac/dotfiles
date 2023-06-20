local spec = {
    'nvim-lualine/lualine.nvim',
    name = "lualine.nvim",
    dependencies = {
        'kyazdani42/nvim-web-devicons'
    },
}

function spec:config()
    local lualine = require('lualine')
    lualine.setup {
      options = { theme  = 'catppuccin' },
    }
end

return spec
