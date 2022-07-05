" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

set encoding=utf-8

" Colors !!
"set background=dark
"colorscheme gruvbox

" Enable syntax highlighting
syntax on
filetype plugin on
filetype indent on

" Give Vim access to more colors
set termguicolors

" Share system clipboard
set clipboard=unnamedplus

" Enable tab completion like Bash
set wildmode=longest,list,full
set wildmenu

" Enable mouse support
set mouse=a

" Traverse line breaks with arrow keys
set whichwrap=b,s,<,>,[,]

" Show line numbers as relative. Show actual line number of active line.
set relativenumber
set number

" Show line number and character number at lower right hand corner.
set ruler

" Tell Vim not to redraw screen during important tasks
set lazyredraw

" Bracket matching
set showmatch

" Start highlighting search term while typing
set incsearch

" Highlight search results
set hlsearch

" Tell Vim to stop highlighting after search ":noh". Map it to Esc+Space
nnoremap <esc><space> :nohlsearch<cr>

" Enable spell checking
set spell

" Spell lang
set spelllang=en_us

" Show 9 best spell-checking candidates at most
set spellsuggest=best,9

" Use F11 to toggle spell-checking
nnoremap <silent><F11> :set spell!<cr>
inoremap <silent><F11><C-O> :set spell!<cr>

" In INSERT mode, Vim underlines miss-spelled word. Press <C-x> to correct
" this error. Press <s> subsequently, to list out possible corrections.
" In NORMAL mode, to navigate spell errors press <[s> to go to previous error,
" <]s> to go to next error.
" Built-in spell-checker is not perfect. Press <zg> to add word to spell file.
" Press <z=> to correct a word. A list of possible corrections is shown.
" Enter a number to select one. 
