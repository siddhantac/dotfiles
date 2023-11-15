local lazy = require("lazy")

lazy.setup("plugins", {
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        notify = true, -- get a notification when new updates are found
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "netrwPlugin",
                "gzip",
                "health",
                "man",
                "matchit",
                "matchparen",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
