return {
    { 'christoomey/vim-tmux-navigator' },

    { 'echasnovski/mini.nvim',         version = '*' },
    {
        'tpope/vim-surround',
        event = { "InsertEnter" },
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
}
