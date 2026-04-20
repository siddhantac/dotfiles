# Neovim Configuration

<!--toc:start-->
- [Neovim Configuration](#neovim-configuration)
  - [How It Works](#how-it-works)
  - [Prerequisites](#prerequisites)
  - [Bootstrap](#bootstrap)
  - [Auto-Tangle on Save](#auto-tangle-on-save)
  - [Editor Options](#editor-options)
  - [Utilities](#utilities)
  - [Which-key](#which-key)
  - [Mappings / Keybinds](#mappings-keybinds)
  - [Theme](#theme)
    - [Status line](#status-line)
  - [Navigate between tmux and nvim](#navigate-between-tmux-and-nvim)
  - [Overseer](#overseer)
  - [Notifications](#notifications)
  - [LSP](#lsp)
    - [Markdown renderer](#markdown-renderer)
    - [Diagnostics](#diagnostics)
    - [Treesitter](#treesitter)
  - [Telescope](#telescope)
    - [Telescope keymaps](#telescope-keymaps)
  - [Git](#git)
    - [Git keymaps](#git-keymaps)
  - [Custom autocommands](#custom-autocommands)
  - [Mini plugins](#mini-plugins)
  - [Debug](#debug)
<!--toc:end-->

This configuration is a **literate document**: the code lives here in `README.md`
as fenced code blocks, and a script called `tangle.lua` extracts those blocks in
order to produce `init.lua`, the file Neovim actually loads.

The idea is borrowed from the Emacs community (org-babel). Every plugin and
setting has its explanation right next to the code, so the config stays readable
even months later. GitHub renders this file for free. Never edit `init.lua`
directly; this file is the single source of truth.

## How It Works

Every ` ```lua ` fenced block in this file gets extracted into `init.lua` in
the order it appears. Blocks marked ` ```lua notangle ` are skipped: they
display with syntax highlighting but are not included in the output. Use them
for example code or temporarily disabled snippets.

Blocks marked ` ```sh install ` are extracted into `dependencies.sh`, a shell
script you run once on a fresh machine to install all system dependencies.
Each install block lives next to the section that needs it, so the reason for
every dependency is always documented in context.

## Prerequisites

Install Neovim >= 0.11 manually. Ubuntu's apt version is too old; use the
[official release](https://github.com/neovim/neovim/releases/latest).
Everything else is handled by `dependencies.sh` after the first tangle.

```sh install
# Core tools: git (lazy.nvim bootstrap), curl, gcc + make (parser/plugin builds)
PKG git curl gcc make
```

## Bootstrap

Install Neovim, clone this repo, then run three commands:

```sh
git clone <your-repo-url> ~/.config/nvim
nvim -l ~/.config/nvim/tangle.lua       # generates init.lua + dependencies.sh
bash ~/.config/nvim/dependencies.sh     # installs ripgrep, fd, clangd, pylsp...
nvim                                    # plugins auto-install on first launch
```

Saving this file inside Neovim re-tangles automatically. If you add a new
dependency later, add an `sh install` block next to the relevant section and
run `bash dependencies.sh` again. Already-installed packages are skipped.

After that, saving this file inside Neovim auto-tangles on every write.

---

## Auto-Tangle on Save

When you save `README.md` inside Neovim this autocmd fires, runs `tangle.lua`,
syntax-checks the output, and replaces `init.lua` only if the check passes.
On a syntax error you get a notification and the live `init.lua` is left
untouched.

The `fnamemodify` comparison normalises the path so the autocmd fires
regardless of how the buffer was opened (relative path, symlink, etc.).

```lua
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
```

## Editor Options

- `updatetime` - swap file written to disk after this time (affects CursorHold time (to highlight a text object))
- `relativenumber` - shows relative line numbers in gutter
- `number` - shows the actual line number of the cursor
- `cursorline` - highlights the line the cursor is on, and also adds color to the line number
- `scrolloff` - number of lines to keep above and below the cursor
- `autoread` - automatically read a file that has been changed on disk
- `timeoutlen` - controls how long to wait before showing which-key menu
- `expandtab` - use spaces instead of tabs
- `listchars` - characters to use for list mode (vim.opt.list must be true for this to work)
- `ignorecase` - makes searches case-insensitive by default
- `smartcase` - overrides `ignorecase` when the search pattern contains any uppercase letter, making it case-sensitive again

```lua
vim.g.mapleader = ' '
vim.g.loaded_gzip = 1

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
vim.opt.listchars = "tab:  ,trail:·"
vim.opt.expandtab = true
vim.opt.tabstop = 4     -- show existing tab with 4 spaces width
vim.opt.shiftwidth = 4  -- when indenting with '>', use 4 spaces width
vim.opt.softtabstop = 4 -- control <tab> and <bs> keys to match tabstop
vim.opt.ignorecase = true
vim.opt.smartcase = true
```

- Completion popup behaviour. `menuone` shows the menu even for a single match. `noselect` means
  nothing is pre-selected — you must explicitly confirm with `<C-y>`. `popup` shows a preview window
  alongside the popup. `fuzzy` enables fuzzy matching on completion items (0.11+).

```lua
vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }
vim.opt.pumborder = "rounded"   -- border on the completion popup (0.12+)
```

- Folding: use treesitter as the fold provider by default. `foldlevelstart = 99` means all folds are
  open when a buffer is first entered. The LSP upgrade (see Custom autocommands) will replace this
  with a more semantically accurate provider once an LSP attaches.

```lua
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99
```

- disable unused native plugins

```lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_spellfile = 1
vim.g.loaded_matchit = 1

```

## Utilities

- `nmap` - a convenience wrapper to set keymaps in normal mode. It intelligently uses which-key if available, and falls back to native nvim mapping otherwise.
- `icons` - loads the nerd font icons

```lua
local nmap = function(tbl)
    local ok, wk = pcall(require, "which-key")
    if ok and #tbl == 3 then
        wk.add({ tbl[1], tbl[2], desc = tbl[3].desc, mode = "n", icon = tbl[3].icon })
    else
        vim.keymap.set('n', tbl[1], tbl[2], tbl[4])
    end
end

local vmap = function(tbl)
    vim.keymap.set('v', tbl[1], tbl[2], tbl[3])
end

local icons = require("nerd_font")
```

## Which-key

Which-key must be defined before mappings so that mappings can use which-key.

```lua
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
```

## Mappings / Keybinds

- Quick write

```lua
nmap({"<leader>w", ":w<CR>"})
```

- Paste without overwriting register

```lua
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste (no overwrite)" })
```

- Easier resize

```lua
nmap({ '<s-LEFT>', ':vertical resize +5 <CR>' })
nmap({ '<s-RIGHT>', ':vertical resize -5 <CR>' })
nmap({ '<s-UP>', ':resize +5 <CR>' })
nmap({ '<s-DOWN>', ':resize -5 <CR>' })
```

- Keep cursor centered when moving by pages.

```lua
nmap({ '<C-f>', '<C-f>zt' })
nmap({ '<C-d>', '<C-d>zz' })
nmap({ 'n', 'nzzzv' })
```

- Easy restart

```lua
nmap({ '<leader>R', '<cmd>restart<CR>'})
```

- Buffer management

```lua
nmap({ "]b", "<cmd>bnext<CR>", { desc = "Next buffer" } })
nmap({ "[b", "<cmd>bprev<CR>", { desc = "Prev buffer" } })
nmap({ "<leader>bb", "<cmd>b#<CR>", { desc = "Swap" } })
nmap({ "<leader>bc", "<cmd>close<CR>", { desc = "Close" } })
nmap({ "<leader>bD", "<cmd>bufdo bd<CR>", { desc = "Delete all" } })
nmap({ "<leader>bm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize (toggle)" } })
```

- Quickfix

```lua
nmap({ "]q", ":cnext<CR>zz", { desc = "Next quickfix item" } })
nmap({ "[q", ":cprev<CR>zz", { desc = "Prev quickfix item" } })
nmap({ "<C-c>", ":cclose<CR>" })
```

## Theme

```lua
vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",
})

vim.cmd.colorscheme "kanagawa"
```

### Status line

- Lualine

```lua
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
```

## Navigate between tmux and nvim

Helps to navigate between nvim and tmux splits natively as if they are all one.

```lua
vim.pack.add({
    "https://github.com/christoomey/vim-tmux-navigator",
})
```

## Overseer

```lua
vim.pack.add({
    'https://github.com/stevearc/overseer.nvim',
})

nmap({ "<leader>oo", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer", icon = icons["Toggle"] } })
nmap({ "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run Overseer" } })
```

## Notifications

```lua
vim.pack.add({
    "https://github.com/rcarriga/nvim-notify",
})

require("notify").setup({
    stages = "fade",
    top_down = true,
    background_colour = "#000000",
})
vim.notify = require("notify")
```


## LSP

```lua
vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/aerial.nvim', 
    'https://github.com/glepnir/lspsaga.nvim',
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

require("lspsaga").setup({
    lightbulb = {
        sign = false,
    },
    -- keybinds for navigation in lspsaga window
    move_in_saga = { prev = "<C-k>", next = "<C-j>" },
    -- use enter to open file with finder
    finder = {
        keys = {
            open = "<CR>",
            vsplit = '<C-v>',
            split = '<C-h>',
            tabe = '<C-t>',
            quit = { 'q', '<ESC>' },
            close_in_preview = "<Esc>",
        }
    },
    -- use enter to open file with definition preview
    definition = {
        keys = {
            edit = "<CR>",
            vsplit = '<C-v>',
            split = '<C-h>',
            tabe = '<C-t>',
            quit = 'q',
            close = "<Esc>",
        },
    },

    rename = {
        in_select = false,
        auto_save = true,
    },
})
```

- Config for Lua LSP. Make it recognize the vim global.

```lua
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
```

- Enable the language servers I need

```lua
vim.lsp.enable('gopls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('yamlls')
vim.lsp.enable('pyright')
vim.lsp.enable('ts_ls')
vim.lsp.enable('terraformls')
vim.lsp.enable('jsonls')
vim.lsp.enable('marksman')
```

- LSP keymaps

```lua
nmap({ "gd", vim.lsp.buf.definition, { desc = "Go to def" } })
nmap({ "<leader>lf", vim.lsp.buf.format, { desc = "Format" } })
nmap({ "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" } })
nmap({ "<leader>ll", "<cmd>LspInfo<CR>", { desc = "LSP Info" } })
nmap({ "<leader>lR", vim.lsp.buf.references, { desc = "Refs (quickfix)" } })

nmap({ "<leader>ld", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek def" } })
nmap({ "<leader>ly", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek type def" } })
nmap({ "<leader>ln", "<cmd>Lspsaga rename<CR>", { desc = "Rename" } })
nmap({ "<leader>lx", "<cmd>Lspsaga finder<CR>", { desc = "Finder" } })
nmap({ "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "Code action" } })
nmap({ "<leader>li", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Incoming calls" } })
nmap({ "<leader>lu", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Outgoing calls" } })
```

### Completion

Neovim 0.12 ships a built-in LSP completion engine — no nvim-cmp or LuaSnip required. Completion
is enabled per-buffer inside `LspAttach`, gated on whether the server advertises
`textDocument/completion` support. `autotrigger = true` fires completion automatically as you type
(equivalent to cmp's `CompleteChanged` behaviour). Confirm a selection with `<C-y>`.

Built-in snippets (`vim.snippet`) are supported natively — the LSP client expands snippet items
automatically when confirmed.

```lua
vim.api.nvim_create_autocmd('LspAttach', {
    desc = "Enable native LSP completion",
    group = vim.api.nvim_create_augroup('lsp_completion', { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
```

### Markdown renderer

```lua
vim.pack.add({
    'https://github.com/MeanderingProgrammer/render-markdown.nvim'
})
```

 ### Diagnostics

```lua
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
```

### Treesitter

In nvim v0.12, treesitter now requires `tree-sitter-cli` as an external tool.

```sh install
PKG tree-sitter-cli
```

Setup autocmd to run `:TSUpdate` on `PackChanged`

```lua
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' then
      vim.schedule(function()
        vim.cmd('TSUpdate')
      end)
    end
  end,
})
```

Finally install treesitter.

```lua
vim.pack.add({
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    version = 'main',
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
  },
})

nmap({'[x', function() require('treesitter-context').go_to_context() end })

local ensureInstalled = { 
    "bash",
    "csv",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "json",
    "ledger",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
}
local alreadyInstalled = require('nvim-treesitter.config').get_installed()
local toInstall = vim.iter(ensureInstalled)
  :filter(function(p) return not vim.tbl_contains(alreadyInstalled, p) end)
  :totable()
require('nvim-treesitter').install(toInstall)
```

Enable highlighting (replaces highlight = { enable = true })

```lua
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
```

## Telescope

Telescope is a pretty selector UI with some convenience functions built-in.

`telescope-fzf-native.nvim` requires `make` to be run after install or update. So an autocmd is
registered before the vim.pack.add command. 

```lua
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind  -- 'install' or 'update'

    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.notify("installing fzf-native")
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
```

### Telescope keymaps

```lua
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
```

## Git

- Neogit is the shizz. `diffview` is an optional dependency.
- gitlinker provides a way to copy a git url to the clipboard

```lua
vim.pack.add({
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/ruifm/gitlinker.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
})
```

### Git keymaps

- Git signs 

```lua
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
```

- Neogit

```lua
local ok, neogit = pcall(require, "neogit")
if not ok then
    vim.notify("failed to load neogit", "warn")
    return
end

nmap({ "<leader>gg", function() neogit.open({}) end, { desc = "neogit" } })

nmap({ "<leader>xx", '<cmd>DiffviewOpen<cr>', { desc = "Open diffview" } })
nmap({ "<leader>xr", '<cmd>DiffviewRefresh<cr>', { desc = "Refresh diffview" } })
nmap({ "<leader>xX", '<cmd>DiffviewClose<cr>', { desc = "Close diffview" } })
```

- gitlinker

```lua
local ok, gitlinker = pcall(require, "gitlinker")
if not ok then
    vim.notify("failed to load gitlinker", "warn")
    return
end
local actions = gitlinker.actions

nmap({ "<leader>gy", '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>', { desc = "Copy Github url" } })
vmap({ "<leader>gy", '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>', { desc = "Copy Github url" } })
```

## Custom autocommands


**Autosave** on focus lost, but only when there is something to save, always saving makes build watchers crazy.
```lua
vim.api.nvim_create_autocmd(
    "FocusLost",
    { pattern = "*", command = "silent! wa" }
)
```

**Highlight on yank**

```lua
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})
```

**Show relative numbers only for active buffer**

Also don't run the autocmd for telescopeprompt, prevents the annoying 0 from showing next to the cursor in the prompt.

```lua
local linenumtoggle = vim.api.nvim_create_augroup("LineNumberToggle", { clear = true })
vim.api.nvim_create_autocmd("BufLeave",
    {
        pattern = '*', -- '* if index(ignoreFiletype, &ft) < 0',
        callback = function()
            vim.wo.relativenumber = false
        end,
        group = linenumtoggle,
    }
)

vim.api.nvim_create_autocmd("BufEnter",
    {
        pattern = '*', -- * if index(ignoreFiletype, &ft) < 0',
        callback = function()
            vim.wo.relativenumber = true
        end,
        group = linenumtoggle,
    }
)
```

**Organise imports**

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = '*.go',
    callback = function(args)
        vim.lsp.buf.format()
        vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
    end,
})
```

**Upgrade fold provider to LSP when supported**

Treesitter folds are available immediately, but LSP folds are more semantically accurate. When an
LSP attaches that supports `foldingRange`, this autocmd upgrades the fold provider for that window
to `vim.lsp.foldexpr()`. The `vim.wo[win][0]` scoping sets it window-local AND buffer-local, which
is the correct way to do it in Neovim 0.10+.

```lua
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Upgrade fold provider to LSP when supported",
    callback = function(ctx)
        local client = vim.lsp.get_client_by_id(ctx.data.client_id)
        if client and client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})
```

**Report LSP setup progress**

- ref: https://neovim.io/doc/user/lsp.html#LspProgress
- ref: https://github.com/linrongbin16/lsp-progress.nvim/blob/d5f4d28efe75ce636bfbe271eb45f39689765aab/lua/lsp-progress.lua#L170

```lua
local lsp_progress_notification = function(ev)
    local client_id = ev.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local value = ev.data.params.value
    local token = ev.data.params.token

    if not value or not value.title then
        return
    end

    local message = value.message or ""
    local msg = client.name .. " - " .. value.title .. "\n  " .. message
    local title = "LSP"

    return { token = token, msg = msg, title = title }
end

local lsp_progress = vim.api.nvim_create_augroup("lsp_progress", { clear = true })

vim.api.nvim_create_autocmd('LspProgress', {
    pattern = 'begin',
    group = lsp_progress,
    callback = function(ev)
        local spinner = require("spinner")
        local notif = lsp_progress_notification(ev)

        if notif == nil then
            return
        end
        spinner.start(notif.token, notif.msg, notif.title)
    end
})

vim.api.nvim_create_autocmd("LspProgress", {
    pattern = 'end',
    group = lsp_progress,
    callback = function(ev)
        local spinner = require("spinner")
        local notif = lsp_progress_notification(ev)
        spinner.stop(notif.token, notif.msg, notif.title)
    end
})
```

## Mini plugins

>[!note] 2026-04-13: I am considering moving to Oil.nvim and combining with Neotree. 

```lua
vim.pack.add({
    'https://github.com/mrquantumcodes/configpulse',
    "https://github.com/echasnovski/mini.nvim",
})

require('mini.files').setup()
    local new_section = function(name, action, section)
        return { name = name, action = action, section = section }
    end

    local starter = require("mini.starter")

    local time_since = function()
        local cp = require('configpulse').get_time()
        return cp['days'] .. "d " .. cp['hours'] .. "h " .. cp['minutes'] .. "m since last change"
    end

    local logo = [[
                                                      
               ████ ██████           █████      ██
              ███████████             █████ 
              █████████ ███████████████████ ███   ███████████
             █████████  ███    █████████████ █████ ██████████████
            █████████ ██████████ █████████ █████ █████ ████ █████
          ███████████ ███    ███ █████████ █████ █████ ████ █████
         ██████  █████████████████████ ████ █████ █████ ████ ██████
      ]]

    local logo2 =
    "                                                    \n ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ \n ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ \n ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ \n ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ \n ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ \n ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ \n "

    starter.setup({
        evaluate_single = true,
        -- header = "Welcome back, Sid",
        header = logo .. "   Welcome back, Sid",
        items = {
            new_section("Find file", "Telescope find_files", "Telescope"),
            new_section("Recent files", "Telescope oldfiles", "Telescope"),
            new_section("Grep text", "Telescope live_grep", "Telescope"),
            new_section("New file", "ene | startinsert", "Built-in"),
            new_section("Quit", "qa", "Built-in"),
        },
        footer = time_since,
        -- left-aligned is good.
        -- if you want to try center align, then the logic for sessions
        -- has to be extracted from mini.starter source code and pasted here.
        --
        -- content_hooks = {
        --     starter.gen_hook.adding_bullet(pad .. "░ ", false),
        --     starter.gen_hook.aligning("center", "center"),
        -- },
    })
```


## Debug

```lua
vim.notify("Using new config")
```
