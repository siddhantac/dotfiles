return {
    {
        'tpope/vim-fugitive',
        lazy = true,
        cmd = {"Git"},
    },
    {
        'tpope/vim-rhubarb',
        dependencies = {
            'tpope/vim-fugitive',
        },
        lazy = true,
        cmd = {"GBrowse"},
    },
    {
        'tpope/vim-surround',
        event = {"InsertEnter"},
    },
    -- 'tpope/vim-unimpaired'

    {
        'rcarriga/nvim-notify',
        config = function ()
            require("notify").setup({
                stages = "fade",
            })
        end,
    },
    {
        'jiangmiao/auto-pairs',
    },
    {
        'szw/vim-maximizer',
        cmd = {"MaximizerToggle"},
    },
    'christoomey/vim-tmux-navigator',
    "onsails/lspkind.nvim", -- vs-code like icons for autocompletion
    'kyazdani42/nvim-web-devicons',

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    { 'echasnovski/mini.nvim', version = '*' },
    -- 'tpope/vim-dispatch'
}
