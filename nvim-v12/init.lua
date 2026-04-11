-- Generated from README.md - do not edit directly.

-- [Auto-Tangle on Save]
vim.api.nvim_create_autocmd("BufWritePost", {
    group   = vim.api.nvim_create_augroup("Tangle", { clear = true }),
    pattern = "*",
    callback = function(args)
        local cfg    = vim.fn.stdpath("config")
        local readme = vim.fn.resolve(vim.fn.fnamemodify(cfg .. "/README.md", ":p"))
        if vim.fn.resolve(vim.fn.fnamemodify(args.file, ":p")) == readme then
            dofile(cfg .. "/tangle.lua")
        end
    end,
})

-- [Editor Options]
vim.g.mapleader = ' '
vim.opt.updatetime = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- [Utilities]
local nmap = function(tbl)
    local ok, wk = pcall(require, "which-key")
    if ok and #tbl == 3 then
        wk.add({ tbl[1], tbl[2], desc = tbl[3].desc, mode = "n", icon = tbl[3].icon })
    else
        vim.keymap.set('n', tbl[1], tbl[2], tbl[4])
    end
end

local icons = require("nerd_font")

-- [Which-key]
vim.pack.add({
    "https://github.com/folke/which-key.nvim",
})

local wk = require("which-key")
wk.setup({
        icons = {
            group = "",
            separator = "",
        },
        disable = { filetypes = { "TelescopePrompt" } },
})
wk.add({
    -- Sections
    { "<leader>g",  group = "Git",                                               icon = icons["Git"] },
    { "<leader>r",  group = "Terminal",                                          icon = icons["Terminal"] },
    { "<leader>t",  group = "Test",                                              icon = icons["Debugger"] },
    { "<leader>b",  group = "Buffers",                                           icon = icons["Tab"] },
    { "<leader>d",  group = "Diagnostics",                                       icon = icons["Diagnostic"] },
    { "<leader>l",  group = "LSP",                                               icon = icons["ActiveLSP"] },
    { "<leader>u",  group = "Plugins",                                           icon = icons["Package"] },
    { "<leader>f",  group = "Find (telescope)",                                  icon = icons["Search"] },
    { "<leader>h",  group = "Harpoon",                                           icon = icons["Hook"] },
    { "<leader>u",  group = "UI",                                                icon = icons["GitUntracked"] },
    { "<leader>o",  group = "Overseer",                                          icon = icons["CommandPalette"] },

    { "<leader>ga", "<cmd>Git add -A|Git commit<CR>",                            desc = "Add & Commit",            mode = "n" },
    { "<leader>z",  function() lazy.home() end,                                  desc = "Lazy",                    mode = "n" },
    { "<leader>w",  "<cmd>w<CR>",                                                desc = "Save",                    mode = "n", icon = icons["Save"] },
    { "<leader>e",  function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, desc = "File explorer",           mode = "n", icon = icons["FolderClosed"] },
    { "<leader>x",  group = "Git conflict",                                      icon = icons["Git"] },
})

-- [Mappings / Keybinds]
nmap({"<leader>w", ":w<CR>"})

-- [Mappings / Keybinds]
nmap({ '<s-LEFT>', ':vertical resize +5 <CR>' })
nmap({ '<s-RIGHT>', ':vertical resize -5 <CR>' })
nmap({ '<s-UP>', ':resize +5 <CR>' })
nmap({ '<s-DOWN>', ':resize -5 <CR>' })

-- [Mappings / Keybinds]
nmap({ '<C-f>', '<C-f>zt' })
nmap({ '<C-d>', '<C-d>zz' })
nmap({ 'n', 'nzzzv' })

-- [Mappings / Keybinds]
nmap({ '<leader>R', '<cmd>restart<CR>'})

-- [Theme]
vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",
})

vim.cmd.colorscheme "kanagawa"

-- [Status line]
vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
})

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
        y = { bg = colors.darkblue, fg = colors.white },
        z = { bg = colors.darkblue, fg = colors.white },
    },
    insert = {
        a = { bg = colors.darkblue },
        z = { bg = colors.darkblue, fg = colors.white },
    },
    visual = {
        a = { bg = colors.darkblue },
        z = { bg = colors.darkblue, fg = colors.white },
    },
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

local lsp_provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
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
                    readonly = icons["FileReadOnly"],
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
        lualine_x = { "overseer" },
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

-- [Navigate between tmux and nvim]
vim.pack.add({
    "https://github.com/christoomey/vim-tmux-navigator",
})

-- [Overseer]
vim.pack.add({
    'https://github.com/stevearc/overseer.nvim',
})

nmap({ "<leader>oo", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer", icon = icons["Toggle"] } })
nmap({ "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run Overseer" } })

-- [Notifications]
vim.pack.add({
    "https://github.com/rcarriga/nvim-notify",
})

require("notify").setup({
    stages = "fade",
    top_down = true,
    background_colour = "#000000",
})
vim.notify = require("notify")

-- [LSP]
vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
})

vim.lsp.enable('marksman')

-- [Markdown renderer]
vim.pack.add({
    'https://github.com/MeanderingProgrammer/render-markdown.nvim'
})

-- [Telescope]
vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
})

require('telescope').setup()
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

