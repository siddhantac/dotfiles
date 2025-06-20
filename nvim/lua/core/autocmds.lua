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
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = '*.go',
    callback = function(args)
        vim.lsp.buf.format()
        vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
    end,
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

    if not value or not value.title then
        return
    end

    local message = value.message or ""
    local msg = client.name .. " - " .. value.title .. "\n  " .. message
    local title = "LSP"

    return { token = token, msg = msg, title = title }
end

local lsp_progress = api.nvim_create_augroup("lsp_progress", { clear = true })
vim.api.nvim_create_autocmd('LspProgress', {
    pattern = 'begin',
    group = lsp_progress,
    callback = function(ev)
        local spinner = require("utils.spinner")
        local notif = lsp_progress_notification(ev)

        if notif == nil then
            return
        end
        spinner.start(notif.token, notif.msg, notif.title)
    end
})

vim.api.nvim_create_autocmd("LspProgress", {
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
        -- vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
        vim.keymap.set('n', 'cww', function()
            engage.conflict_buster()
            create_buffer_local_mappings()
        end)
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "User: Set LSP folding if client supports it",
    callback = function(ctx)
        local client = assert(vim.lsp.get_client_by_id(ctx.data.client_id))
        if client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
            vim.notify("set lsp folding")
        end
    end,
})
