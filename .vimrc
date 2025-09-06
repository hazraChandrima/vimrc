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
set nowritebackup
set scrolloff=10          " Keep 10 lines visible when scrolling

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

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
colorscheme tender       " I use Arch btw
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


  Plug 'neoclide/coc.nvim', {'branch': 'release'}

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


" ---------- Coc Floating Window Colors ----------
" Floating window background + text
highlight CocFloating guibg=#282828 guifg=#eeeeee

" Border of the floating window
highlight CocFloatingBorder guibg=#282828 guifg=#444444

" Completion popup menu
highlight Pmenu guibg=#383838 guifg=#eeeeee
highlight PmenuSel guibg=#585858 guifg=#ffffff

" Diagnostics inside floating windows
highlight CocErrorFloat guibg=#282828 guifg=#ff6c6b
highlight CocWarningFloat guibg=#282828 guifg=#ECBE7B
highlight CocInfoFloat guibg=#282828 guifg=#51afef
highlight CocHintFloat guibg=#282828 guifg=#98be65


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


" ----------------- MAPPINGS FOR LSP SUPPORT BY coc.nvim -------------------

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


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
    colorscheme tender

    " Set a custom font you have installed on your computer.
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size>
    set guifont=Inconsolata\ Nerd\ Font\ Mono:h12

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
" I personally use the lightline one because it provides matching color schemes and is much cleaner


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
      \ 'colorscheme': 'tender',
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
