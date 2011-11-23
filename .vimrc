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

" Highlight syntax:
syntax on

" Enable modeline so vim will reconfigure when open vim-configured files
set modeline

" Indentation
set autoindent
filetype indent plugin on

" Tell vim to remember certain things when we exit
"  '10  -> marks will be remembered for up to 10 previously edited files
"  "100 -> will save up to 100 lines for each register
"  :20  -> up to 20 lines of command-line history will be remembered
"  %    -> saves and restores the buffer list
"  n... -> where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

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
set cursorline

" Use the mouse
set mouse=a

" Ctrl+c to copy to clipboard (only works when VIM is open)
map <C-c> "+y<CR>


" set listchars=tab:▸\ ,trail:·,nbsp:· list "list trailing characters
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
autocmd BufWritePre *.py :%s/\s\+$//e
