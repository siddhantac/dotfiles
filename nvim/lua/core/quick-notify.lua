local quickNotify = function(msg, cmd)
    vim.notify = require("notify")
    vim.notify(msg, "info", {
        render = "compact",
        title = "fugitive",
        timeout = 500,
        on_close = function()
            vim.cmd(cmd)
        end
    })
end

return quickNotify
