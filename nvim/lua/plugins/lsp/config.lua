return function(client, bufnr)
    -- Only highlight if compatible with the language
    if client.server_capabilities.documentHighlightProvider then
        local lsp_highlight = vim.api.nvim_create_augroup("LspHighlight", {clear = true})
        vim.api.nvim_create_autocmd("CursorHold", {
            group = lsp_highlight,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            group = lsp_highlight,
            callback = function()
                vim.lsp.buf.clear_references()
            end
        })
    else
        local ok, notify = pcall(require, "notify")
        if ok then vim.notify = notify end
        vim.notify("highlights not available", "warn", {
            title = "lsp",
            render = "compact",
        })
    end

    -- if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    -- end
end
