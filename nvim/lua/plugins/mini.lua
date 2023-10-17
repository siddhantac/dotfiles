local M = {}
M.opts = function()
    -- most of this is taken from the Lazy distro https://www.lazyvim.org/extras/ui/mini-starter

    require('mini.comment').setup()
    require('mini.surround').setup()
    require('mini.sessions').setup()
    require('mini.files').setup()

    local pad = string.rep(" ", 22)
    local new_section = function(name, action, section)
        return { name = name, action = action, section = section }
    end

    local starter = require("mini.starter")

    --stylua: ignore
    local config = {
        evaluate_single = true,
        header = "Welcome back, Sid",
        items = {
            starter.sections.sessions(),
            new_section("Find file", "Telescope find_files", "Telescope"),
            new_section("Recent files", "Telescope oldfiles", "Telescope"),
            new_section("Grep text", "Telescope live_grep", "Telescope"),
            new_section("Lazy", "Lazy", "Lazy"),
            new_section("New file", "ene | startinsert", "Built-in"),
            new_section("Quit", "qa", "Built-in"),
        },
        -- left-aligned is good.
        -- if you want to try center align, then the logic for sessions
        -- has to be extracted from mini.starter source code and pasted here.
        --
        -- content_hooks = {
        --     starter.gen_hook.adding_bullet(pad .. "░ ", false),
        --     starter.gen_hook.aligning("center", "center"),
        -- },
    }
    return config
end

M.config = function(_, config)
    -- close Lazy and re-open when starter is ready
    if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniStarterOpened",
            callback = function()
                require("lazy").show()
            end,
        })
    end

    local starter = require("mini.starter")
    starter.setup(config)

    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            -- local pad_footer = string.rep(" ", 8)
            -- starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            starter.config.footer = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            pcall(starter.refresh)
        end,
    })
end

return M
