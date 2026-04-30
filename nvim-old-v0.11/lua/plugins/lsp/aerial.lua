local M = {}
M.opts = {
    attach_mode = "global",
    backends = { "lsp", "treesitter", "markdown", "man" },
    -- disable_max_lines = vim.g.max_file.lines,
    -- disable_max_size = vim.g.max_file.size,
    layout = { min_width = 28 },
    show_guides = true,
    filter_kind = false,
    guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
    },
}
return M
