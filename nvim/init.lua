require("core.options")
require("core.mappings")
require("core.lazy")
require("core.autocmds")

-- plugin specific options
vim.cmd.colorscheme "catppuccin-mocha"
vim.notify = require("notify")
