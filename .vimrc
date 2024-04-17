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
set relativenumber

" 120-th column limit
set textwidth=119
set colorcolumn=+1


" Highlight searches:
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" Enable modeline so vim will reconfigure when open vim-configured files
set modeline

" plugins
filetype on
filetype indent on
filetype plugin on

" Tell vim to remember certain things when we exit
"  '10  -> marks will be remembered for up to 10 previously edited files
"  "100 -> will save up to 100 lines for each register
"  :20  -> up to 20 lines of command-line history will be remembered
"  %    -> saves and restores the buffer list
"  n... -> where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
set history=1000 " New history size

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

" Ctrl+c to copy to clipboard (only works when VIM is open)
noremap <C-c> "+y

" Show trailing characters and undesirable spaces
set list
set listchars=tab:▸\ ,trail:·,nbsp:~,extends:→

" Remove trailing spaces when save buffer
autocmd BufWritePre * :%s/\s\+$//e

set showmatch                       "blink matching bracket, etc
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
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
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
