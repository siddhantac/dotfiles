-- lspconfig setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- NOTE: not sure if this being used as such
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls' } -- 'clangd', 'rust_analyzer', 'pyright', 'tsserver'
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end


lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'use' }
            }
        }
    }
}
lspconfig.yamlls.setup {}
lspconfig.gopls.setup {}
lspconfig.pyright.setup {}

require ('which-key').register(
  {
      l = {
          name = "LSP",
          i = {vim.lsp.buf.implementation, "Implementation"},
          s = {vim.lsp.buf.signature_help, "Signature help"},
          h = {vim.lsp.buf.hover, "Hover"},
          y = {vim.lsp.buf.type_definition, "Go to type def"},
          d = {vim.lsp.buf.definition, "Go to def"},
          n = {vim.lsp.buf.rename, "Rename"},
          r = {vim.lsp.buf.references, "References in loc list"},
          R = {':Telescope lsp_references<CR>', "References in Telescope"},
      }
    },
    { prefix = "<leader>" }
)
