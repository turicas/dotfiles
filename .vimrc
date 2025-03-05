" # Álvaro Justen's VIM configuration <https://github.com/turicas/dotfiles/>

" ## System requirements: apt install git universal-ctags ripgrep
" ## Global configurations

" If a .vimrc is present (even if empty), Vim disables the `defaults.vim`, which has good defaults
" <https://stackoverflow.com/questions/59788781/vim-overrides-default-settings-when-adding-new-vimrc-file>
runtime defaults.vim
set nomodeline
set tags=./.tags;,$HOME/.tags; " Try to find `.tags` in current directory or in parent ones; if not found, use from $HOME
let g:func_cache = {}
let g:filetypes_to_preserve_whitespace = ['diff', 'patch']
let g:mapleader = "\ "


" ## Utility functions
function FuncCacheCall(func, args)
    let l:key = string(a:func) . ":" . string(a:args)
    if has_key(g:func_cache, l:key)
        return g:func_cache[l:key]
    endif
    let l:result = call(a:func, a:args)
    let g:func_cache[l:key] = l:result
    return l:result
endfunction

function TrimWhiteSpace()
    " Remove trailing spaces and empty lines in the end of the file (except for binary, diff or patch files)
    if &binary == 0 && index(g:filetypes_to_preserve_whitespace, &filetype) < 0
        mkview
        silent! keeppatterns keepjumps %s/\s\+$//e
        silent! keeppatterns keepjumps %s/\($\n\s*\)\+\%$//e
        loadview
    endif
endfunction

function Benchmark(func, args, runs)
    " Run `func` with `args` for `runs` times and calculate the average time spent
    let l:total = 0
    for i in range(a:runs)
        let l:start = reltime()
        call call(a:func, a:args)
        let l:end = reltime(l:start)
        let l:total += str2float(reltimestr(l:end))
    endfor
    return l:total / a:runs
endfunction

function GitRootNoCache(path)
    " Return the root path of a git repository if inside one, or empty string if not.
    let l:git_cmd = ['git', '-C', shellescape(a:path)]
    if trim(system(join(git_cmd + ['rev-parse', '--is-inside-work-tree']))) == 'true'
        return trim(system(join(git_cmd + ['rev-parse', '--show-toplevel'])))
    else
        return ''
    endif
endfunction
function GitRoot(path)
    return FuncCacheCall("GitRootNoCache", [a:path])
endfunction

function ListProjectFilesCommand()
    " Return the git command to list all git tracked files if inside a repository. If not, returns `rg --files`.
    " The git command will return all tracked files, no matter if file is not directly in the root repository path.
    let l:current_path = expand('%:p:h')
    let l:git_root = GitRoot(l:current_path)
    if !empty(l:git_root)
        return ['git', '-C', shellescape(l:git_root), 'ls-files']
    else
        return ['rg', '--files', shellescape(l:current_path)]
    endif
endfunction

function GenerateProjectTags()
    " Generate tags file if inside git repository
    let l:list_files_cmd = ListProjectFilesCommand()
    if l:list_files_cmd[0] == 'git'
        let l:git_root = GitRoot(expand('%:p:h'))
        let l:tags_file = l:git_root . '/.tags'
        let l:cmd = ['cd', shellescape(l:git_root)]
        let l:cmd += ['&&'] + l:list_files_cmd
        let l:cmd += ['|', 'ctags', '-L', '-', '--tag-relative=yes', '--quiet', '--append', '-f', shellescape(l:tags_file)]
        call system(join(l:cmd) . '&')
        " XXX: may use tree-siter instead of ctags <https://gist.github.com/turicas/a83ac50833b78707a306385de315de8f>
    endif
endfunction

function FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . ' | fzy')
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction


" ## General configurations
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

" ## Colors
highlight clear " Reset all highlighting to the defaults
set background=dark
colorscheme slate
autocmd ColorScheme * highlight ColorColumn term=reverse cterm=reverse gui=reverse
autocmd ColorScheme * highlight Normal ctermbg=black ctermfg=white guifg=white guibg=black
autocmd ColorScheme * highlight NonText guifg=#707070 guibg=NONE gui=NONE ctermfg=darkgrey ctermbg=NONE cterm=NONE
set termguicolors
syntax on " Syntax highlight
match Todo /\s\+$/ " Highlight To-dos

" ## Status line
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

" ## <TAB> completion in command-mode
set wildmenu
set wildmode=longest:full,full

" ## Search
set showmatch " Show matching parenthesis
set hlsearch " highlight search terms
set incsearch " show search matches as you type
set ignorecase " ignore case when searching
set smartcase " ignore case if search pattern is all lowercase, case-sensitive otherwise
" Clear search highlight:
nnoremap <Leader>/ :nohlsearch<CR>
" Search and show all occurrences:
nnoremap <C-f> :g//#<Left><Left>

" ## Indentation
vnoremap > >gv
vnoremap < <gv

" ## Plugins
filetype plugin indent on
if !has('nvim')
    packadd editorconfig
    packadd comment
endif

" ## History
" Tell vim to remember certain things when we exit
"  '1000 -> marks will be remembered for up to 1000 previously edited files
"  "1000 -> will save up to 1000 lines for each register
"  :1000-> up to 1000 lines of command-line history will be remembered
"  %    -> saves and restores the buffer list
"  n... -> where to save the viminfo files
if !has('nvim')
    set viminfo='1000,\"1000,:1000,%,n~/.viminfo
else
    set viminfo='1000,\"1000,:1000,%
endif
set history=10000 " New history size

" ## Clipboard and yank
noremap <C-c> "+y " Ctrl+c to copy to clipboard (only works when VIM is open)
" TODO: may define clipboard name
"set clipboard=unnamed
"set clipboard=unnamedplus

" ## Tabs (not `\t`s) and buffers
nnoremap <C-h> :-tabmove<CR>
nnoremap <C-l> :+tabmove<CR>
" Go to file (in a new tab):
nnoremap <C-w>gf :tabedit <cfile><CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" ## Tabs (`\t`s) and spaces
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
" Show trailing characters and undesirable spaces
set list
set listchars=tab:▸\ ,leadmultispace:│\ \ \ ,trail:·,multispace:·,nbsp:~,extends:→,eol:󰌑

" ## File management
" Open files inside project
nnoremap <leader>o :call FzyCommand(join(ListProjectFilesCommand()), ':tabedit')<CR>

" Save view before closing and restores after opening (view includes cursor position)
autocmd BufLeave,BufWinLeave * if &filetype !=# 'gitcommit' | silent! mkview | endif
autocmd BufReadPost * if &filetype !=# 'gitcommit' | silent! loadview | endif
autocmd BufWritePre * call TrimWhiteSpace()
autocmd BufWritePost * call GenerateProjectTags()

" TODO: add a snippet system
" TODO: search file contents (run `rg` inside vim) + quickfix list
" TODO: add configs to fuzzy search (like 'Juggling with files' in <https://stackoverflow.com/a/16084326/1299446>)
" TODO: add configs to easily change between buffers (like 'Junggling with buffers' in <https://stackoverflow.com/a/16084326/1299446>)
" TODO: add configs to move lines, as in <https://stackoverflow.com/a/49053064/1299446>
