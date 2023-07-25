return {
    { "lukas-reineke/indent-blankline.nvim" },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        'tpope/vim-fugitive',
    },
    {
        'tpope/vim-rhubarb',
        dependencies = {
            'tpope/vim-fugitive',
        },
        lazy = true,
        cmd = { "GBrowse", "Git", "G" },
    },
    {
        'tpope/vim-surround',
        event = { "InsertEnter" },
    },
    -- 'tpope/vim-unimpaired'

    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                stages = "static",
            })
        end,
    },
    {
        'jiangmiao/auto-pairs',
    },
    {
        'szw/vim-maximizer',
        cmd = { "MaximizerToggle" },
    },
    'christoomey/vim-tmux-navigator',
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    }, -- vs-code like icons for autocompletion
    'nvim-tree/nvim-web-devicons',

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'echasnovski/mini.nvim',                  version = '*' },
    -- 'tpope/vim-dispatch'
}
