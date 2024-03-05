vim.cmd([[
augroup TodotxtSyntax
    autocmd!
    autocmd BufReadPost *.todotxt set filetype=todotxt

    autocmd BufReadPost * syntax match TodoPriorityA /^(A)/
    autocmd BufReadPost * syntax match TodoPriorityB /^(B)/
    autocmd BufReadPost * syntax match TodoPriorityC /^(C)/
    autocmd BufReadPost * syntax match TodoContext   /@\w*/
    autocmd BufReadPost * syntax match TodoProject   /+\w*/

    autocmd BufReadPost * highlight TodoPriorityA  ctermfg=red guifg=red
    autocmd BufReadPost * highlight TodoPriorityB  ctermfg=cyan guifg=cyan
    autocmd BufReadPost * highlight TodoPriorityC  ctermfg=yellow guifg=yellow
    autocmd BufReadPost * highlight TodoContext    ctermfg=yellow guifg=yellow
    autocmd BufReadPost * highlight TodoProject    ctermfg=green guifg=green
augroup END
]])
-- vim.api.nvim_set_hl(0, "Kalu", { ctermfg = red, fg = red })
-- vim.fn.matchadd('Kalu', 'Hello')
