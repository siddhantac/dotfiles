local M = {}
M.setup = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Apply cmp capabilities and any global defaults to ALL servers via the
    -- wildcard config. This replaces the old `on_attach` capabilities pattern.
    vim.lsp.config('*', {
        capabilities = cmp_nvim_lsp.default_capabilities(),
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Per-buffer LSP keymaps and autoformat — replaces the old on_attach pattern.
    -- LspAttach fires once per buffer when any LSP client attaches.
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            local nmap = function(lhs, rhs, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set('n', lhs, rhs, opts)
            end

            nmap("<leader>lf", vim.lsp.buf.format, { desc = "Format" })
            nmap("<leader>lh", vim.lsp.buf.hover, { desc = "Hover" })
            nmap("<leader>ll", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
            nmap("<leader>lR", vim.lsp.buf.references, { desc = "Refs (quickfix)" })

            -- don't setup autoformat for JSON because the
            -- LSP's default formatting doesn't match the formatting
            -- in some repos.
            if vim.bo[bufnr].filetype ~= "json" then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
    })

    vim.lsp.config('lua_ls', {
        settings = {
            Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                    globals = { "vim" },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })

    vim.lsp.enable('gopls')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('yamlls')
    vim.lsp.enable('pyright')
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('terraformls')
    vim.lsp.enable('jsonls')
    vim.lsp.enable('marksman')
end

return M
