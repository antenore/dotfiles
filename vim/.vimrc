"================================ .VIMRC ===========================================
" Feautures:
" - Conditional folding
" - Pathogen
" - Solarized (+ HI cutomizations)
" - Bash-support
" - Vim-Airline
"===================================================================================

" {{{ ===== Before everything else =================================================
set nocompatible
filetype plugin indent on
set foldenable
set foldmethod=marker
au FileType sh let g:sh_fold_enabled=7
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
syntax enable
" }}}
" {{{ ===== Pathogen ===============================================================
call pathogen#infect()
call pathogen#helptags()
" }}}
" {{{ ===== Files ==================================================================
set viminfo='10,\"1000,:20,%,n~/.viminfo
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/temp
set makeef=error.err
" }}}
" {{{ ===== General ================================================================
set encoding=utf-8
let mapleader = ","
set autoread
set autowrite
set backspace=indent,eol,start
set browsedir=current   " which directory to use for the file browser
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
set undolevels=1000
set ofu=syntaxcomplete#Complete      " Omni completion
set completeopt=longest,menuone
" }}}
" {{{ ===== Text Formatting/Layout =================================================
set fo=ctrqn   " :h formatoptions fo-table
set ai
set si
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set nojoinspaces
set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current
set nowrap
set wm=0       " wrapping margin
set tw=500       " no autowrap
" }}}
" {{{ ===== Menus ==================================================================
set wildmenu
set wildmode=list:longest,full
set wildchar=<Tab>
" }}}
" {{{ ===== UI =====================================================================

" Tabs
set tabpagemax=15
set showtabline=2
set t_Co=256
set background=dark
" Solarized - https://github.com/altercation/solarized

if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="high"
    color solarized " Load a colorscheme
endif
"colorscheme neverland
"colorscheme xoria256
"colorscheme hybrid

" Highlight if more then 88 chars
set colorcolumn=99
highlight ColorColumn ctermbg=red ctermfg=white
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufEnter * match OverLength /\%100v.\+/

" Visual Cues
set cmdheight=2
"hi Folded term=bold cterm=bold ctermfg=8 ctermbg=14
"hi Folded term=bold cterm=bold ctermfg=cyan ctermbg=black
set cursorline
"hi CursorLine term=underline,bold cterm=underline,bold ctermbg=235 ctermfg=NONE guibg=Grey40
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline
set cursorcolumn
"hi CursorColumn term=reverse ctermbg=233
hi CursorColumn term=reverse ctermbg=234 ctermfg=white
au WinEnter * setlocal cursorcolumn
au WinLeave * setlocal nocursorcolumn
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;white\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;orange\x7"
  silent !echo -ne "\033]12;orange\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif
if &term =~ "xterm\\|rxvt"
  " solid underscore
  let &t_SI .= "\<Esc>[6 q"
  " solid block
  let &t_EI .= "\<Esc>[6 q"
  " 1 or 0 -> blinking block
  " 2 -> solid underscore
  " 3 -> blinking underscore
  " 4 -> solid block
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif
set hlsearch
set incsearch
set laststatus=2   " always show the status line
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set mat=5          " how many tenths of a second to blink matching brackets for
set modeline       " in source settings --> # vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
set nostartofline  " keep the cursor in the same colon when changing line
set number
set scrolloff=3
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)       " if not vim-airline
set showcmd
set showmatch      " show matching brackets
set sidescroll=1
set sidescrolloff=10
set smartcase
set so=10          " Keep 10 lines (top/bottom) for scope
set title
" }}}
" {{{ ===== Language specific settings ===========================================================
" Python
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead \.psafe highlight Folded term=reverse cterm=reverse
" }}}
" {{{ ===== Mappings ===============================================================


" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Tabs
nmap <C-S-t> :tabnew<CR>
nmap <C-S-n> :tabn<CR>
nmap <C-S-p> :tabp<CR>


map <F11> :let &bg = ( &bg = 'dark' ? 'light' : 'dark' )<CR>   # shitch dark lingh bg

"Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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
:au FileType help nnoremap <buffer> <CR> <c-]>
:au FileType help nnoremap <buffer> <BS> <c-T>

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
set pastetoggle=<F12>
map <F11> :let &bg = ( &bg == 'dark'? 'light' : 'dark' )<CR>
" }}}
" {{{ ===== Bash Support Plugin ====================================================
let g:BASH_MapLeader                = ','
let g:BASH_DoOnNewLine              = 'yes'
let g:BASH_LineEndCommColDefault    = 49
let g:BASH_AuthorName               = 'Antenore Gatta'
let g:BASH_Email                    = ''
let g:BASH_Company                  = 'IBM Switzerland'
" }}}
" {{{ Vim Shugo stuff
" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }
" neosnippet
imap <C-S-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-S-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-S-k>     <Plug>(neosnippet_expand_target)
xmap <C-S-l>     <Plug>(neosnippet_start_unite_snippet_target)

" This brake my Super Tab
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ? " SuperTab like snippets behavior.
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Vim-shell
let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
let g:vimshell_max_command_history = 90000
let g:vimshell_scrollback_limit = 5000
" ̣}}}
" =============================== EOF ==============================================
" vim:set ts=2 sts=2 sw=2 expandtab:
