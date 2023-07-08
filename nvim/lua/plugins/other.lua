local spec = {
    'rgroli/other.nvim',
    lazy = true,
    cmd = {"Other", "OtherSplit", "OtherVSplit", "OtherClear"},
    config = function ()
        require("other-nvim").setup({
            mappings = {
                "golang",
            }
        })
    end,
}

return spec
