local M             = {}
local get_icon      = require("utils").get_icon
local telescope     = require("telescope")
local tscopebuiltin = require("telescope.builtin")
local Terminal      = require('toggleterm.terminal').Terminal
local lazygit       = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local gitsigns      = require("gitsigns")
local lazy          = require("lazy")
-- local resession     = require("resession")
local sessions      = require("mini.sessions")
local neogit        = require("neogit")

local gitpush       = function()
    local spinner = require("utils.spinner")
    local title = "Git"
    spinner.start(1, "Pushing", title)

    -- taken from here
    -- https://www.reddit.com/r/neovim/comments/pa4yle/comment/ha2h1nh/?utm_source=share&utm_medium=web2x&context=3
    local job = require('plenary.job')
    job:new({
        command = 'git',
        args = { 'push' },
        on_exit = function(j, exit_code)
            local res = table.concat(j:result(), "\n")

            if exit_code ~= 0 then
                spinner.stop(1, "Failed to push", title)
                vim.notify(res, "error", { title = title })
            else
                spinner.stop(1, "Pushed", title)
                vim.notify(res, "info")
            end
        end,
    }):start()
end

local gitpull       = function()
    local spinner = require("utils.spinner")
    spinner.start(1, "Pulling", "Git")

    local job = require('plenary.job')
    job:new({
        command = 'git',
        args = { 'pull' },
        on_exit = function(j, exit_code)
            local res = table.concat(j:result(), "\n")

            if exit_code ~= 0 then
                spinner.stop(1, "Failed to pull")
                vim.notify(res, "error", { title = "Git" })
            else
                spinner.stop(1, "Pulled")
            end
        end,
    }):start()
end

M.setup             = function()
    local whichkey = require('which-key')

    whichkey.register({
        -- find with telescope
        ["ff"]         = { function() tscopebuiltin.find_files() end, "Find files" },
        ["<leader>f"]  = { name = "Find", desc = get_icon("Search") .. "Find" },

        -- Git stuff
        ["<leader>g"]  = { name = "Git", desc = get_icon("Git") .. "Git" },
        ["<leader>gb"] = { function() tscopebuiltin.git_branches { use_file_path = true } end, "Git branches" },
        -- c = { "<cmd>Git commit<CR>", "commit" },
        ["<leader>gc"] = { function() neogit.open({ "commit" }) end, "Commit" },
        ["<leader>gC"] = {
            function() tscopebuiltin.git_commits { use_file_path = true } end,
            "Git commits",
        },
        ["<leader>gt"] = {
            function() tscopebuiltin.git_status { use_file_path = true } end,
            "Git status"
        },
        ["<leader>go"] = { "<cmd>GBrowse<CR>", "Open github (browser)" },
        ["<leader>gg"] = { function() neogit.open() end, "neogit" },
        ["<leader>ga"] = { "<cmd>Git add -A|Git commit<CR>", "Add & Commit" },
        ["<leader>gl"] = { gitpull, "Pull" },
        ["<leader>gp"] = { gitpush, "Push" },
        -- nmap({ "<leader>gG", function() lazygit:toggle() end, { desc = "Lazygit" } })
        -- ["<leader>g"]     = { name = "Git", desc = get_icon("Git") .. "Git" },
        -- ["<leader>gb"]    = { function() tscopebuiltin.git_branches { use_file_path = true } end, "Git branches" },
        -- -- c = { "<cmd>Git commit<CR>", "commit" },
        -- ["<leader>gc"]    = { "<cmd>Git commit<CR>", "Commit" },
        -- ["<leader>gC"]    = {
        --     function() tscopebuiltin.git_commits { use_file_path = true } end,
        --     "Git commits",
        -- },
        -- ["<leader>gt"]    = {
        --     function() tscopebuiltin.git_status { use_file_path = true } end,
        --     "Git status"
        -- },
        -- ["<leader>go"]    = { "<cmd>GBrowse<CR>", "Open github (browser)" },
        -- ["<leader>gg"]    = { "<cmd>Git<CR>", "fugitive" },
        -- ["<leader>ga"]    = { "<cmd>Git add -A|Git commit<CR>", "Add & Commit" },
        -- ["<leader>gl"]    = { gitpull, "Pull" },
        -- ["<leader>gp"]    = { gitpush, "Push" },
        -- y = { "<cmd>!git pull --all -p<CR>", "sync" },

        -- Terminal
        ["<leader>r"]  = { name = "Terminal", desc = get_icon("Terminal") .. "Terminal" },
        ["<leader>rf"] = { "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float" },
        ["<leader>rh"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split" },
        ["<leader>rv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split" },

        -- Test
        ["<leader>t"]  = { name = "Test", desc = get_icon("Debugger") .. "Test" },
        ["<leader>te"] = { "<cmd>Other<cr>", "open test file" },
        ["<leader>tv"] = { "<cmd>OtherVSplit<cr>", "open test file in vert split" },

        -- Buffers
        ["<leader>b"]  = { name = "Buffers", desc = get_icon("Tab") .. "Buffers" },

        -- Plugins
        ["<leader>u"]  = { name = "Plugins", desc = get_icon("Package") .. "Plugins" },
        ["<leader>uu"] = { function() lazy.home() end, "Plugins Status" },

        -- Sessions
        ["<leader>s"]  = { name = "Sessions", desc = get_icon("Session") .. "Sessions" },
        ["<leader>ss"] = { function() sessions.select("write") end, "Save" },
        ["<leader>sl"] = { function() sessions.select("read") end, "Load" },
        ["<leader>sd"] = { function() sessions.select("delete") end, "Delete" },

        -- Diagnostics
        ["<leader>d"]  = { name = "Diagnostics", desc = get_icon("Diagnostic") .. "Diagnostics" },
        ["<leader>dd"] = { function() tscopebuiltin.diagnostics() end, "Search diagnostics" },
        ["<leader>dh"] = { function() vim.diagnostic.open_float() end, "Hover diagnostics" },
        ["]d"]         = { function() vim.diagnostic.goto_next() end, "Next diagnostic" },
        ["[d"]         = { function() vim.diagnostic.goto_prev() end, "Prev diagnostic" },
        -- n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next" },
        -- p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev" },
        -- d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostic" },
        -- D = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostic" },

        -- LSP
        ["<leader>l"]  = { name = "LSP", desc = get_icon("ActiveLSP") .. "LSP" },
        ["<leader>ll"] = { "<cmd>LspInfo<CR>", "LSP Info" },
        ["gd"]         = { vim.lsp.buf.goto_definition, "Go to def" },
        ["<leader>lf"] = { vim.lsp.buf.format, "Format" },
        ["<leader>lh"] = { vim.lsp.buf.hover, "Hover" },
        ["<leader>lm"] = { "<cmd>Telescope lsp_implementations show_line=false default_text=!mocks<cr>",
            "Implementation" },
        ["<leader>lr"] = { '<cmd>Telescope lsp_references show_line=false default_text=!_test.go<CR>',
            "Refs in Telescope" },
        ["<leader>lR"] = { vim.lsp.buf.references, "Refs in Telescope" },
        ["<leader>ls"] = {
            function()
                local aerial_avail, _ = pcall(require, "aerial")
                if aerial_avail then
                    telescope.extensions.aerial.aerial()
                else
                    tscopebuiltin.lsp_document_symbols()
                end
            end, "Document symbols" },
        ["<leader>ld"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek def" },
        ["<leader>ly"] = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek type def" },
        ["<leader>ln"] = { "<cmd>Lspsaga rename<CR>", "Rename" },
        ["<leader>lx"] = { "<cmd>Lspsaga finder<CR>", "Finder" },
        ["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", "Code action" },
        ["<leader>li"] = { "<cmd>Lspsaga incoming_calls<CR>", "Incoming calls" },
        ["<leader>lu"] = { "<cmd>Lspsaga outgoing_calls<CR>", "Outgoing calls" },
        ["<leader>lo"] = { "<cmd>AerialToggle<CR>", "Show outline" },
        -- S = { '<cmd>Telescope lsp_workspace_symbols<CR>', "Workspace symbols" },
    })

    whichkey.register(
        {
            -- e = { "<cmd>NvimTreeFindFileToggle<CR>", "File Explorer" },
            e = { function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, "File explorer" },
            w = { "<cmd>w<CR>", "Save" },
        },
        { prefix = "<leader>" }
    )

    whichkey.setup({
        icons = {
            -- group = vim.g.icons_enabled and "" or "+",
            group = "",
            separator = "",
        },
        disable = { filetypes = { "TelescopePrompt" } },
    })
end

return M
