" >>> plugins
" ==========================================================
call plug#begin('~/.vim/plugged') " specify a directory for plugins

" general tools
" -------------
Plug 'airblade/vim-gitgutter'         " git
Plug 'scrooloose/nerdtree'            " file tree explorer
Plug 'scrooloose/nerdcommenter'       " code comments
Plug 'ctrlpvim/ctrlp.vim'             " fuzzy file searcher
Plug 'tpope/vim-surround'             " surround text with symbols/tags/brackets
Plug 'jiangmiao/auto-pairs'           " manage bracket/parens pairs
Plug 'SirVer/ultisnips'               " snippet engine
Plug 'machakann/vim-highlightedyank'  " highlight the yank area
Plug 'junegunn/vim-easy-align'        " easy alignment
Plug 'mileszs/ack.vim'                " fast text search
Plug 'godlygeek/tabular'              " dependency for vim-markdown
Plug 'plasticboy/vim-markdown'        " markdown syntax highlighting etc

" code tools
" -------------
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }                 " Go plugin
Plug 'vim-python/python-syntax'                                    " python syntax highlighting
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " conquer of completion
Plug 'pangloss/vim-javascript'                                     " javascript syntax
Plug 'leafgarland/typescript-vim'                                  " typescript syntax
Plug 'peitalin/vim-jsx-typescript'                                 " jsx syntax

" appearance
" -------------
Plug 'vim-airline/vim-airline'                 " Airline - improves the statusline
Plug 'tpope/vim-fugitive'                      " git support (needed for Airline)
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " highlight files in nerdtree
" Plug 'vim-airline/vim-airline-themes'        " themes for Airline

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'fatih/molokai'
Plug 'dikiaap/minimalist'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'

Plug 'ryanoasis/vim-devicons'                                " file icons

call plug#end() " initialize plugin system
" =========================================================


" >>> appearance
" =========================================================

" vim settings
" -------------------------------------
set background=dark
set encoding=utf8
set cursorline
set lazyredraw
syntax on

if (has("termguicolors"))
  set termguicolors
endif
" -------------------------------------

augroup nord-theme-overrides
  autocmd!
  autocmd ColorScheme nord highlight Normal guibg=#192029
augroup END

"colorscheme molokai
"colorscheme minimalist
"colorscheme iceberg
colorscheme nord

"colorscheme gruvbox
"let g:gruvbox_contrast_dark='hard'

" nvim-qt does not display colors in popupmenu correctly,
" so disable gui popupmenu
au GUIEnter * GuiPopupmenu 0


" airline
" -------------------------------------
let g:airline_theme='nord'
let g:airline_powerline_fonts=1
let g:airline_section_b = ' %{FugitiveHead()}' " display only git branch

"set guifont=Ubuntu\ Mono\ derivative\ Powerline:h12

"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif

"" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = 'Ɇ'
"let g:airline_symbols.whitespace = 'Ξ'

"" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = ''
" -------------------------------------

" >>> behaviour
" ==========================================================
let mapleader=";"

" Autosave only when there is something to save,
" always saving makes build watchers crazy
:au FocusLost * silent! wa

set autowrite " save file when :make or :GoBuild is called

" open files relative to the path of current file

" open file in current buffer
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" open file in new tab
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>

" open file in vertical split
map ,v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" open file in horizontal split
map ,h :split <C-R>=expand("%:p:h") . "/" <CR>

" replace word under cursor
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>

" move files
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" line numbers
set number relativenumber
set numberwidth=5
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" buffer manipulation
nnoremap <Leader><Leader> :b#<CR> " switch buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>
nnoremap <leader>c :close<cr>     " close buffer

" easy write and source
nnoremap <Leader>ws :w<bar>so%<CR>
nnoremap <Leader>w :w<CR>

" code folding
set foldmethod=syntax
set foldlevel=2
set nofoldenable
set foldlevelstart=99

set laststatus=2
set splitright
set splitbelow
set hlsearch
set ignorecase smartcase

" <Enter> will simply select the highlighted item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype js setlocal tabstop=4 noexpandtab
" ts - show existing tab with 4 spaces width
" sw - when indenting with '>', use 4 spaces width
" sts - control <tab> and <bs> keys to match tabstop
"
" control all other files
set shiftwidth=4

set undofile " maintain undo history between sessions
set undodir=~/.vim/undodir

nnoremap <leader><space> :nohlsearch<CR>

" copy/paste to/from system clipboard
vnoremap <leader>y "*y
nnoremap <leader>yy "*yy
nnoremap <leader>v "*p

" autosave and autoreload sessions
" -------------------------------------
let s:sessionFile = ".workspace.nvim"

fu! SaveSession()
    tabdo NERDTreeClose
    echom s:sessionFile
    execute 'mksession! ' . s:sessionFile
endfunction

fu! RestoreSession()
    if argc() == 0
	if filereadable(s:sessionFile)
	    execute 'so ' . s:sessionFile
	    if bufexists(1)
		for l in range(1, bufnr('$'))
		    if bufwinnr(l) == -1
			exec 'sbuffer ' . l
		    endif
		endfor
	    endif
	    echom "restored session from " . s:sessionFile
	else
	    echom "no session file"
	endif
    endif
endfunction

autocmd VimLeave * call SaveSession()
autocmd VimEnter * nested call RestoreSession()
" -------------------------------------
" ==========================================================

" >>> plugin settings
" ==========================================================

" easy align
" -------------------------------------
" start interactive EasyAlign in visual mode (eg. vipga)
xmap ga <Plug>(EasyAlign)

" start interactive EasyAlign for a motion/text object (eg. gaip)
nmap ga <Plug>(EasyAlign)
" -------------------------------------

" vim-go 
" -------------------------------------
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 0
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 0
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'staticcheck']
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'errcheck'] " only run these when gometalinter is called on autosave
let g:go_fmt_experimental = 1
let g:go_rename_command = 'gopls'
let g:go_def_mapping_enabled = 0      " this is handled by CoC

" open alternate (test file) files easily
" 	:A = replace current buffer
" 	:AV = vertical split
" 	:AS = horizontal split
" 	:AT = new tab
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit') 
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

function GoTest()
    echo 'running tests in file...'
    :GoTest
endfunction

autocmd Filetype go nmap <leader>t :call GoTest()<CR>          " run tests
autocmd Filetype go nmap <leader>i <Plug>(go-info)             " show func info
autocmd Filetype go nmap <leader>tf <Plug>(go-test-func)       " run current test function in file
autocmd Filetype go nmap <leader>tc <Plug>(go-coverage-toggle) " toggle coverage profile for current file
autocmd Filetype go nmap <leader>cl <Plug>(go-callers)         " see callers of a function
autocmd Filetype go nnoremap <leader>d  :GoDecls<CR>               " see declarations in a file
autocmd Filetype go nnoremap <leader>dd  :GoDeclsDir<CR>           " see declarations in a dir
" -------------------------------------

" python highlighting
let g:python_highlight_all = 1

" nerdtree
" -------------------------------------
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1

" quick toggle (nn)
map <leader>nn :NERDTreeToggle<CR>

" find file in NERDTree
map <leader>nf :NERDTreeFind<CR>

" file highlighting
" -------------------------------------
"
" Highlight full name (not only icons)
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['go'] = s:blue " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['md'] = s:orange " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['ini'] = s:yellow " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['exe'] = s:green " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['php'] = s:purple " sets the color of css files to blue

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['\.git.*'] = s:git_orange

let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsDefaultFileSymbolColor = s:white " sets the color for files that did not match any rule
let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultOpenFolderSymbolColor= s:white

hi NERDTreeOpenable ctermfg=red guifg=#00FF00
hi NERDTreeClosable ctermfg=white guifg=#FF0000
" hi Directory guifg=LemonChiffon ctermfg=green

" -------------------------------------

" UltiSnips
" -------------------------------------
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'gosnippets/UltiSnips', $HOME.'/.vim/UltiSnips']
" -------------------------------------

" Nerd commenter
" -------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 1
" -------------------------------------

" use silver-surfer for ack
let g:ackprg = 'ag --vimgrep --smart-case'                                                   
cnoreabbrev ag Ack                                                                           
cnoreabbrev aG Ack                                                                           
cnoreabbrev Ag Ack                                                                           
cnoreabbrev AG Ack 


" coc.nvim default settings
" ---------------------------------------------
set hidden         " if hidden is not set, TextEdit might fail.
set cmdheight=2    " Better display for messages
set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c   " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr> " Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>  " Manage extensions
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>    " Show commands
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>     " Find symbol of current document
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>  " Search workspace symbols
nnoremap <silent> <space>j  :<C-u>CocNext<CR>             " Do default action for next item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>             " Do default action for previous item.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>       " Resume latest coc list

let g:coc_global_extensions = [ 'coc-tsserver' , 'coc-go' ]
" ---------------------------------------------

" ctrlp
" ---------------------------------------------
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" ---------------------------------------------

