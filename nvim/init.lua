local modules = {
    "core.options",
    "core.mappings",
    "core.lazy",
    "core.autocmds",
}


for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
        error('Error loading ' .. module .. '\n\n' .. err)
    end
end

-- plugin specific options
vim.cmd.colorscheme "catppuccin-mocha"
vim.notify = require("notify")
