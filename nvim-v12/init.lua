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

-- [Theme]
vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",
})

vim.cmd.colorscheme "kanagawa"

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

