" Mike's vim

" Sets how many lines of history vim has to remember
set history=1000

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to automatically update file if changed from external source
set autoread
au FocusGained,BufEnter * checktime

" Handle permission denied for write
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Avoid garbled non-english chars
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on wildmenu
set wildmenu
set wildmode=longest:list,full

" Ingore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Allow mouse navigation
set mouse=a

" Highlight cursor position
set ruler
set cursorline

" Show line numbers
set number

" Make cursor a line instead of block
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fix backspace issues
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" Smart search cases
set smartcase

" Highlight search results
set hlsearch

" Incrememnt through search results
set incsearch

" Show matching brackets
set showmatch

" Remove sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add extra left margin
set foldcolumn=1

" Enable syntax highlighting
syntax enable

" Set regex engine automatically
set regexpengine=0

" Enable 256 color palette in gnome terminal
if !has('gui_running')
	set t_Co=256
endif

" Set colorscheme
try
	colorscheme slate
catch
endtry

set background=dark

" Set UTF-8 encoding
set encoding=UTF-8

" Use unix as standard file type
set ffs=unix,dos,mac

" Turn backup off
set nobackup
set nowb
set noswapfile

" Expand tabs to spaces
set expandtab

" Smartly use tabs (i.e. for Makefiles)
set smarttab

" Set 1 tab to 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

" Set indentation rules
set ai
set si
set wrap

" Delete trailing whitespace on save
fun! CleanTrailingWhitespace()
	let save_cursor = getpos('.')
	let old_query = getreg('/')
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfun

if has("autocmd")
	autocmd BufWritePre *.txt,*.html,*.js,*.ts,*.py,*.java,*.wiki,*.sh,*.coffee,*.c,*.cs,*.cpp,*.s,*.S,*.asm :call CleanTrailingWhitespace()
endif

" Pressing ,ss will toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Add single/block comments with Ctrl+/
fun! Comment()
    let line = getline('.')

    " For Python files:
    if (&ft == 'py')
        let cstr = '#'
    " For Assembly files:
    elseif (&ft == 's' || &ft == 'S' || &ft == 'asm')
        let cstr = ';'
    " For vim/vimrc files
    elseif (&ft == 'vimrc' || &ft == 'vim')
        let cstr = '"'
    " conf+ files, add special cases as needed
    elseif (&ft == 'sh' || &ft == 'conf' || &ft == 'hyprlang' || &ft == 'tmux')
        let cstr = '#'
    " Otherwise default comment is //
    else
        let cstr = '//'
    endif

    let regex_str = '^' . cstr
    if line =~ regex_str
        exec 's!' . regex_str . '!!'
    else
        exec 's!^!' . cstr . '!'
    endif
endfun

nnoremap <C-/> :call Comment()<CR>$
nnoremap <C-_> :call Comment()<CR>$
vnoremap <C-/> :call Comment()<CR>$
vnoremap <C-_> :call Comment()<CR>$
inoremap <C-/> <ESC>:call Comment()<CR>$i
inoremap <C-_> <ESC>:call Comment()<CR>$i

" Shift tab will unindent by one tab its block or line
inoremap <S-Tab> <C-d>
vnoremap <S-Tab> <gv
nnoremap <S-Tab> <gv

" Tab in visual mode will indent one tab
vnoremap <Tab> >gv
nnoremap <Tab> >gv

" Auto-complete braces/brackets
inoremap { {}<Esc>ha
inoremap {} {}<Esc>ha
inoremap {<CR> {<CR>}<Esc>ko
inoremap ( ()<Esc>ha
inoremap () ()<Esc>ha
inoremap (<CR> (<CR>)<Esc>ko
inoremap [ []<Esc>ha
inoremap [] []<Esc>ha
inoremap [<CR> [<CR>]<Esc>ko
"inoremap ' ''<Esc>ha
inoremap '' ''<Esc>ha

inoremap "" ""<Esc>ha
"inoremap ` ``<Esc>ha
inoremap `` ``<Esc>ha

call plug#begin()

" List of plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'

call plug#end()

" Settings for coc
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Settings for lightline
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'one' }

" Settings for ALE
let g:ale_linters = {
            \ 'c': ['gcc'],
            \ 'cpp': ['gcc'],
            \ 'ts': ['eslint']
            \}
let g:ale_c_gcc_options = '-std=c11 -Wall'
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1
