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

local relativenumber = api.nvim_create_augroup("NumberToggle", { clear = true })
api.nvim_create_autocmd("BufLeave",
    { pattern = '*',
    callback = function()
            vim.cmd('set norelativenumber')
        end,
        group = relativenumber,
    }
)

api.nvim_create_autocmd('BufEnter',
    {  pattern = '*',
        callback = function()
            vim.cmd('set relativenumber')
        end,
        group = relativenumber,
    }
)
