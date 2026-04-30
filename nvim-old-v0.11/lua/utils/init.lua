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

    local cmd = { "git", "push" }
    vim.system(cmd, { text = true },
        function(obj)
            vim.schedule(
                function()
                    local res = obj.stdout .. " " .. obj.stderr

                    if obj.code ~= 0 then
                        spinner.stop(1, "Failed to push", title)
                        vim.notify(res, "error", { title = title })
                    else
                        spinner.stop(1, "Pushed:" .. res, title)
                    end
                end
            )
        end
    )
end

function M.gitpull()
    local title = "Git"
    local spinner = require("utils.spinner")
    spinner.start(1, "Pulling", "Git")

    vim.system(cmd, { text = true },
        function(obj)
            vim.schedule(
                function()
                    local res = obj.stdout .. " " .. obj.stderr

                    if obj.code ~= 0 then
                        spinner.stop(1, "Failed to pull", title)
                        vim.notify(res, "error", { title = title })
                    else
                        spinner.stop(1, "Pulled:" .. res, title)
                    end
                end
            )
        end
    )
end

return M
