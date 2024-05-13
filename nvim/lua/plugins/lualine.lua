local M = {}
M.setup = function()
    local get_icon = require("utils").get_icon

    local colors = {
        red = '#ca1243',
        grey = '#a0a1a7',
        black = '#383a42',
        white = '#f3f3f3',
        light_green = '#83a598',
        orange = '#fe8019',
        green = '#8ec07c',
        blue = '#7fb4ca',     -- springBlue
        darkblue = '#223249', -- waveBlue
        yellow = '#e0af68',   -- springYellow
        pink = '#d27e99',     -- sakuraPink
    }

    local theme = {
        normal = {
            a = { bg = colors.darkblue },
            b = { bg = colors.darkblue },
            c = { bg = colors.darkblue },
            x = { bg = colors.darkblue },
            y = { bg = colors.darkblue },
            z = { bg = colors.darkblue },
        },
        insert = { a = { bg = colors.darkblue } },
        visual = { a = { bg = colors.darkblue } },
        replace = { a = { bg = colors.darkblue } },
        command = { a = { bg = colors.darkblue } },
    }

    local color_mode = {
        n = colors.blue,
        i = colors.pink,
        v = colors.green,
        V = colors.green,
        c = colors.yellow,
    }
    local mode = {
        'mode',
        color = function()
            return { fg = color_mode[vim.fn.mode()] or colors.white }
        end,
    }

    local bar = {
        function()
            return '▊'
        end,
        color = function()
            return { fg = color_mode[vim.fn.mode()] or colors.white }
        end,
        padding = { left = 0, right = 0 },
        component_separators = {}
    }

    local function modified()
        if vim.bo.modified then
            return '+'
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
            return '-'
        end
        return ''
    end

    local lsp_provider = function()
        local names = {}
        for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        if next(names) == nil then
            return ""
        else
            return "  " .. table.concat(names, " ")
        end
    end

    require('lualine').setup {
        extensions = { 'quickfix', 'lazy', 'mason' },
        tabline = {
            lualine_a = {},
            lualine_b = {
                {
                    'tabs',
                    tabs_color = {
                        active = { fg = colors.white, bg = colors.black },
                        inactive = { fg = colors.grey, bg = colors.black },
                    },
                },
                {
                    'windows',
                    mode = 2,
                    windows_color = {
                        active = { fg = colors.white, bg = colors.black },
                        inactive = { fg = colors.grey, bg = colors.black },
                    },
                },
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        options = {
            -- separators:
            --      
            theme = theme,
            section_separators = { left = "", right = "" },
            globalstatus = true,
            component_separators = { left = "", right = "" }
        },
        sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                bar,
                mode,
                {
                    'branch',
                    color = { fg = colors.grey },
                },
                {
                    'filename',
                    path = 1,
                    symbols = {
                        modified = '●',
                        readonly = get_icon("FileReadOnly"),
                    },
                },
                {
                    'diff',
                    color = { bg = colors.black },
                    separator = { left = "", right = "" },
                },
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
                {
                    'diagnostics',
                    source = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic' },
                    sections = { 'error' },
                    diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
                    separator = { left = "", right = "" },
                },
                {
                    'diagnostics',
                    source = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic' },
                    sections = { 'warn' },
                    diagnostics_color = { warn = { bg = colors.yellow, fg = colors.white } },
                    separator = { left = "", right = "" },
                },
                {
                    'diagnostics',
                    source = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic' },
                    sections = { 'info', 'hint' },
                    diagnostics_color = {
                        hint = { bg = colors.blue, fg = colors.white },
                        info = { bg = colors.grey, fg = colors.white },
                    },
                    separator = { left = "", right = "" },
                },

            },
            lualine_x = {},
            lualine_y = {
                'filetype',
                lsp_provider,
            },
            lualine_z = {
                '%l/%L:%c',
                bar,
            },
        },
    }
end
return M
