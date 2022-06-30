require("nvim-lsp-installer").setup {
  automatic_installation = true
}

local lspconfig = require("lspconfig")

lspconfig.sumneko_lua.setup {}
lspconfig.yamlls.setup {}
lspconfig.gopls.setup {}
lspconfig.pyright.setup {}
