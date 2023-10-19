local on_attach = function(client, bufnr)
    -- if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end,
    })
    -- end
end

local M = {}
M.setup = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local on_attach = on_attach

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    lspconfig.gopls.setup {
        on_attach = on_attach,
        -- capabilities = capabilities,
    }

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
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

    lspconfig.yamlls.setup({
        on_attach = on_attach
    })
    lspconfig.pyright.setup {}
    lspconfig.tsserver.setup {}
    lspconfig.jsonls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                end
            }
        }
    }
end

return M
