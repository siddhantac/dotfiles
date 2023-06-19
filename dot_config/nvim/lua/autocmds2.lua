-- local au = require('au')
-- for more examples, see:
--    https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da

-- au.group('PackerGroup', {
--     { 'BufWritePost', 'plugins.lua', 'source <afile> | PackerCompile' },
-- })

local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- Autosave only when there is something to save,
-- always saving makes build watchers crazy
api.nvim_create_autocmd(
    "FocusLost",
    { pattern = "*", command = "silent! wa" }
)

-- Show relative numbers only for the active buffer
local linenumtoggle = api.nvim_create_augroup("LineNumberToggle", { clear = true })
api.nvim_create_autocmd("BufLeave",
    {
        pattern = '*',
        callback = function()
            vim.cmd('set norelativenumber')
        end,
        group = linenumtoggle,
    }
)
api.nvim_create_autocmd("BufEnter",
    {
        pattern = '*',
        callback = function()
            vim.cmd('set relativenumber')
        end,
        group = linenumtoggle,
    }
)

-- Auto highlight
local autoHighlight = api.nvim_create_augroup("auto_highlight", { clear = true })
api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = vim.lsp.buf.document_highlight,
    group = autoHighlight,
})
api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = vim.lsp.buf.clear_references,
    group = autoHighlight,
})

-- Organise imports
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

-- NOT WORKING
-- session (need to install mini)
-- au.VimLeave = { '*', MiniSessionWrite}

-- Format code before bufwrite
api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.json" },
    callback = function()
       vim.lsp.buf.format()
    end,
})
