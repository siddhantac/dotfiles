local spec =  {
    'stevearc/resession.nvim',
    config = function()
        require("resession").setup({
            autosave = {
                enabled = true,
                interval = 300, -- 5 minutes
                notify = false,
            },
        })
    end
}


local resession = require("resession")
-- autoload session
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- Only load the session if nvim was started with no args
--     if vim.fn.argc(-1) == 0 then
--     -- Save these to a different directory, so our manual sessions don't get polluted
--       resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    resession.save(vim.fn.getcwd(), { dir = "session", notify = false })
  end,
})

return spec
