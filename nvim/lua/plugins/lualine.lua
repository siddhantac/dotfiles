local M = {}
M.setup = function()
    local colors = {
        red = '#ca1243',
        grey = '#a0a1a7',
        black = '#383a42',
        white = '#f3f3f3',
        light_green = '#83a598',
        orange = '#fe8019',
        green = '#8ec07c',
    }

    local theme = {
        normal = {
            a = { fg = colors.black, bg = colors.green }, -- mode
            b = { fg = colors.white, bg = colors.black }, -- branch, filename etc.
            c = { fg = colors.black, bg = colors.grey },  -- the long middle section
            z = { fg = colors.white, bg = colors.black },
        },
        insert = { a = { fg = colors.black, bg = colors.red } },
        visual = { a = { fg = colors.black, bg = colors.orange } },
        replace = { a = { fg = colors.black, bg = colors.green } },
        command = { a = { fg = colors.black, bg = colors.grey } },
    }


    local function search_result()
        if vim.v.hlsearch == 0 then
            return ''
        end
        local last_search = vim.fn.getreg('/')
        if not last_search or last_search == '' then
            return ''
        end
        local searchcount = vim.fn.searchcount { maxcount = 9999 }
        return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    local function modified()
        if vim.bo.modified then
            return '+'
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
            return '-'
        end
        return ''
    end

    require('lualine').setup {
        options = {
            theme = theme,
            component_separators = { left = '', right = '' },
            -- section_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'error' },
                    diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
                },
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'warn' },
                    diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
                },
                { 'filename', file_status = false,        path = 1 },
                { modified,   color = { bg = colors.red } },
                {
                    '%w',
                    cond = function()
                        return vim.wo.previewwindow
                    end,
                },
                {
                    '%r',
                    cond = function()
                        return vim.bo.readonly
                    end,
                },
                {
                    '%q',
                    cond = function()
                        return vim.bo.buftype == 'quickfix'
                    end,
                },
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { 'filetype' },
            lualine_z = { '%l:%c', '%p%%/%L' },
        },
        inactive_sections = {
            lualine_c = { '%f %y %m' },
            lualine_x = {},
        },
    }
end
-- opts = {
--     options = {
--         theme = 'catppuccin',
--         disabled_filetypes = {
--             'aerial',
--         },
--     },
-- },
return M
