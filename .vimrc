" Antenore Gatta .vimrc
" vim:set ts=2 sts=2 sw=2 expandtab:

" Consider https://github.com/askedrelic/homedir/blob/master/.vimrc

" I use pathogen to manage all the plugin, it's easier
" https://github.com/tpope/vim-pathogen 


" Pathogen {
" https://github.com/tpope/vim-pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on   
syntax on
" }
" General {
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" enable error files and error jumping
set cf               
" Use Vim settings, rather then Vi settings (much better!).
set nocompatible     
" Automatically save before :next, :make etc.
set autowrite        
" 1000 commands in the history
set history=1000     
" 1000 undo in the history
set undolevels=1000  
" read/write a .viminfo file, don't store more than 100
set viminfo='10,\"100,:20,%,n~/.viminfo 
" load filetype plugins
"filetype plugin indent on   
" load filetype indents
"filetype indent on   
" detect the type of file
" filetype on          
" more powerful backspacing
set backspace=indent,eol,start  
" indicates a fast terminal connection.
set ttyfast          
" Printing options such syntax and paper size
set printoptions=paper:A4,syntax:y 

" Omni completion
set ofu=syntaxcomplete#Complete

" Prevent Vim from clobbering the scrollback buffer. See
" (http://www.shallowsky.com/linux/noaltscreen.html)
" set t_ti= t_te=

" }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme/Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" active coloration
syntax enable
" 256 colors
set t_Co=256
set background=dark
" default coloration theme
colorscheme solarized
 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files/Backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" where to put backup file
set backup                   
" directory is the directory for temp file
set backupdir=~/.vim/backup/ 
" When using make, where should it dump the file
set directory=~/.vim/temp    
set makeef=error.err         
 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "{{{
 
 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "{{{
" Set terminal title to Vim + filename
set title        
" Show (partial) command in the last line of the screen.
set showcmd      
" show the cursor position all the time
set ruler        
" show line number
set number       
" the command bar is 2 high
set cmdheight=2  
" you can change buffer without saving
set hid          
" make backspace work normal
set backspace=2  
" tell us when anything is changed via :...
set report=0     
" don't make noise
set noerrorbells 
" don't make lights
set novisualbell 
" ignore case for searching
set ignorecase   

" Highlight if more then 88 chars
set colorcolumn=88
highlight ColorColumn ctermbg=white
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=black guibg=#592929
  "autocmd BufEnter * match OverLength /\%82v.*/
  autocmd BufEnter * match OverLength /\%89v.\+/
augroup END

" Folding settings
"fold based on indent
set foldmethod=marker
"deepest fold is 10 levels
set foldnestmax=10
"dont fold by default
"set nofoldenable
set foldenable
"this is just what i use
set foldlevel=1

 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "{{{
set ruler
" Highlight current line
set cursorline
"Highlight cursorline ONLY in the active window:
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline
" Scrolling
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
" show matching brackets
set showmatch     
" how many tenths of a second to blink matching brackets for
set mat=5         
" highlight searched for phrases
set hlsearch      
" highlight as you type you search phrase
set incsearch     
" For searches
set smartcase     
" Keep 10 lines (top/bottom) for scope
set so=10         
" don't blink
set novisualbell  
" no noise
set noerrorbells  
" always show the status line
set laststatus=2  
" display incomplete commands
set showcmd       
" display the current mode
set modeline      
" keep the cursor in the same colon when changing line
set nostartofline 
" Show special chars
set listchars=tab:>-,trail:~
set listchars=tab:>-
set listchars+=trail:.
 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" menu completion
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu 
" Not sure I need this
set wildchar=<Tab>
 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" See Help (complex)
set fo=tcrqn      
" autoindent
set ai            
" smartindent
set si            
" do c-style identing
set cindent       
" TO SWITCH OFF PASTE AND AVOID INDENTATION
set pastetoggle=<F2>
" To paste from another application:
"
"    Start insert mode.
"    Press F2 (toggles the 'paste' option on).
"    Use your terminal to paste text from the clipboard.
"    Press F2 (toggles the 'paste' option off). 
"
" tab spacing
set tabstop=4     
" 2 spaces when pressing <tab> unify
set softtabstop=4 
" unify
set shiftwidth=4  
" real tabs please!
"set noexpandtab  
" For pythonysm
set expandtab     
" use tabs at the start of a line, spaces elsewhere
set smarttab      
" No wrap lines
set nowrap        
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
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
 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "{{{
let perl_extended_vars=1 " highlight advanced perl vars inside strings
 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
autocmd FileType text setlocal textwidth=80

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
\ if expand("<afile>:p:h") !=? $TEMP |
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\ let JumpCursorOnEdit_foo = line("'\"") |
\ let b:doopenfold = 1 |
\ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
\ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
\ let b:doopenfold = 2 |
\ endif |
\ exe JumpCursorOnEdit_foo |
\ endif |
\ endif
" Need to postpone using "zv" until after reading the modelines.
autocmd BufWinEnter *
\ if exists("b:doopenfold") |
\ exe "normal zv" |
\ if(b:doopenfold > 1) |
\ exe "+".1 |
\ endif |
\ unlet b:doopenfold |
\ endif

" Auto load/save view (useful for folding)
au BufWinLeave * mkview
au BufWinEnter * silent loadview

 "}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
command! Q  quit
command! W  write
command! Wq wq
" Remap ctrl-] to Enter and ctrl-T to esc to make help sane.
:au filetype help :nnoremap <buffer><CR> <c-]>
:au filetype help :nnoremap <buffer><BS> <c-T>
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Switch window mappings /*{{{*/
nnoremap <C-Up> :normal <c-r>=SwitchWindow('+')<CR><CR>
nnoremap <C-Down> :normal <c-r>=SwitchWindow('-')<CR><CR>
nnoremap <C-Left> :normal <c-r>=SwitchWindow('<')<CR><CR>
nnoremap <C-Right> :normal <c-r>=SwitchWindow('>')<CR><CR>

function! SwitchWindow(dir)
  let this = winnr()
  if '+' == a:dir
    execute "normal \<c-w>k"
    elseif '-' == a:dir
    execute "normal \<c-w>j"
    elseif '>' == a:dir
    execute "normal \<c-w>l"
    elseif '<' == a:dir
    execute "normal \<c-w>h"
  else
    echo "oops. check your ~/.vimrc"
    return ""
  endif
endfunction
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" http://wiki.python.org/moin/ViImproved
autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py set ai
au BufEnter,BufRead *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim Powerline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash Support Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
let g:BASH_AuthorName   = 'Antenore Gatta'
let g:BASH_Email        = ''
let g:BASH_Company      = 'IBM Switzerland'
"}}}

