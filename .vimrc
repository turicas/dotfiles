" Álvaro Justen's VIM configuration
" <https://github.com/turicas/dotfiles/>

" General configurations
set nocompatible
set title " Force window title
set number " Show line numbers
set cursorline " Highlight current line
set mouse=a " Use the mouse
set visualbell " Audio bell is evil
set scrolloff=15 " Keep the context around the current line
set hidden " Possibility to have more than one unsaved buffers.
set ruler " Line and column number
set splitbelow splitright " Main position for splits
set textwidth=119 " max_line_length = 119
set colorcolumn=+1 " Highlight column limit
set encoding=utf-8
set fileencoding=utf-8 " charset = utf-8
set fileformat=unix " end_of_line = lf
set endofline " insert_final_newline = true

" Colors
highlight clear " Reset all highlighting to the defaults
set background=dark
colorscheme slate
autocmd ColorScheme * highlight ColorColumn term=reverse cterm=reverse gui=reverse
autocmd ColorScheme * highlight Normal ctermbg=black ctermfg=white guifg=white guibg=black
autocmd ColorScheme * highlight NonText guifg=#707070 guibg=NONE gui=NONE ctermfg=darkgrey ctermbg=NONE cterm=NONE
set termguicolors
syntax on " Syntax highlight
match Todo /\s\+$/ " Highlight To-dos

" Status line
set laststatus=2 " Last window will always have a status line
set statusline=
set statusline+=\ %{mode()}
set statusline+=\ %m " Modified
set statusline+=\ %r " Read-Only
set statusline+=\ %y " File type
set statusline+=\ %f " Relative filename
set statusline+=%= " Split
set statusline+=\ %3.(%c%)\ @ " Column
set statusline+=\ %5.(%l/%L%) " Current line/total lines
set statusline+=\ %P " Line percentage

" <TAB> completion in command-mode
set wildmenu
set wildmode=longest:full,full

" Search
set showmatch " Show matching parenthesis
set hlsearch " highlight search terms
set incsearch " show search matches as you type
set ignorecase " ignore case when searching
set smartcase " ignore case if search pattern is all lowercase, case-sensitive otherwise
" Clear search highlight:
nmap <silent> ,/ :nohlsearch<CR>
nnoremap <C-f> :g//#<Left><Left> " Search and show all occurrences

let mapleader = ","
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
" better indentation
vnoremap > >gv
vnoremap < <gv

" plugins
filetype on
filetype indent on
filetype plugin on
packadd editorconfig

" Tell vim to remember certain things when we exit
"  '1000 -> marks will be remembered for up to 1000 previously edited files
"  "1000 -> will save up to 1000 lines for each register
"  :1000-> up to 1000 lines of command-line history will be remembered
"  %    -> saves and restores the buffer list
"  n... -> where to save the viminfo files
set viminfo='1000,\"1000,:1000,%,n~/.viminfo
set history=10000 " New history size

" Clipboard and yank
noremap <C-c> "+y " Ctrl+c to copy to clipboard (only works when VIM is open)
" TODO: may define clipboard name
"set clipboard=unnamed
"set clipboard=unnamedplus

" Move tabs
nnoremap <C-h> :-tabmove<CR>
nnoremap <C-l> :+tabmove<CR>

" Tags
"set tags=./.tags;,.tags;
"TODO: configure tags creation (automatically) using universal-ctags and/or tree-sitter
"       <https://gist.github.com/turicas/a83ac50833b78707a306385de315de8f>

" TODO: add configs to easily change between buffers (like 'Junggling with buffers' in <https://stackoverflow.com/a/16084326/1299446>)
" TODO: add configs to fuzzy search (like 'Juggling with files' in <https://stackoverflow.com/a/16084326/1299446>)

" TODO: add configs to move lines, as in <https://stackoverflow.com/a/49053064/1299446>

" Show trailing characters and undesirable spaces
set list
set listchars=tab:▸\ ,leadmultispace:│\ \ \ ,trail:·,multispace:·,nbsp:~,extends:→,eol:󰌑

" Save view before closing and restores after opening (view includes cursor position)
autocmd BufLeave,BufWinLeave * silent! mkview
autocmd BufReadPost * silent! loadview
" Remove trailing spaces and empty lines in the end of the file (except for binary, diff or patch files)
autocmd BufWritePre <buffer> if &binary == 0 && index(['diff', 'patch'], &filetype) < 0 | mkview | %s/\(\s*$\|\_s\%$\)//e | loadview | endif

" Tab/spaces
set nowrap " Don't wrap lines
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set autoindent " Always set autoindenting on
set copyindent " Copy the previous indentation on autoindenting
set shiftround " Use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4 " tab_width = 4 (a tab is 4 spaces by default)
set shiftwidth=4 " indent_size = 4 (number of spaces to use for autoindenting)
set softtabstop=4 " backspace removes 4 spaces
set smarttab " Insert tabs on the start of a line according to shiftwidth, not tabstop
set expandtab " indent_style = space
set fixendofline
autocmd FileType c,cpp,go,php,python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType css,html,javascript,javascriptreact,less,scss,typescript,typescriptreact,json,yaml,toml,markdown,sh,bash,sql,xml,svg setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
