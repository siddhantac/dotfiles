local spec = {
    'numToStr/Comment.nvim',
    event = {"BufRead"},
    config = function()
        require('Comment').setup()
    end,
}

return spec

