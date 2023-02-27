local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

require ('which-key').register(
    {
        h = {
            name = "harpoon",
            a = {mark.add_file, "Mark file"},
            m = {ui.toggle_quick_menu, "Toggle quick menu"},
            q = { function() ui.nav_file(1) end, "Navigate to 1"},
            w = { function() ui.nav_file(2) end, "Navigate to 2"},
            e = { function() ui.nav_file(3) end, "Navigate to 3"},
            r = { function() ui.nav_file(4) end, "Navigate to 4"},
        }
    },
    { prefix = "<leader>" }
)
