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

      require ('which-key').register(
        {
            l = {
                name = "LSP",
                -- s = {vim.lsp.buf.signature_help, "Signature help"},
                -- n = {vim.lsp.buf.rename, "Rename"},
                i = {vim.lsp.buf.implementation, "Implementation"},
                I = {"<cmd>Telescope lsp_implementations<cr>", "Implementation"},
                h = {vim.lsp.buf.hover, "Hover"},
                y = {vim.lsp.buf.type_definition, "Go to type def"},
                x = {vim.lsp.buf.formatting, "Format"},
                D = {vim.lsp.buf.definition, "Go to def"},
                r = {vim.lsp.buf.references, "References in loc list"},
                R = {'<cmd>Telescope lsp_references<CR>', "References in Telescope"},
                s = {'<cmd>Telescope lsp_document_symbols<CR>', "Document symbols"},
                S = {'<cmd>Telescope lsp_workspace_symbols<CR>', "Workspace symbols"},
                l = {'<cmd>LspInfo<CR>', "LSP Info"},


                d = {"<cmd>Lspsaga peek_definition<CR>", "Peek definition"},
                n = {"<cmd>Lspsaga rename<CR>", "Rename"},
                f = {"<cmd>Lspsaga lsp_finder<CR>", "Finder"},
                a = {"<cmd>Lspsaga code_action<CR>", "Code action"},
                o = {"<cmd>Lspsaga outline<CR>", "Show outline"},
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

    lspconfig.gopls.setup {
        -- on_attach = my_custom_on_attach,
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
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig.yamlls.setup {}
    lspconfig.pyright.setup {}
    lspconfig.tsserver.setup {}
    lspconfig.jsonls.setup {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
          end
        }
      }
}
end

return spec

