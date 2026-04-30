local M = {}
M.setup = function()
    local obs = require("obsidian")
    obs.setup {
        workspaces = {
            {
                name = "second-brain",
                path = "~/workspace/second-brain-nvim",
            },
        },
        ui = {
            checkboxes = {
                -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                -- ["x"] = { char = "", hl_group = "ObsidianDone" },
                [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                ["-"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                ["<"] = { char = "🗓️", hl_group = "ObsidianScheduled" },
                -- Replace the above with this if you don't have a patched font:
                -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                -- You can also add more custom ones...
            },
        }
    }
end

return M
