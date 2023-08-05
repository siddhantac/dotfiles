return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    { 'nvim-tree/nvim-web-devicons' },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                stages = "static",
            })
        end,
    },

    {
        'szw/vim-maximizer',
        cmd = { "MaximizerToggle" },
    },

    {
        'nvim-lualine/lualine.nvim',
        name = "lualine.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
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
            }

            local empty = require('lualine.component'):extend()
            function empty:draw(default_highlight)
                self.status = ''
                self.applied_separator = ''
                self:apply_highlights(default_highlight)
                self:apply_section_separators()
                return self.status
            end

            -- Put proper separators and gaps between components in sections
            local function process_sections(sections)
                for name, section in pairs(sections) do
                    local left = name:sub(9, 10) < 'x'
                    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
                        table.insert(section, pos * 2, { empty, color = { fg = colors.grey, bg = colors.grey } })
                    end
                    for id, comp in ipairs(section) do
                        if type(comp) ~= 'table' then
                            comp = { comp }
                            section[id] = comp
                        end
                        comp.separator = left and { right = '' } or { left = '' }
                    end
                end
                return sections
            end

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
                    component_separators = '',
                    section_separators = { left = '', right = '' },
                },
                sections = process_sections {
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
                    lualine_y = { search_result, 'filetype' },
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
    },
}
