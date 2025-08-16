set nocompatible          " Disable Vi compatibility
filetype on               " Enable filetype detection
filetype plugin on        " Enable loading filetype plugins
filetype indent on        " Enable filetype-specific indentation
syntax on                 " Enable syntax highlighting
set number                " Show line numbers
set relativenumber        " 'tis really helpful
set cursorline            " Highlight the current line
set nowrap                " Do not wrap long lines

set shiftwidth=4          " 4 spaces indentation
set tabstop=4             " A tab counts as 4 spaces
set expandtab             " Convert tabs to spaces
set nobackup              " Do not create backup files
set scrolloff=10          " Keep 10 lines visible when scrolling

set incsearch             " Incremental search (highlight as you type)
set ignorecase            " Case-insensitive search by default
set hlsearch              " Highlight all search matches

set showcmd               " Show incomplete commands in the bottom bar
set noshowmode              " Display the current mode
set showmatch             " Highlight matching parentheses/brackets

set history=1000          " history is important 
set wildmenu              " Enhanced command-line completion
set wildmode=list:longest " Auto-complete with longest match first
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " Ignore unnecessary files in completion


if has("termguicolors")
    set termguicolors
endif

" --- Color Scheme ---
colorscheme archery       " I use Arch btw
set bg=dark               " Set background to dark


" TRANSPARENCY --------------------------------------------------- {{{

function! TransparentBackground()
    hi Normal        ctermbg=NONE guibg=NONE
    hi NonText       ctermbg=NONE guibg=NONE
    hi LineNr        ctermbg=NONE guibg=NONE
    hi EndOfBuffer   ctermbg=NONE guibg=NONE
    hi StatusLine    ctermbg=NONE guibg=NONE
    hi StatusLineNC  ctermbg=NONE guibg=NONE
    hi SignColumn    ctermbg=NONE guibg=NONE
    hi VertSplit     ctermbg=NONE guibg=NONE
    hi Pmenu         ctermbg=NONE guibg=NONE
    hi TabLine       ctermbg=NONE guibg=NONE
    hi TabLineFill   ctermbg=NONE guibg=NONE
endfunction

autocmd ColorScheme * call TransparentBackground()
call TransparentBackground()

" }}}


" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

call plug#begin('~/.vim/plugged')


  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'junegunn/fzf.vim'

  Plug 'itchyny/lightline.vim'

  Plug 'andymass/vim-matchup'


call plug#end()

" }}}


" PLUGIN CONFIGURATIONS  ------------------------------------------------- {{{

" fzf configuration

let g:fzf_layout = { 'window': { 'width': 0.75, 'height': 0.7, 'yoffset': 0.5, 'xoffset': 0.5, 'border': 'sharp' } }

let g:fzf_preview_window = ['right:60%', 'ctrl-/']

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

let mapleader = "\\"

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>p :%w !lp<CR>

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" :terminal opens a terminal buffer in a split window
" !python3 % executes the current file with Python.

" nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>
nnoremap <F5> :w<CR>:terminal python3 %<CR>


" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
let NERDTreeShowHidden=1
nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$', '\.swp$']


" --- FZF Key Mappings ---

" Ctrl + p →  Search and open files in the current working directory
nnoremap <C-p> :Files<CR>

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline nocursorcolumn
augroup END

" If GUI version of Vim is running set these options.
if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme archery

    " Set a custom font you have installed on your computer.
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size>
    set guifont=Monospace\ Regular\ 12

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the right-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>

endif

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" I have provided personalized statusline as well as the lightline version.
" You can use either of them by commenting out the other one.
" I personally use the lightline one for arch color theme...


" ---------------- PERSONALIZED STATUS LINE ----------------------

""  If you're using this, comment out the lightline configuration and the lighline plugin in the plugin section.
"
"function! GitBranch()
"    if !isdirectory(".git") && system('git rev-parse --is-inside-work-tree 2>/dev/null') !~# 'true'
"        return ''
"    endif
"    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"endfunction
"
"function! StatuslineGit()
"    let l:branchname = GitBranch()
"    return strlen(l:branchname) > 0 ? ' '.l:branchname : ''
"endfunction
"
"augroup NerdTreeStatusline
"    autocmd!
"    autocmd FileType nerdtree setlocal statusline=0
"augroup END
"
"" Clear status line when vimrc is reloaded.
"set statusline=
"
"set statusline+=%#PmenuSel#
"set statusline+=\%{StatuslineGit()}
"set statusline+=%*
"
"" Status line left side.
"set statusline+=\ %F\ %M\ %Y\ %R
"
"" Use a divider to separate the left side from the right side.
"set statusline+=%=
"
"" Status line right side.
"set statusline+=\ ascii:\ %b\ row:\ %l\ col:\ %c\ percent:\ %p%%
"set statusline+=\[%{&fileformat}\]
"
"" Show the status on the second to last line.
"set laststatus=2

" ----------------- END OF PERSONALIZED STATUS LINE ------------------------


" ----------------------- LIGHTLINE STATUS LINE ----------------------------

" if you're using this, comment out the personalized statusline configuration.

" Show the status on the second to last line.
set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'archery',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" ----------------- END OF LIGHTLINE CONFIGURATION  ------------------------


" }}}
