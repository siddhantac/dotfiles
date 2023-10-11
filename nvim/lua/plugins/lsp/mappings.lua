local nmap = function(tbl)
    vim.keymap.set('n', tbl[1], tbl[2], tbl[3])
end

nmap({ "gd", vim.lsp.buf.goto_definition, { desc = "Go to def" } })
nmap({ "<leader>lf", vim.lsp.buf.format, { desc = "Format" } })
nmap({ "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" } })
nmap({ "<leader>lR", vim.lsp.buf.references, { desc = "Refs in Telescope" } })
