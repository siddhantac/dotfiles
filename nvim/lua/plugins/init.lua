require("lazy").setup({
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("plugins.catppuccin").setup()
        end,
    },

    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                stages = "static",
            })

            vim.notify = require("notify")
            -- TODO:: call mappings from here
            -- https://github.com/dkarter/dotfiles/blob/57c6a4c2e98c0cd6ed851aa5791351591eb34df5/config/nvim/lua/plugins/init.lua#L799
        end,
    },

    { 'christoomey/vim-tmux-navigator' },
})
