local spec = {
    "nvim-neotest/neotest",
    name = "neotest",
    dependencies = {
        "nvim-neotest/neotest-go",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-go")({
                }),
                -- require("neotest-plenary"),
                -- require("neotest-vim-test")({
                --     ignore_file_types = { "python", "vim", "lua" },
                -- }),
            },
        })
    end,
}

return spec
