return function(client, bufnr)
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

    -- Only highlight if compatible with the language
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd('augroup LspHighlight')
        vim.cmd('autocmd!')
        vim.cmd('autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
        vim.cmd('autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
        vim.cmd('augroup END')
    else
        local ok, notify = pcall(require, "notify")
        if ok then vim.notify = notify end
        vim.notify("highlights not available", "warn", {
            title = "lsp",
            render = "compact",
        })
    end
end
