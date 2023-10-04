local M = {}
M.setup = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
    }

    -- 2023-08-02: disabled in favour of https://github.com/folke/noice.nvim
    --              it was throwing an error.
    --
    -- Use nvim-notify to display lsp messages
    -- vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    --   local client = vim.lsp.get_client_by_id(ctx.client_id)
    --   local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
    --   notify({ result.message }, lvl, {
    --     title = 'LSP | ' .. client.name,
    --     timeout = 10000,
    --     keep = function()
    --       return lvl == 'ERROR' or lvl == 'WARN'
    --     end,
    --   })
    -- end
end

return M
