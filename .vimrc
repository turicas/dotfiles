" Álvaro Justen's VIM configuration
" <https://github.com/turicas/dotfiles/>

set nocompatible
set laststatus=2

" Colors
highlight clear " Reset all highlighting to the defaults
set background=dark
colorscheme slate
autocmd ColorScheme * highlight ColorColumn term=reverse cterm=reverse gui=reverse
autocmd ColorScheme * highlight Normal ctermbg=black ctermfg=white guifg=white guibg=black
autocmd ColorScheme * highlight NonText guifg=#707070 guibg=NONE gui=NONE ctermfg=darkgrey ctermbg=NONE cterm=NONE
set termguicolors

"highlight SpecialKey ctermfg=lightgray guifg=lightgray
syntax on " Syntax highlight


" Show line numbers
set number
"set relativenumber  " TODO: may delete
set cursorline

" 120-th column limit
set textwidth=119
set colorcolumn=+1

" Search
set hlsearch " highlight search terms
set incsearch " show search matches as you type
set ignorecase " ignore case when searching
set smartcase " ignore case if search pattern is all lowercase, case-sensitive otherwise
"TODO: add command to clear search highlight
"nmap <silent> ,/ :nohlsearch<CR>?

" Enable modeline so vim will reconfigure when open vim-configured files
set modeline

" plugins
filetype on
filetype indent on
filetype plugin on

" Tell vim to remember certain things when we exit
"  '1000 -> marks will be remembered for up to 1000 previously edited files
"  "1000 -> will save up to 1000 lines for each register
"  :1000-> up to 1000 lines of command-line history will be remembered
"  %    -> saves and restores the buffer list
"  n... -> where to save the viminfo files
set viminfo='1000,\"1000,:1000,%,n~/.viminfo
set history=10000 " New history size

" Reset cursor position:
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Use the mouse
set mouse=a

" Clipboard and yank
noremap <C-c> "+y  " Ctrl+c to copy to clipboard (only works when VIM is open)
" TODO: may define clipboard name
"set clipboard=unnamed
"set clipboard=unnamedplus

" Show trailing characters and undesirable spaces
set list
set listchars=tab:▸\ ,leadmultispace:│\ \ \ ,trail:·,multispace:·,nbsp:~,extends:→,eol:󰌑

" Remove trailing spaces when save buffer (except for diff or patch files)
autocmd BufWritePre * if index(['diff', 'patch'], &ft) < 0 | :%s/\s\+$//e | endif
" autocmd BufWritePre * :%s/\s\+$//e

set visualbell                      "audio bell is evil

" Explicit the character encoding
set encoding=utf-8

" Tab/spaces
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop

" Highlight To-dos
match Todo /\s\+$/

" Changes leader key from "\" to ","
let mapleader = " "
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" <TAB> completion in command-mode
set wildmenu
set wildmode=list:full

" A running gvim will always have a window title, but when vim is run within an
" xterm, by default it inherits the terminal’s current title.
set title

" When the cursor is moved outside the viewport of the current window, the
" buffer is scrolled by a single line. Setting the option below will start the
" scrolling three lines before the border, keeping more context around where
" you’re working.
set scrolloff=15

set hidden                     " Possibility to have more than one unsaved buffers.

" in the bottom right corner of the status line there will be something like:
" 529, 35 68%, representing line 529, column 35, about 68% of the way to the
" end.
set ruler

" better indentation
vnoremap > >gv
vnoremap < <gv

" Move tabs
nnoremap <C-h> :-tabmove<CR>
nnoremap <C-l> :+tabmove<CR>
nnoremap <C-f> :g//#<Left><Left>

" Main position for splits
set splitbelow
set splitright

" Tags
"set tags=./.tags;,.tags;
"TODO: configure tags creation (automatically) using universal-ctags and/or tree-sitter
"       <https://gist.github.com/turicas/a83ac50833b78707a306385de315de8f>

" TODO: add configs to easily change between buffers (like 'Junggling with buffers' in <https://stackoverflow.com/a/16084326/1299446>)
" TODO: add configs to fuzzy search (like 'Juggling with files' in <https://stackoverflow.com/a/16084326/1299446>)

" TODO: add configs to move lines, as in <https://stackoverflow.com/a/49053064/1299446>
