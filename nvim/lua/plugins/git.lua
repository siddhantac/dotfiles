local core_mappings = require("core.mappings")

return {
    -- Git plugins
    {
        "NeogitOrg/neogit",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional
            "nvim-telescope/telescope.nvim", -- optional
            -- "ibhagwan/fzf-lua",              -- either this or Telescope, not both
        },
        config = true,
        keys = core_mappings.neogit_mappings,
    },
    {
        -- works better than tpope/vim-rhubarb
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {},
        keys = core_mappings.gitlinker_mappings,
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'tpope/vim-fugitive',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end,
        keys = core_mappings.gitsigns_mappings,
        event = { "VeryLazy" },
    },

}
