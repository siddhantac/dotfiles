-- Custom settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true -- maintain undo history between sessions
vim.opt.undodir = os.getenv("HOME") .. '/.lvim/undodir'
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.expandtab = true
vim.opt.tabstop = 4 -- show existing tab with 4 spaces width
vim.opt.shiftwidth = 4 -- when indenting with '>', use 4 spaces width
vim.opt.softtabstop = 4 -- control <tab> and <bs> keys to match tabstop
vim.opt.numberwidth = 5
-- vim.opt.cursorline = true
-- vim.opt.lazyredraw = true
-- vim.opt.syntax = true
-- vim.opt.laststatus = 2
-- vim.opt.hlsearch = true
-- vim.opt.ignorecase = "smartcase"
-- vim.opt.list = true
-- vim.opt.listchars = "tab:\\ ,trail:·"
-- vim.opt.autowrite = true -- save file when :make or :GoBuild is called
-- vim.opt.clipboard = "unnamedplus"

-- Additional Plugins
lvim.plugins = {
    { "shaunsingh/nord.nvim" },
    { "fatih/vim-go" },
}

lvim.autocommands.custom_groups = {
    -- set and unset relative line numbers on entering and leaving a buffer
    { "BufEnter", "*", "set relativenumber" },
    { "BufLeave", "*", "set norelativenumber" },

    -- vim-go test files
    { "Filetype", "go", "command! -bang A call go#alternate#Switch(<bang>0, 'edit')" },
    { "Filetype", "go", "command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')" },
    { "Filetype", "go", "command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')" },

    -- make nord background darker
    { "ColorScheme", "nord", "highligh Normal guibg=#192029" },
}

lvim.colorscheme = "nord"
lvim.builtin.which_key.mappings["<Leader>"] = { ":b#<CR>", "Switch buffer" }
lvim.builtin.which_key.mappings["v"] = { ":Telescope find_files search_dirs=%:p:h<CR>", "Find files in same dir" }

lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save = true

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard" -- "startify"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "go",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- local opts = { noremap = true, silent = true }
-- local on_attach = function(client, bufnr)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- end


-- map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
-- map ,v :vsplit <C-R>=expand("%:p:h") . "/" <CR>
-- map ,h :split <C-R>=expand("%:p:h") . "/" <CR>

-- telescope-config.lua
-- lvim.builtin.telescope.pickers = { find_files = { opts = { search_dirs = "%:p:h" } } }

-- local actions = require "lvim.builtin.telescope".actions.setup.defaults.mappings( e)
-- actions.setup {
--     defaults = {
--         mappings = {
--             i = {
--                 ["<esc>"] = actions.close,
--             },
--         },
-- }
-- },

-- require "user.telescope"
