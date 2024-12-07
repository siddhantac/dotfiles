local M = {}
M.setup = function()
    -- most of this is taken from the Lazy distro https://www.lazyvim.org/extras/ui/mini-starter

    require('mini.surround').setup()
    require('mini.sessions').setup()
    require('mini.files').setup()
    require('mini.cursorword').setup()
    require('mini.ai').setup()
    require('mini.indentscope').setup({
        symbol = "│",
    })

    -- local pad = string.rep(" ", 22)
    local new_section = function(name, action, section)
        return { name = name, action = action, section = section }
    end

    local starter = require("mini.starter")

    local time_since = function()
        local cp = require('configpulse').get_time()
        return cp['days'] .. "d " .. cp['hours'] .. "h " .. cp['minutes'] .. "m since last change"
    end

    local logo = [[
                                                      
               ████ ██████           █████      ██
              ███████████             █████ 
              █████████ ███████████████████ ███   ███████████
             █████████  ███    █████████████ █████ ██████████████
            █████████ ██████████ █████████ █████ █████ ████ █████
          ███████████ ███    ███ █████████ █████ █████ ████ █████
         ██████  █████████████████████ ████ █████ █████ ████ ██████
      ]]

    local logo2 =
    "                                                    \n ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ \n ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ \n ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ \n ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ \n ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ \n ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ \n "

    starter.setup({
        evaluate_single = true,
        -- header = "Welcome back, Sid",
        header = logo .. "   Welcome back, Sid",
        items = {
            starter.sections.sessions(),
            new_section("Find file", "Telescope find_files", "Telescope"),
            new_section("Recent files", "Telescope oldfiles", "Telescope"),
            new_section("Grep text", "Telescope live_grep", "Telescope"),
            new_section("Lazy", "Lazy", "Lazy"),
            new_section("New file", "ene | startinsert", "Built-in"),
            new_section("Quit", "qa", "Built-in"),
        },
        footer = time_since,
        -- left-aligned is good.
        -- if you want to try center align, then the logic for sessions
        -- has to be extracted from mini.starter source code and pasted here.
        --
        -- content_hooks = {
        --     starter.gen_hook.adding_bullet(pad .. "░ ", false),
        --     starter.gen_hook.aligning("center", "center"),
        -- },
    })

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

    -- vim.api.nvim_create_autocmd("User", {
    --     pattern = "LazyVimStarted",
    --     callback = function()
    --         local stats = require("lazy").stats()
    --         local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    --         -- local pad_footer = string.rep(" ", 8)
    --         -- starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    --         starter.config.footer = "⚡ Neovim loaded " ..
    --             stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
    --         pcall(starter.refresh)
    --     end,
    -- })


    local map_split = function(buf_id, lhs, direction)
        local rhs = function()
            -- Make new window and set it as target
            local new_target_window
            vim.api.nvim_win_call(
                MiniFiles.get_explorer_state().target_window,
                function()
                    vim.cmd(direction .. ' split')
                    new_target_window = vim.api.nvim_get_current_win()
                end
            )

            MiniFiles.set_target_window(new_target_window)
            MiniFiles.go_in()
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
            local buf_id = args.data.buf_id
            -- Tweak keys to your liking
            map_split(buf_id, '<C-x>', 'belowright horizontal')
            map_split(buf_id, '<C-v>', 'belowright vertical')
        end,
    })
end

return M
