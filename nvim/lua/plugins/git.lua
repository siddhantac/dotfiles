return {
    {
        'ldelossa/gh.nvim',
        dependencies = { 'ldelossa/litee.nvim' },
        config = function()
            require('litee.lib').setup()
            require('litee.gh').setup()
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },
    {
        -- works better than tpope/vim-rhubarb
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {},
    },
    { 'tpope/vim-fugitive' },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    },
}
