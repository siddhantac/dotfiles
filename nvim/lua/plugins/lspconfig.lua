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

    -- lspconfig setup
    -- enable keybinds only for when lsp server available
    -- local on_attach = function(client, bufnr)
    -- keybind options
    -- local opts = { noremap = true, silent = true, buffer = bufnr }

    require('which-key').register(
        {
            l = {
                name = "LSP",

                h = { vim.lsp.buf.hover, "Hover" },
                x = { vim.lsp.buf.format, "Format" },

                m = { "<cmd>Telescope lsp_implementations<cr>", "Implementation" },
                r = { '<cmd>Telescope lsp_references<CR>', "Refs in Telescope" },
                s = { '<cmd>Telescope lsp_document_symbols<CR>', "Document symbols" },
                S = { '<cmd>Telescope lsp_workspace_symbols<CR>', "Workspace symbols" },
                l = { '<cmd>LspInfo<CR>', "LSP Info" },

                d = { "<cmd>Lspsaga peek_definition<CR>", "Peek def" },
                y = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek type def" },
                n = { "<cmd>Lspsaga rename<CR>", "Rename" },
                f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
                a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
                o = { "<cmd>Lspsaga outline<CR>", "Show outline" },
                i = { "<cmd>Lspsaga incoming_calls<CR>", "Incoming calls" },
                u = { "<cmd>Lspsaga outgoing_calls<CR>", "Outgoing calls" },
            }
        },
        { prefix = "<leader>" }
    )
    -- end

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = cmp_nvim_lsp.default_capabilities()
    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local function no_hl_on_attach(client, bufnr)
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
        on_attach = no_hl_on_attach,
        capabilities = capabilities,
    }

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = no_hl_on_attach,
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
        on_attach = no_hl_on_attach
    })
    lspconfig.pyright.setup {}
    lspconfig.tsserver.setup {}
    lspconfig.jsonls.setup {
        capabilities = capabilities,
        on_attach = no_hl_on_attach,
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
