" $HOME/.vim/init/general.vimrc
let g:mapleader = ','
"Let vim automatically load .vimrc found on folders
set exrc
"with clipboard=autoselect visual selection should go automatically into primary
"in case of needs I can user registers "+y
set clipboard=autoselect
set regexpengine=1
set autoread
set autowrite
set backspace=indent,eol,start
set browsedir=current
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=2000
set ignorecase
set noerrorbells
set novisualbell
set printoptions=paper:A4,syntax:y
set report=0                         " tell us when anything is changed via :...
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000
set undoreload=10000        " number of lines to save for undo
set wildmenu
set wildmode=list:longest,full
set wildchar=<Tab>
set grepprg=grep\ -nH\ $*
