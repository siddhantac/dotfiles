local M             = {}
local get_icon      = require("utils").get_icon
local telescope     = require("telescope")
local tscopebuiltin = require("telescope.builtin")
local Terminal      = require('toggleterm.terminal').Terminal
local lazy          = require("lazy")
-- local resession     = require("resession")
local sessions      = require("mini.sessions")

M.setup             = function()
    local whichkey = require('which-key')

    whichkey.register({
        -- find with telescope
        ["<leader>f"]  = { name = "Find", desc = get_icon("Search") .. "Find" },

        -- Git stuff
        ["<leader>g"]  = { name = "Git", desc = get_icon("Git") .. "Git" },
        ["<leader>go"] = { "<cmd>GBrowse<CR>", "Open github (browser)" },
        ["<leader>ga"] = { "<cmd>Git add -A|Git commit<CR>", "Add & Commit" },

        -- Terminal
        ["<leader>r"]  = { name = "Terminal", desc = get_icon("Terminal") .. "Terminal" },

        -- Test
        ["<leader>t"]  = { name = "Test", desc = get_icon("Debugger") .. "Test" },

        -- Buffers
        ["<leader>b"]  = { name = "Buffers", desc = get_icon("Tab") .. "Buffers" },

        -- Plugins
        ["<leader>u"]  = { name = "Plugins", desc = get_icon("Package") .. "Plugins" },
        ["<leader>uu"] = { function() lazy.home() end, "Plugins Status" },

        -- Sessions
        -- ["<leader>s"]  = { name = "Sessions", desc = get_icon("Session") .. "Sessions" },
        -- ["<leader>ss"] = { function() sessions.select("write") end, "Save" },
        -- ["<leader>sl"] = { function() sessions.select("read") end, "Load" },
        -- ["<leader>sd"] = { function() sessions.select("delete") end, "Delete" },

        -- Diagnostics
        ["<leader>d"]  = { name = "Diagnostics", desc = get_icon("Diagnostic") .. "Diagnostics" },
        -- LSP
        ["<leader>l"]  = { name = "LSP", desc = get_icon("ActiveLSP") .. "LSP" },
        ["<leader>ll"] = { "<cmd>LspInfo<CR>", "LSP Info" },
        ["gd"]         = { vim.lsp.buf.goto_definition, "Go to def" },
        ["<leader>lf"] = { vim.lsp.buf.format, "Format" },
        ["<leader>lh"] = { vim.lsp.buf.hover, "Hover" },
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
