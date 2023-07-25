return {
    require('which-key').register({
            ["<leader>lf"] = { vim.lsp.buf.format, "Format" },
            ["<leader>lh"] = { vim.lsp.buf.hover, "Hover" },
            ["<leader>lm"] = { "<cmd>Telescope lsp_implementations<cr>", "Implementation" },
            ["<leader>lr"] = { '<cmd>Telescope lsp_references<CR>', "Refs in Telescope" },
            ["<leader>ls"] = {
                function()
                    local aerial_avail, _ = pcall(require, "aerial")
                    if aerial_avail then
                        require("telescope").extensions.aerial.aerial()
                    else
                        require("telescope.builtin").lsp_document_symbols()
                    end
                end, "Document symbols" },
            ["<leader>ld"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek def" },
            ["<leader>ly"] = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek type def" },
            ["<leader>ln"] = { "<cmd>Lspsaga rename<CR>", "Rename" },
            ["<leader>lx"] = { "<cmd>Lspsaga finder<CR>", "Finder" },
            ["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", "Code action" },
            ["<leader>li"] = { "<cmd>Lspsaga incoming_calls<CR>", "Incoming calls" },
            ["<leader>lu"] = { "<cmd>Lspsaga outgoing_calls<CR>", "Outgoing calls" },
            ["<leader>lo"] = { "<cmd>AerialToggle<CR>", "Show outline" },
            -- S = { '<cmd>Telescope lsp_workspace_symbols<CR>', "Workspace symbols" },
        })
}
