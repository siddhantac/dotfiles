local M = {}

function M.get_icon(name)
    local nf_ok, nf = pcall(require, "icons.nerd_font")
    if nf_ok then
        return nf[name] .. " "
    else
        local tx_ok, tx = pcall(require, "icons.text")
        if tx_ok then
            return tx[name] .. " "
        end
    end
    return ""
end

function M.gitpush()
    local spinner = require("utils.spinner")
    local title = "Git"
    spinner.start(1, "Pushing", title)

    -- taken from here
    -- https://www.reddit.com/r/neovim/comments/pa4yle/comment/ha2h1nh/?utm_source=share&utm_medium=web2x&context=3
    local job = require('plenary.job')
    job:new({
        command = 'git',
        args = { 'push' },
        on_exit = function(j, exit_code)
            local res1 = table.concat(j:result(), ":")
            local res2 = table.concat(j:stderr_result(), ":")
            local res = res1 .. " " .. res2

            if exit_code ~= 0 then
                spinner.stop(1, "Failed to push", title)
                vim.notify(res, "error", { title = title })
            else
                spinner.stop(1, "Pushed:" .. res, title)
            end
        end,
    }):start()
end

function M.gitpull()
    local spinner = require("utils.spinner")
    spinner.start(1, "Pulling", "Git")

    local job = require('plenary.job')
    job:new({
        command = 'git',
        args = { 'pull' },
        on_exit = function(j, exit_code)
            local res = table.concat(j:result(), "\n")

            if exit_code ~= 0 then
                spinner.stop(1, "Failed to pull")
                vim.notify(res, "error", { title = "Git" })
            else
                spinner.stop(1, "Pulled")
            end
        end,
    }):start()
end

return M
