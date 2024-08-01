local M        = {}
local get_icon = require("utils").get_icon
local lazy     = require("lazy")
-- local sessions = require("mini.sessions")

M.setup        = function()
    local whichkey = require('which-key')

    whichkey.add({
        -- Sections
        { "<leader>g",  group = "Git",                    icon = get_icon("Git") },
        { "<leader>r",  group = "Terminal",               icon = get_icon("Terminal") },
        { "<leader>t",  group = "Test",                   icon = get_icon("Debugger") },
        { "<leader>b",  group = "Buffers",                icon = get_icon("Tab") },
        { "<leader>d",  group = "Diagnostics",            icon = get_icon("Diagnostic") },
        { "<leader>l",  group = "LSP",                    icon = get_icon("ActiveLSP") },
        { "<leader>u",  group = "Plugins",                icon = get_icon("Package") },
        { "<leader>f",  group = "Find (telescope)",       icon = get_icon("Search") },
        { "<leader>h",  group = "Harpoon",                icon = get_icon("Hook") },
        { "<leader>u",  group = "UI",                     icon = get_icon("GitUntracked") },

        { "<leader>ga", "<cmd>Git add -A|Git commit<CR>", desc = "Add & Commit",          mode = "n" },
        { "<leader>z",  function() lazy.home() end,       desc = "Lazy",                  mode = "n" },
        { "<leader>w",  "<cmd>w<CR>",                     desc = "Save",                  mode = "n", icon = get_icon("Save") },
        { "<leader>e",  function() MiniFiles.open() end,  desc = "File explorer",         mode = "n", icon = get_icon("FolderClosed") },

        -- Sessions
        -- ["<leader>s"]  = { name = "Sessions", desc = get_icon("Session") .. "Sessions" },
        -- ["<leader>ss"] = { function() sessions.select("write") end, "Save" },
        -- ["<leader>sl"] = { function() sessions.select("read") end, "Load" },
        -- ["<leader>sd"] = { function() sessions.select("delete") end, "Delete" },
    })

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
