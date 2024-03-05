vim.cmd([[
augroup TodotxtSyntax
    autocmd!
    autocmd BufReadPost *.todotxt set filetype=todotxt

    autocmd BufReadPost * syntax match TodoPriorityA /^(A)/ contains=Context,Project
    autocmd BufReadPost * syntax match TodoPriorityB /^(B)/
    autocmd BufReadPost * syntax match TodoPriorityC /^(C)/
    autocmd BufReadPost * syntax match Context /@\w*/ contains=NONE
    autocmd BufReadPost * syntax match Project /+\w*/ contains=NONE

    autocmd BufReadPost * highlight TodoPriorityA  ctermfg=red guifg=red
    autocmd BufReadPost * highlight TodoPriorityB  ctermfg=cyan guifg=cyan
    autocmd BufReadPost * highlight TodoPriorityC  ctermfg=yellow guifg=yellow
    autocmd BufReadPost * highlight Context  ctermfg=yellow guifg=yellow
    autocmd BufReadPost * highlight Project  ctermfg=green guifg=green
augroup END
]])
-- vim.api.nvim_set_hl(0, "Kalu", { ctermfg = red, fg = red })
-- vim.fn.matchadd('Kalu', 'Hello')
