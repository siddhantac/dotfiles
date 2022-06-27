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
