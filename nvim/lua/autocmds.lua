local au = require('au')
-- for more examples, see:
--    https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da

-- au.group('PackerGroup', {
--     { 'BufWritePost', 'plugins.lua', 'source <afile> | PackerCompile' },
-- })

au.TextYankPost = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
end

-- Autosave only when there is something to save,
-- always saving makes build watchers crazy
au.FocusLost = { '*', 'silent! wa' }

au.group('NumberToggle', {
    { 
        'BufLeave', 
        '*', 
        function()
            vim.cmd('set norelativenumber') 
        end
    },
    { 
        'BufEnter', 
        '*', 
        function()
            vim.cmd('set relativenumber') 
        end
    },
}) 

au.ColorScheme = { 'nord', 'highlight Normal guibg=#192029'}
au.VimLeave = { '*', '<cmd>SessionManager save_session<cr>'}

-- following example solution from github issue:
--   https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
function goimports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end

au.group('go_lsp', {
    {
        'BufWritePre',
        '*.go',
        vim.lsp.buf.formatting,
    },
    {
        'BufWritePre',
        '*.go',
        function()
            goimports(1000)
        end
    }
})
