-- local au = require('au')
-- for more examples, see:
--    https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da

-- au.group('PackerGroup', {
--     { 'BufWritePost', 'plugins.lua', 'source <afile> | PackerCompile' },
-- })

local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})

-- Autosave only when there is something to save,
-- always saving makes build watchers crazy
api.nvim_create_autocmd(
    "FocusLost",
    { pattern = "*", command = "silent! wa" }
)

-- Show relative numbers only for the active buffer
--  don't run the autocmd for telescopeprompt,
--  prevents the annoying 0 from showing next to the cursor in the prompt
local linenumtoggle = api.nvim_create_augroup("LineNumberToggle", { clear = true })
api.nvim_create_autocmd("BufLeave",
    {
        pattern = '* if index(ignoreFiletype, &ft) < 0',
        callback = function()
            vim.cmd('set norelativenumber')
        end,
        group = linenumtoggle,
    }
)

api.nvim_create_autocmd("BufEnter",
    {
        pattern = '* if index(ignoreFiletype, &ft) < 0',
        callback = function()
            vim.cmd('set relativenumber')
        end,
        group = linenumtoggle,
    }
)

-- Organise imports
--     works, but the cursor flickers and there are
--     many error notifications that 'code action is not available'
--     see the stuff below instead.
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.go',
--   callback = function()
--         vim.lsp.buf.code_action({
--             context = {
--                 only = {
--                     'source.organizeImports'
--                 }
--             },
--             apply = true,
--         })
--   end
-- })

-- following example solution from github issue:
--   https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
local function goimports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
        goimports(1000)
    end
})

-- save a session before exiting
-- note: even though mini.sessions has a feature to autowrite a session
--        on exit, it was hard to come up with a way to automatically 'create'
--        a session in the first place. The below takes care of everything
--        in 6 lines.
vim.api.nvim_create_autocmd('VimLeavePre', {
    pattern = '*',
    callback = function()
        local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- returns directory name
        require('mini.sessions').write(dirname)
    end
})

-- Report LSP progress
-- ref: https://neovim.io/doc/user/lsp.html#LspProgress
-- ref: https://github.com/linrongbin16/lsp-progress.nvim/blob/d5f4d28efe75ce636bfbe271eb45f39689765aab/lua/lsp-progress.lua#L170
local lsp_progress_notification = function(ev)
    local client_id = ev.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local value = ev.data.params.value
    local token = ev.data.params.token
    local msg = value.message
    local title = " LSP [" .. client.name .. "]: " .. value.title

    return { token = token, msg = msg, title = title }
end

local lsp_progress = api.nvim_create_augroup("lsp_progress", { clear = true })
vim.api.nvim_create_autocmd('LspProgress', {
    pattern = 'begin',
    group = lsp_progress,
    callback = function(ev)
        local spinner = require("utils.spinner")
        local notif = lsp_progress_notification(ev)
        spinner.start(notif.token, notif.msg, notif.title)
    end
})

vim.api.nvim_create_autocmd('LspProgress', {
    pattern = 'end',
    group = lsp_progress,
    callback = function(ev)
        local spinner = require("utils.spinner")
        local notif = lsp_progress_notification(ev)
        spinner.stop(notif.token, notif.msg, notif.title)
    end
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'GitConflictDetected',
    callback = function()
        vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
    end
})
