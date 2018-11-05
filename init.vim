
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Go pluging
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Code comments
Plug 'scrooloose/nerdcommenter'

" Deoplete - autocompletion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" go plugin for deoplete
Plug 'zchee/deoplete-go', { 'do': 'make'}

" dark+ theme
Plug 'tomasiser/vim-code-dark'
Plug 'kaicataldo/material.vim'

" Initialize plugin system
call plug#end()

"set background=dark
"colorscheme material
colorscheme codedark

let mapleader=";"

let g:python3_host_prog = "C:/Users/Sidd/AppData/Local/Programs/Python/Python37/python.exe"

" deoplete
let g:deoplete#enable_at_startup = 1

" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

set completeopt=longest,menuone,preview
set completeopt+=noinsert
set completeopt+=noselect

" <Enter> will simply select the highlighted item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use Ctrl+n and Ctrl+p to navigate autocomplete menu
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" vim-go settings
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

" (deprecated) use Ctrl+Space for autocomplete
"inoremap <C-Space> <C-x><C-o>


" Autosave only when there is something to save. Always saving makes build
" watchers crazy
function! SaveIfUnsaved()
    if &modified
        :silent! w
    endif
endfunction
au FocusLost,BufLeave * :call SaveIfUnsaved()
" Read the file on focus/buffer enter
au FocusGained,BufEnter * :silent! !

"set shell=bash
"set autochdir

" mappings to open files relative to the path of current file
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :vsplit <C-R>=expand("%:p:h") . "/" <CR>

