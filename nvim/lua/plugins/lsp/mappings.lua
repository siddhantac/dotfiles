local nmap = function(tbl)
    vim.keymap.set('n', tbl[1], tbl[2], tbl[3])
end

nmap({ "<leader>lf", vim.lsp.buf.format, { desc = "Format" } })
nmap({ "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" } })
nmap({ "<leader>ll", "<cmd>LspInfo<CR>", { desc = "LSP Info" } })
nmap({ "<leader>lf", vim.lsp.buf.format, { desc = "Format" } })
nmap({ "<leader>lR", vim.lsp.buf.references, { desc = "Refs (quickfix)" } })
