local spec = {
    'rgroli/other.nvim',
    config = function ()
        require("other-nvim").setup({
            mappings = {
                "golang",
            }
        })
    end,
}

return spec
