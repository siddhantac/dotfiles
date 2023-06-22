return {
    {
        'tpope/vim-fugitive',
        lazy = true,
        cmd = {"Git"},
    },
    {
        'tpope/vim-rhubarb',
        lazy = true,
        cmd = {"GBrowse"},
    },
    {
        'tpope/vim-surround',
        event = {"InsertEnter"},
    },
    -- 'tpope/vim-unimpaired'

    'rcarriga/nvim-notify',
    {
        'jiangmiao/auto-pairs',
        event = {"InsertEnter"},
    },
    {
        'szw/vim-maximizer',
        cmd = {"MaximizerToggle"},
    },
    'christoomey/vim-tmux-navigator',
    "onsails/lspkind.nvim", -- vs-code like icons for autocompletion

    -- 'tpope/vim-dispatch'
}
