return {
    { 'tpope/vim-fugitive' },
    {
        'tpope/vim-rhubarb',
        dependencies = {
            'tpope/vim-fugitive',
        },
        lazy = true,
        cmd = { "GBrowse", "Git", "G" },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    },
}
