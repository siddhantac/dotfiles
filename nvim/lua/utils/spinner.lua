-- https://github.com/rcarriga/nvim-notify/issues/43#issuecomment-1030604806
local client_notifs = {}

local spinner_frames = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" }

local function update_spinner(client_id, title)
    local notif_data = client_notifs[client_id]
    if notif_data and notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        local new_notif = vim.notify(
            nil,
            nil,
            {
                title = title,
                hide_from_history = true,
                icon = spinner_frames[new_spinner],
                replace = notif_data.notification
            }
        )
        client_notifs[client_id] = {
            notification = new_notif,
            spinner = new_spinner,
        }
        vim.defer_fn(function()
            update_spinner(client_id, title)
        end, 100)
    end
end

local function run_spinner(client_id, type, message, title)
    local notif_data = client_notifs[client_id]
    if type == "begin" then
        local notification = vim.notify(message, "info", {
            title = title,
            icon = spinner_frames[1],
            timeout = false,
        })
        client_notifs[client_id] = {
            notification = notification,
            spinner = 1,
        }
        update_spinner(client_id, title)
    elseif type == "end" then
        local new_notif = vim.notify(
            message,
            "info",
            {
                title = title,
                icon = "",
                replace = notif_data.notification,
                timeout = 3000,
            }
        )
        client_notifs[client_id] = {
            notification = new_notif,
        }
    else
        local new_notif = vim.notify(
            message,
            "info",
            {
                title = title,
                replace = notif_data.notification,
            }
        )
        client_notifs[client_id] = {
            notification = new_notif,
            spinner = notif_data.spinner,
        }
    end
end

local start = function(client_id, message, title)
    run_spinner(client_id, "begin", message, title)
end

local stop = function(client_id, message, title)
    run_spinner(client_id, "end", message, title)
end

return { start = start, stop = stop }
