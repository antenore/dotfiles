"================================ .VIMRC =======================================
" Feautures:
" - Conditional folding
" - Pathogen
" - Solarized (+ HI cutomizations)
" - Bash-support
" - Vim-Airline
"===============================================================================
" {{{ ===== Before everything else =============================================
set nocompatible
filetype plugin indent on
set foldenable
set foldmethod=marker
au FileType sh let g:sh_fold_enabled=7
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
syntax enable
" }}}
" {{{ ===== Pathogen ===========================================================
call pathogen#infect()
call pathogen#helptags()
" }}}
" {{{ ===== Files ==============================================================
set viminfo='10,\"1000,:20,%,n~/.viminfo
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/temp
set makeef=error.err
" }}}
" {{{ ===== General ============================================================
set encoding=utf-8
let mapleader = ","
"with clipboard=autoselect visual selection should go automatically into primary
"in case of needs I can user registers "+y
set clipboard=autoselect
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
set viminfo='10,\"1000,:20,%,n~/.viminfo
" }}}
" {{{ ===== Functions =============================================
"A mapping to make a backup of the current file.
function! WriteBackup()
  let l:fname = expand('%:p') . '__' . strftime('%Y%m%d%H%M')
  silent execute 'write' l:fname
  echomsg 'Wrote' l:fname
endfunction
" }}}
" {{{ ===== Text Formatting/Layout =============================================
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
"set fo+=qn     " :h formatoptions fo-table
set wm=0       " wrapping margin
set tw=0       " no autowrap
" }}}
" {{{ ===== Text Highlighting ==================================================
highlight LeadingTab ctermbg=blue guibg=blue
highlight LeadingSpace ctermbg=darkgreen guibg=darkgreen
highlight EvilSpace ctermbg=darkred guibg=darkred
au Syntax * syn match LeadingTab /^\t\+/
au Syntax * syn match LeadingSpace /^\ \+/
au Syntax * syn match EvilSpace /\(^\t*\)\@<!\t\+/ " tabs not preceeded by tabs
au Syntax * syn match EvilSpace /[ \t]\+$/ " trailing space
" }}}
" {{{ ===== Menus ==============================================================
set wildmenu
set wildmode=list:longest,full
set wildchar=<Tab>
" }}}
" {{{ ===== Airline ============================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 0 "change 0 to 1 if you have a powerline font
let g:airline_powerline_fonts=1
" set laststatus=2
" }}}
" {{{ ===== UI =================================================================

" Tabs
set tabpagemax=15
set showtabline=2
set t_Co=256
set background=dark
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        color solarized                 " load a colorscheme
    endif
        let g:solarized_termtrans=1
        let g:solarized_termcolors=256
        let g:solarized_contrast="high"
        let g:solarized_visibility="high"
"let g:hybrid_use_Xresources = 1
"colorscheme hybrid
"colorscheme neverland
"colorscheme xoria256
"colorscheme wombat256
"colorscheme gruvbox
"  let g:gruvbox_termcolors = 256
"  if !has("gui_running")
"     let g:gruvbox_italic=0
"  endif
"    nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
"    nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
"    nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
"
"    nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
"    nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
"    nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
"colorscheme hybrid
"colorscheme hemisu
"colorscheme lucius
"  LuciusBlack

"colorscheme hydra

" Highlight if more then 88 chars
set colorcolumn=81
highlight ColorColumn term=reverse cterm=reverse
"highlight OverLength term=reverse cterm=reverse
"autocmd BufEnter * highlight OverLength term=reverse cterm=reverse
"autocmd BufEnter * match OverLength /\%82v.\+/

" Visual Cues
set cmdheight=2
set cursorline
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline
set cursorcolumn
"hi CursorColumn term=reverse ctermbg=234 ctermfg=white
au WinEnter * setlocal cursorcolumn
au WinLeave * setlocal nocursorcolumn
if &term =~ "xterm\\|rxvt\\|screen-it\\|screen"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;white\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;orange\x7"
  silent !echo -ne "\033]12;orange\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif
if &term =~ "xterm\\|rxvt\\|screen-it\\|screen"
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
" {{{ ===== Language specific settings =========================================
" Python
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead *.c,*h set cindent ts=8 st=8 sw=8 noexpandtab
" }}}
" {{{ ===== Mappings ===========================================================


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

" Insert Date and time 20 Dec 2013 10:39 PM
imap <silent> <C-D><C-D> <C-R>=strftime("%e %b %Y")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M %p")<CR>

"for unhighlighing the selections
nmap <Space>x :let @/=''<CR>

" }}}
" {{{ ===== Ruby ===============================================================
au FileType ruby set ts=2 sts=2 et sw=2
" }}}
" {{{ ===== Ruby foldings ======================================================
fun! FoldSomething(lnum)
  let line1=getline(a:lnum)
  let line2=getline(a:lnum+1)
  if line1=~'^\s\+#\s[A-Z]\+'
    return 1
   if line2=~'^\s\+when'
     return ">1"
   elseif line2=~'^$'
     return 0
   elseif foldlevel(a:lnum-1)==2
     return 1
   endif
 elseif line1=~'^#\s[A-Z][a-z]'
   return ">2"
  endif
endfun

au FileType rb set foldmethod=expr
au FileType rb set foldexpr=FoldSomething(v:lnum)
"au FileType rb set foldcolumn=3
"function! RubyMethodFold(line)
  "let stack = synstack(a:line, (match(getline(a:line), '^\s*\zs'))+1)
"
  "for synid in stack
    "if GetSynString(GetSynDict(synid)) ==? "rubyMethodBlock" || GetSynString(GetSynDict(synid)) ==? "rubyDefine" || GetSynString(GetSynDict(synid)) ==? "rubyDocumentation"
      "return 1
    "endif
  "endfor
"
  "return 0
"endfunction
"
"au FileType rb set foldexpr=RubyMethodFold(v:lnum)
"au FileType rb set foldmethod=expr

" }}}
" {{{ ===== Vim To MD and Back ( MARKDOWN) =====================================
function! VO2MD()
  let lines = []
  let was_body = 0
  for line in getline(1,'$')
    if line =~ '^\t*[^:\t]'
      let indent_level = len(matchstr(line, '^\t*'))
      if was_body " <= remove this line to have body lines separated
        call add(lines, '')
      endif " <= remove this line to have body lines separated
      call add(lines, substitute(line, '^\(\t*\)\([^:\t].*\)', '\=repeat("#", indent_level + 1)." ".submatch(2)', ''))
      call add(lines, '')
      let was_body = 0
    else
      call add(lines, substitute(line, '^\t*: ', '', ''))
      let was_body = 1
    endif
  endfor
  silent %d _
  call setline(1, lines)
endfunction

function! MD2VO()
  let lines = []
  for line in getline(1,'$')
    if line =~ '^\s*$'
      continue
    endif
    if line =~ '^#\+'
      let indent_level = len(matchstr(line, '^#\+')) - 1
      call add(lines, substitute(line, '^#\(#*\) ', repeat("\<Tab>", indent_level), ''))
    else
      call add(lines, substitute(line, '^', repeat("\<Tab>", indent_level) . ': ', ''))
    endif
  endfor
  silent %d _
  call setline(1, lines)
endfunction
" }}}
" {{{ ===== Bash Support Plugin ================================================
let g:BASH_MapLeader                = ','
let g:BASH_DoOnNewLine              = 'yes'
let g:BASH_LineEndCommColDefault    = 49
let g:BASH_AuthorName               = 'Antenore Gatta'
let g:BASH_Email                    = ''
let g:BASH_Company                  = 'Simbiosi.org'
" }}}
" {{{ ===== C Support Plugin ===================================================
let g:C_MapLeader                   = ','
let g:C_ObjExtension                = ".o"
let g:C_ExeExtension                = ""
let g:C_CCompiler                   = "gcc"
let g:C_CplusCompiler               = "g++"
let g:C_Man                         = "man"
" }}}
" {{{ ===== Other commands =====================================================
command! Thtml :%!tidy -q -i --show-errors 0
command! Txml  :%!tidy -q -i --show-errors 0 -xml
" }}}
" {{{ ===== Omni ===============================================================
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd VimEnter * wincmd w
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" }}}
" {{{ ===== Vim Shougo stuff ====================================================
" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }
" neosnippet
imap <C-S-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-S-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-S-k>     <Plug>(neosnippet_expand_target)

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
" }}}
" {{{ ===== notes.vim ==========================================================
" comma separated paths
let g:notes_directories = ['~/Notes']
" }}}
" {{{ ===== NERDTree ===========================================================
" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"Open NERDTree
map <F10> :NERDTreeToggle<CR>
"Close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" }}}
" {{{ ===== Auto Commands ======================================================
au BufNewFile,BufRead * setlocal formatoptions-=t formatoptions-=c
au BufEnter *i3/config setlocal filetype=i3
augroup WinNumber
    autocmd!
    autocmd WinEnter * set number
    autocmd WinLeave * set nonumber
augroup END
"Security DB ---> BSC Prilly
"augroup sdb
" au BufEnter *.sdb call WriteBackup()
" au BufLeave *.sdb call Destroy_XML_Menu()
"augroup END
" }}}
" {{{ ===== Mutt ===============================================================
au BufRead /tmp/mutt-* set tw=72
" }}}
" {{{ ===== Syntastic ======================================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

au FileType rb set foldmethod=expr
au FileType rb set foldexpr=FoldSomething(v:lnum)
"au FileType rb set foldcolumn=3
"function! RubyMethodFold(line)
  "let stack = synstack(a:line, (match(getline(a:line), '^\s*\zs'))+1)
"
  "for synid in stack
    "if GetSynString(GetSynDict(synid)) ==? "rubyMethodBlock" || GetSynString(GetSynDict(synid)) ==? "rubyDefine" || GetSynString(GetSynDict(synid)) ==? "rubyDocumentation"
      "return 1
    "endif
  "endfor
"
  "return 0
"endfunction
"
"au FileType rb set foldexpr=RubyMethodFold(v:lnum)
"au FileType rb set foldmethod=expr

" }}}
" =============================== EOF ==========================================
" vim:set ts=2 sts=2 sw=2 expandtab:
