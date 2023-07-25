local spec = {
    'neovim/nvim-lspconfig', -- Configurations for Nvim LSP
    name = "lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    },
}

function spec:config()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    require("plugins.config.lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local function on_attach(client, bufnr)
        -- Only highlight if compatible with the language
        if client.server_capabilities.documentHighlightProvider then
            vim.cmd('augroup LspHighlight')
            vim.cmd('autocmd!')
            vim.cmd('autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
            vim.cmd('autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
            vim.cmd('augroup END')
        else
            vim.notify("highlights not available", "warn", {
                title = "lsp",
                render = "compact",
            })
        end
    end

    lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
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

return spec
