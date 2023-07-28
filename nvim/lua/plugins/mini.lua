return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.comment').setup()
        require('mini.surround').setup()
        require('mini.sessions').setup()
        local starter = require('mini.starter')
        starter.setup({
            footer = '',
            items = {
                starter.sections.sessions(),
                starter.sections.telescope(),
            },
        })
    end,
}
