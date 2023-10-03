local lazy = require("lazy")

lazy.setup("plugins", {
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
