
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
Plug 'majutsushi/tagbar' 	      " display source code tags
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
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }    " code-completion framework

" appearance
" -------------
Plug 'vim-airline/vim-airline'                 " Airline - improves the statusline
Plug 'tpope/vim-fugitive'                      " git support (needed for Airline)
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " highlight files in nerdtree
" Plug 'vim-airline/vim-airline-themes'        " themes for Airline

" colorschemes
Plug 'tomasiser/vim-code-dark'
Plug 'kaicataldo/material.vim'
Plug 'morhetz/gruvbox'
Plug 'fatih/molokai'
Plug 'dikiaap/minimalist'
Plug 'rakr/vim-one'

Plug 'ryanoasis/vim-devicons'                                " file icons

call plug#end() " initialize plugin system
" =========================================================


" >>> appearance
" =========================================================
"set guifont=fira\ code\ nerd\ font
set background=dark
set encoding=utf8

"colorscheme material
"colorscheme codedark
"colorscheme molokai
"colorscheme minimalist
colorscheme one

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

"autocmd BufEnter *.{js,jsx,ts,tsx} colorscheme minimalist
autocmd BufEnter *.go colorscheme gruvbox


" nvim-qt does not display colors in popupmenu correctly,
" so disable gui popupmenu
" au VimEnter * GuiPopupmenu 0

syntax on

set cursorline
set lazyredraw

" airline
" -------------------------------------
" let g:airline_theme='bubblegum'
" let g:airline_powerline_fonts=1
" set guifont=Source\ Code\ Pro\ for\ Powerline:h12
" set guifont=Source\ Code\ Pro\ for\ Powerline:h12
" set guifont=Ubuntu\ Mono\ derivative\ Powerline:h12

" if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
" endif

"" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'

"" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" -------------------------------------

" >>> behaviour
" ==========================================================
let mapleader=";"

" Autosave only when there is something to save,
" always saving makes build watchers crazy
:au FocusLost * silent! wa

set autowrite " save file when :make or :GoBuild is called

" open files relative to the path of current file
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :vsplit <C-R>=expand("%:p:h") . "/" <CR>

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
nnoremap <Leader><Leader> :b#<CR>
nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>

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

" autosave and autoreload sessions
" -------------------------------------
"let sessionFile = expand("~/session.vim")

fu! GetSessionFile()
    let wd = substitute(getcwd(), "/", "_", "g")
    let sessionFile = expand("~/.nvim/session") . wd
    return sessionFile
endfunction

fu! SaveSession()
    tabdo NERDTreeClose
    let sessionFile = GetSessionFile()
    echom sessionFile
    execute 'mksession! ' . sessionFile
endfunction

fu! RestoreSession()
    let sessionFile = GetSessionFile()
    if filereadable(sessionFile)
	execute 'so ' . sessionFile
	if bufexists(1)
	    for l in range(1, bufnr('$'))
		if bufwinnr(l) == -1
		    exec 'sbuffer ' . l
		endif
	    endfor
	endif
	echom "restored session from" . sessionFile
    else
	echom "no session file"
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


" deoplete
" -------------------------------------
" let g:python3_host_prog = "C:/Users/Sidd/AppData/Local/Programs/Python/Python37/python.exe"
"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
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

autocmd Filetype go nmap <leader>i <Plug>(go-info)
" -------------------------------------

" python highlighting
let g:python_highlight_all = 1

" tagbar
nmap <leader>tt :TagbarToggle<CR>

" nerdtree
" -------------------------------------

" quick toggle (nn)
map <leader>nn :NERDTreeToggle<CR>

" find file in NERDTree
map <leader>nf :NERDTreeFind<CR>

" file highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" note: for Neovim, change 'guifg' term (4th param)
"call NERDTreeHighlightFile('py', 'green', 'none', 'green', '#151515')
"call NERDTreeHighlightFile('pyc', 'grey', 'none', 'grey', '#151515')
"call NERDTreeHighlightFile('go', 'blue', 'none', 'DeepSkyBlue', '#151515')
"call NERDTreeHighlightFile('Makefile', 'yellow', 'none', 'Gold', '#151515')
"call NERDTreeHighlightFile('ini', 'yellow', 'none', 'LightYellow', '#151515')
"call NERDTreeHighlightFile('yml', 'yellow', 'none', 'LightYellow', '#151515')
"call NERDTreeHighlightFile('config', 'yellow', 'none', 'LightYellow', '#151515')
"call NERDTreeHighlightFile('conf', 'yellow', 'none', 'LightYellow', '#151515')
"call NERDTreeHighlightFile('json', 'yellow', 'none', 'LightYellow', '#151515')
"call NERDTreeHighlightFile('exe', 'green', 'none', 'LimeGreen', '#151515')
"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"call NERDTreeHighlightFile('md', 'white', 'none', 'wheat', '#151515')

hi NERDTreeOpenable ctermfg=green guifg=#00FF00
hi NERDTreeClosable ctermfg=green guifg=#FF0000
hi Directory guifg=LemonChiffon ctermfg=white
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

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

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

let g:coc_global_extensions = [ 'coc-tsserver' ]
" ---------------------------------------------

" ctrlp
" ---------------------------------------------
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" ---------------------------------------------

