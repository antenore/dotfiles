"================================ .VIMRC ===========================================
"===================================================================================

" {{{ ===== Pathogen ===============================================================
execute pathogen#infect()
syntax enable
filetype plugin indent on     " }}}
" {{{ ===== Files ==================================================================
set viminfo='10,\"1000,:20,%,n~/.viminfo 
set backup                   
set backupdir=~/.vim/backup/ 
set directory=~/.vim/temp    
set makeef=error.err         "}}}
" {{{ ===== General ================================================================
set encoding=utf-8
syntax on
let mapleader = ","
set autoread
set autowrite
set backspace=indent,eol,start
set browsedir  =current   " which directory to use for the file browser
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=2000
set ignorecase
set nocompatible
set noerrorbells
set novisualbell
set printoptions=paper:A4,syntax:y 
set report=0                         " tell us when anything is changed via :...
set undolevels=1000
set ofu=syntaxcomplete#Complete      " Omni completion
set completeopt=longest,menuone      " }}}
" {{{ ===== Folfing ================================================================
set foldmethod=marker                " }}}
" {{{ ===== Menus ==================================================================
set wildmode=longest,list
set wildmenu
set wildchar=<Tab>                   " }}}
" {{{ ===== UI =====================================================================

set t_Co=256
set background=dark
" Solarized - https://github.com/altercation/solarized
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
  let g:solarized_termcolors=256    " Default 16
  let g:solarized_termtrans=1
  let g:solarized_visibility="high"
  let g:solarized_hitrail=1
  colorscheme solarized " Load a colorscheme
endif

" Highlight if more then 88 chars
set colorcolumn=88
hi CursorColum ctermbg=grey ctermfg=white
highlight ColorColumn ctermbg=red ctermfg=white
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter * match OverLength /\%89v.\+/
augroup END

" Visual Cues
set cmdheight=2
set cursorline
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
set hlsearch      
set incsearch     
set laststatus=2   " always show the status line
set listchars+=trail:.
set listchars=tab:>-
set listchars=tab:>-,trail:~
set mat=5          " how many tenths of a second to blink matching brackets for
set modeline      
set nostartofline  " keep the cursor in the same colon when changing line
set number
set ruler
set scrolloff=3
set showcmd
set showmatch      " show matching brackets
set sidescroll=1
set sidescrolloff=10
set smartcase     
set so=10          " Keep 10 lines (top/bottom) for scope
set title                           " }}}

" ======================== Text Formatting/Layout ==================================
set fo=rqn     " :h formatoptions 
set ai            
set si            
set cindent       
set tabstop=4     
set softtabstop=4 
set shiftwidth=4  
set expandtab     
set smarttab      
set nowrap        
set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current
" =============================== Mappings =========================================

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
				
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Remap ctrl-] to Enter and ctrl-T to esc to make help sane.
:au filetype help :nnoremap <buffer><CR> <c-]>
:au filetype help :nnoremap <buffer><BS> <c-T>

" Switching buffer mapping
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Useful functions keys
set pastetoggle=<F2>
map <F11> :let &bg = ( &bg = "dark"? "light" : "dark" )<CR>   # shitch dark lingh bg

" ================= Bash Support Plugin ============================================
let g:BASH_MapLeader                = ','
let g:BASH_DoOnNewLine              = 'yes'
let g:BASH_LineEndCommColDefault    = 49
let g:BASH_AuthorName               = 'Antenore Gatta'
let g:BASH_Email                    = ''
let g:BASH_Company                  = 'IBM Switzerland'

" =============================== EOF ==============================================
" vim:set ts=2 sts=2 sw=2 expandtab:
