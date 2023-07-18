require("core.options")
require("core.mappings")
require("core.autocmds")
require("core.lazy")

-- plugin specific options
vim.cmd.colorscheme "catppuccin-mocha"
vim.notify = require("notify")
