require("lazy").setup({
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("plugins.catppuccin").setup()
        end,
    },

    { 'christoomey/vim-tmux-navigator' },
})
