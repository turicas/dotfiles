" Nice color scheme:
colorscheme torte

" Show line numbers:
set number

" Highligh 80-column:
match ErrorMsg '\%>80v.\+'
set colorcolumn=80
set textwidth=79

" Highlight searches:
set hlsearch
set incsearch " dynamically as they are typed

" Highlight syntax:
syntax on

" Enable modeline so vim will reconfigure when open vim-configured files
set modeline

" Indentation and plugins
set autoindent
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

" Show line where you are:
" set cursorline

" Use the mouse
set mouse=a

" Ctrl+c to copy to clipboard (only works when VIM is open)
map <C-c> "+y<CR>

set listchars=tab:▸\ ,trail:·,nbsp:· list "list trailing characters
set showmatch                       "blink matching bracket, etc
set visualbell                      "audio bell is evil

set encoding=utf-8 "explicit

set background=light
highlight clear


set expandtab
set softtabstop=4
set shiftwidth=4

" Highlight trailing spaces
match Todo /\s\+$/

" Remove trailing spaces when save
autocmd BufWritePre * :%s/\s\+$//e

" Changes leader key from "\" to ","
let mapleader = ","

" <TAB> completion in command-mode
set wildmenu
set wildmode=list:longest

" These two options, when set together, will make /-style searches
" case-sensitive only if there is a capital letter in the search expression.
" *-style searches continue to be consistently case-sensitive.
set ignorecase
set smartcase


" A running gvim will always have a window title, but when vim is run within an
" xterm, by default it inherits the terminal’s current title.
set title

" When the cursor is moved outside the viewport of the current window, the
" buffer is scrolled by a single line. Setting the option below will start the
" scrolling three lines before the border, keeping more context around where
" you’re working.
set scrolloff=5

" in the bottom right corner of the status line there will be something like:
" 529, 35 68%, representing line 529, column 35, about 68% of the way to the
" end.
set ruler

" Shortcut to tasklist and taglist plugins
map T :TaskList<CR>
map L :TlistToggle<CR>
