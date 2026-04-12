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
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.timeoutlen = 500   
vim.opt.syntax = "on"
vim.opt.list = true
vim.opt.listchars = "trail:·"
vim.opt.expandtab = true
vim.opt.tabstop = 4     -- show existing tab with 4 spaces width
vim.opt.shiftwidth = 4  -- when indenting with '>', use 4 spaces width
vim.opt.softtabstop = 4 -- control <tab> and <bs> keys to match tabstop

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

-- [Mappings / Keybinds]
nmap({ "]b", "<cmd>bnext<CR>", { desc = "Next buffer" } })
nmap({ "[b", "<cmd>bprev<CR>", { desc = "Prev buffer" } })
nmap({ "<leader>bb", "<cmd>b#<CR>", { desc = "Swap" } })
nmap({ "<leader>bc", "<cmd>close<CR>", { desc = "Close" } })
nmap({ "<leader>bD", "<cmd>bufdo bd<CR>", { desc = "Delete all" } })
nmap({ "<leader>bm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize (toggle)" } })

-- [Mappings / Keybinds]
nmap({ "]q", ":cnext<CR>zz", { desc = "Next quickfix item" } })
nmap({ "[q", ":cprev<CR>zz", { desc = "Prev quickfix item" } })
nmap({ "<C-c>", ":cclose<CR>" })

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
    'https://github.com/stevearc/aerial.nvim', 
})

require("aerial").setup({
    attach_mode = "global",
    backends = { "lsp", "treesitter", "markdown", "man" },
    -- disable_max_lines = vim.g.max_file.lines,
    -- disable_max_size = vim.g.max_file.size,
    layout = { min_width = 28 },
    show_guides = true,
    filter_kind = false,
    guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
    },
})

-- [LSP]
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- [LSP]
vim.lsp.enable('gopls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('yamlls')
vim.lsp.enable('pyright')
vim.lsp.enable('ts_ls')
vim.lsp.enable('terraformls')
vim.lsp.enable('jsonls')
vim.lsp.enable('marksman')

-- [LSP]
nmap({ "<leader>lf", vim.lsp.buf.format, { desc = "Format" } })
nmap({ "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" } })
nmap({ "<leader>ll", "<cmd>LspInfo<CR>", { desc = "LSP Info" } })
nmap({ "<leader>lR", vim.lsp.buf.references, { desc = "Refs (quickfix)" } })

-- [Markdown renderer]
vim.pack.add({
    'https://github.com/MeanderingProgrammer/render-markdown.nvim'
})

-- [Markdown renderer]
local sev = vim.diagnostic.severity

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [sev.ERROR] = icons["DiagnosticError"],
      [sev.WARN]  = icons["DiagnosticWarn"],
      [sev.INFO]  = icons["DiagnosticInfo"],
      [sev.HINT]  = icons["DiagnosticHint"],
    },
  },
})

-- [Telescope]
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind  -- 'install' or 'update'

    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
})

local actions  = require "telescope.actions"

require('telescope').setup({
        defaults = {
            prompt_prefix = icons["Search"],
            selection_caret = icons["Selected"],
            path_display = { "filename_first" },
            sorting_strategy = "ascending",
            preview = {
                filesize_limit = 0.1, -- MB
            },
            layout_config = {
                horizontal = { prompt_position = "top", preview_width = 0.55 },
                vertical = { mirror = false },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            mappings = {
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-S-j>"] = actions.preview_scrolling_down,
                    ["<C-S-k>"] = actions.preview_scrolling_up,
                    ['<c-d>'] = require('telescope.actions').delete_buffer,
                    -- ["<esc>"] = require('telescope.actions').close, -- replaced this with 'q' in normal mode
                },
                n = { q = actions.close },
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {}
            },
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        }
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

-- [Telescope keymaps]
local ok, telescope = pcall(require, "telescope")
if not ok then
    vim.notify("failed to load telescope", "error")
end

local ok, tscopebuiltin = pcall(require, "telescope.builtin")
if not ok then
    vim.notify("failed to load telescope builtin", "error")
end

local ok, tscopeutils = pcall(require, "telescope.utils")
if not ok then
    vim.notify("failed to load telescope builtin", "error")
end

nmap({ "<leader>bf", "<cmd>Telescope buffers<CR>", { desc = "Find" } })

nmap({ "<leader>ff", function() tscopebuiltin.find_files({ default_text = "!mocks " }) end, { desc = "Files" } })
nmap({ "<leader>f<CR>", function() tscopebuiltin.resume() end, { desc = "Resume previous search" } })
nmap({ "<leader>f'", function() tscopebuiltin.marks() end, { desc = "Marks" } })
nmap({ "<leader>f/", function() tscopebuiltin.current_buffer_fuzzy_find()() end,
    { desc = "Find words in current buffer" } })
nmap({ "<leader>fb", function() tscopebuiltin.buffers() end, { desc = "Buffers" } })
nmap({ "<leader>fc", function() tscopebuiltin.grep_string() end, { desc = "Word under cursor" } })
nmap({ "<leader>fC", function() tscopebuiltin.commands() end, { desc = "Commands" } })
nmap({ "<leader>fF", function() tscopebuiltin.find_files({ hidden = true, no_ignore = true }) end,
    { desc = "All files" } })
nmap({ "<leader>fd", function() tscopebuiltin.find_files({ cwd = tscopeutils.buffer_dir() }) end,
    { desc = "Find files in buffer dir" } }) -- find files in dir of the current file
nmap({ "<leader>fh", function() tscopebuiltin.help_tags() end, { desc = "Help" } })
nmap({ "<leader>fk", function() tscopebuiltin.keymaps() end, { desc = "Keymaps" } })
nmap({ "<leader>fm", function() tscopebuiltin.man_pages() end, { desc = "Man" } })
nmap({ "<leader>fn", function() telescope.extensions.notify.notify() end, { desc = "Notifications" } })
nmap({ "<leader>fo", function() tscopebuiltin.oldfiles() end, { desc = "History" } })
nmap({ "<leader>fr", function() tscopebuiltin.registers() end, { desc = "Registers" } })
nmap({ "<leader>fs", function() tscopebuiltin.colorscheme { enable_preview = true } end, { desc = "Themes" } })
nmap({ "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todos" } })
nmap({ "<leader>fw", function() tscopebuiltin.live_grep() end, { desc = "Words" } })
nmap({ "<leader>fW",
    function()
        tscopebuiltin.live_grep {
            additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
        }
    end,
    { desc = "Words in all files" }
})

nmap({ "<leader>dd", function() tscopebuiltin.diagnostics() end, { desc = "Search diagnostics" } })

nmap({ "<leader>gb", function() tscopebuiltin.git_branches { use_file_path = true } end, { desc = "Branches" } })
nmap({ "<leader>gC", function() tscopebuiltin.git_commits { use_file_path = true } end, { desc = "Commits", } })

nmap({ "<leader>lm", "<cmd>Telescope lsp_implementations show_line=false default_text=!mocks<cr>",
    { desc = "Implementation" } })
nmap({ "<leader>lr", '<cmd>Telescope lsp_references show_line=false default_text=!_test.go<CR>',
    { desc = "Refs" } })

nmap({
    "<leader>ls",
    function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
            telescope.extensions.aerial.aerial()
        else
            tscopebuiltin.lsp_document_symbols()
        end
    end,
    { desc = "Symbols" },
})
-- S = { '<cmd>Telescope lsp_workspace_symbols<CR>', "Workspace symbols" },

nmap({ "<leader>lo", "<cmd>AerialToggle<CR>", { desc = "Show outline", icon = icons["Package"]} })
nmap({ "<leader>j", function() tscopebuiltin.jumplist { show_line = false } end, { desc = "Jumplist", icon = icons["Jump"]} })

-- [Git]
vim.pack.add({
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/ruifm/gitlinker.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
})

-- [Git signs keymaps]
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    vim.notify("failed to load gitsigns", "error")
    return
end

nmap({ "]g", function() gitsigns.next_hunk() end, { desc = "Next Git hunk" } })
nmap({ "[g", function() gitsigns.prev_hunk() end, { desc = "Previous Git hunk" } })
-- ["<leader>gl"] = { function() gitsigns.blame_line() end, "View Git blame" },
-- ["<leader>gL"] = { function() gitsigns.blame_line { full = true } end, "View full Git blame" },
nmap({ "<leader>gh", function() gitsigns.preview_hunk() end, { desc = "Preview Git hunk" } })
-- ["<leader>gh"] = { function() gitsigns.reset_hunk() end, "Reset Git hunk" },
-- ["<leader>gr"] = { function() gitsigns.reset_buffer() end, "Reset Git buffer" },
nmap({ "<leader>gs", function() gitsigns.stage_hunk() end, { desc = "Stage Git hunk" } })
nmap({ "<leader>gS", function() gitsigns.stage_buffer() end, { desc = "Stage Git buffer" } })
nmap({ "<leader>gu", function() gitsigns.undo_stage_hunk() end, { desc = "Unstage Git hunk" } })
nmap({ "<leader>gd", function() gitsigns.diffthis() end, { desc = "View Git diff" } })

