-- local spinner_frames = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" }
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
-- local spinner_frames = { "∙∙∙", "●∙∙", "∙●∙", "∙∙●" }
-- local spinner_frames = { "▱▱▱", "▰▱▱", "▰▰▱", "▰▰▰", "▰▰▱", "▰▱▱", "▱▱▱" }
local loading = {} -- client_id -> frame index (1-based)

local function tick(client_id)
    if not loading[client_id] then return end
    loading[client_id] = (loading[client_id] % #spinner_frames) + 1
    require('lualine').refresh({ place = { 'statusline' } })
    vim.defer_fn(function() tick(client_id) end, 80)
end

local function start(client_id)
    if loading[client_id] then return end
    loading[client_id] = 1
    tick(client_id)
end

local function stop(client_id)
    loading[client_id] = nil
    require('lualine').refresh({ place = { 'statusline' } })
end

local function icon(client_id)
    local frame = loading[client_id]
    if frame then
        return spinner_frames[frame]
    end
end

return { start = start, stop = stop, icon = icon }
