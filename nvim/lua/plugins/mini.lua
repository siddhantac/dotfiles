return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.sessions').setup()
        local starter = require('mini.starter')
        starter.setup({
            footer = '',
            items = {
                starter.sections.sessions(),
                starter.sections.telescope(),
            },
            -- leftover from previous config but doesn't look like
            -- it does anything
            --
            -- content_hooks = {
            --     starter.gen_hook.adding_bullet(),
            --     starter.gen_hook.aligning('center', 'center'),
            -- },
        })
    end,
}
