local M        = {}
local get_icon = require("utils").get_icon
local lazy     = require("lazy")
-- local sessions = require("mini.sessions")

M.setup        = function()
    local whichkey = require('which-key')

    whichkey.register({
        -- Sections
        ["<leader>g"]  = { name = "Git", desc = get_icon("Git") .. "Git" },
        ["<leader>r"]  = { name = "Terminal", desc = get_icon("Terminal") .. "Terminal" },
        ["<leader>t"]  = { name = "Test", desc = get_icon("Debugger") .. "Test" },
        ["<leader>b"]  = { name = "Buffers", desc = get_icon("Tab") .. "Buffers" },
        ["<leader>d"]  = { name = "Diagnostics", desc = get_icon("Diagnostic") .. "Diagnostics" },
        ["<leader>l"]  = { name = "LSP", desc = get_icon("ActiveLSP") .. "LSP" },
        ["<leader>u"]  = { name = "Plugins", desc = get_icon("Package") .. "Plugins" },

        ["<leader>ga"] = { "<cmd>Git add -A|Git commit<CR>", "Add & Commit" },

        -- Plugins
        ["<leader>uu"] = { function() lazy.home() end, "Plugins Status" },

        -- find with telescope
        ["<leader>f"]  = { name = "Find", desc = get_icon("Search") .. "Find" },

        -- Sessions
        -- ["<leader>s"]  = { name = "Sessions", desc = get_icon("Session") .. "Sessions" },
        -- ["<leader>ss"] = { function() sessions.select("write") end, "Save" },
        -- ["<leader>sl"] = { function() sessions.select("read") end, "Load" },
        -- ["<leader>sd"] = { function() sessions.select("delete") end, "Delete" },
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
