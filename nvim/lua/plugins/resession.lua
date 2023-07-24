local function get_session_name()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- returns directory name
end

local spec = {
    'stevearc/resession.nvim',
    name = 'resession.nvim',
    config = function()
        require("resession").setup({
            autosave = {
                enabled = true,
                interval = 300, -- 5 minutes
                notify = false,
            },
        })

        local resession = require("resession")
        -- autoload session
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
            -- Save these to a different directory, so our manual sessions don't get polluted
              resession.load(get_session_name(), { dir = "session", silence_errors = true })
            end
          end,
        })
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                resession.save(get_session_name(), { dir = "session", notify = false })
            end,
        })
    end
}


return spec
