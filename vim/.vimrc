set encoding=utf-8
scriptencoding utf-8
" {{{ ===== Before everything else =============================================
" Vim automatically resets the 'cp' option if it finds a personal vimrc file
"set nocompatible
filetype plugin indent on
set foldenable
set foldmethod=marker
"au FileType sh let g:sh_fold_enabled=7
augroup bash_match
  au FileType sh let g:is_bash=1
  au FileType sh set foldmethod=syntax
augroup END
syntax enable
set pyxversion=3
" }}}
" {{{ ===== Plug ===============================================================
"Preload variables -= START =-
let g:ale_completion_enabled = 1
"Preload variables -= END =-
 if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif
call plug#begin('~/.vim/plugged')

"Plug 'MarcWeber/vim-addon-mw-utils'       " SnipMate depends on vim-addon-mw-utils
" fuzzy finder
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/vim-hug-neovim-rpc'         " Needed by yarp
  Plug 'roxma/nvim-yarp'                  " Vim library needed by deoplete, denite
endif
Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Async exec library for Vim
Plug 'Shougo/deol.nvim'                     " Vim shell replacement
"Plug 'altercation/vim-colors-solarized'
Plug 'antenore/vim-safe'
Plug 'chrisbra/csv.vim'
"Plug 'fholgado/minibufexpl.vim'
Plug 'godlygeek/tabular'                  " Needed by vim-markdown (and me :- )
Plug 'honza/vim-snippets'                 " snippets for ultisnip, snipmate and neosnippet
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar'
Plug 'mboughaba/i3config.vim'
"Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
"Plug 'lifepillar/vim-gruvbox8'
Plug 'nvie/vim-pep8'
Plug 'gabrielelana/vim-markdown'            " Needs tabular
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim'               " Autocomplete, need pynvim
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'                 " :G*
Plug 'shumphrey/fugitive-gitlab.vim'      " :Gbrowse
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'wincent/command-t'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

call plug#end()
" }}}
" {{{ ===== Files ==============================================================
set viminfo='10,\"1000,:20,%,n~/.viminfo
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/temp
set makeef=error.err
let g:netrw_home=$XDG_CACHE_HOME.'/vim'
" }}}
" {{{ ===== General ============================================================
let mapleader = ','
"Let vim automatically load .vimrc found on folders
set exrc
"with clipboard=autoselect visual selection should go automatically into primary
"in case of needs I can user registers "+y
set clipboard=autoselect
set regexpengine=1
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
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000
set undoreload=10000        " number of lines to save for undo
" }}}
" {{{ ===== Functions ==========================================================
"A mapping to make a backup of the current file.
function! WriteBackup()
  let l:fname = expand('%:p') . '__' . strftime('%Y%m%d%H%M')
  silent execute 'write' l:fname
  echomsg 'Wrote' l:fname
endfunction
" }}}
" {{{ ===== Text Formatting/Layout =============================================
set autoindent
set smartindent
" TEST-03-12-2015 set tabstop=4
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set nojoinspaces
set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current
"set fo+=qn     " :h formatoptions fo-table
set wrapmargin=0       " wrapping margin
set textwidth=0       " no autowrap
" }}}
" {{{ ===== Text Highlighting ==================================================
highlight LeadingTab ctermbg=blue guibg=blue
highlight LeadingSpace ctermbg=darkgreen guibg=darkgreen
highlight EvilSpace ctermbg=darkred guibg=darkred
augroup syn_clean
  au Syntax * syn match LeadingTab /^\t\+/
  au Syntax * syn match LeadingSpace /^\ \+/
  au Syntax * syn match EvilSpace /\(^\t*\)\@<!\t\+/ " tabs not preceeded by tabs
  au Syntax * syn match EvilSpace /[ \t]\+$/ " trailing space
augroup END
" }}}
" {{{ ===== Menus ==============================================================
set wildmenu
set wildmode=list:longest,full
set wildchar=<Tab>
" }}}
" {{{ ===== Airline ============================================================
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#branch#enabled = 1
" let g:airline_powerline_fonts = 1 "change 0 to 1 if you have a powerline font
" set laststatus=2
"let g:airline#extensions#disable_rtp_load = 1
" If things goes nasty
"let g:airline_extensions = []
let g:airline_theme='base16_nord'
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#ale#enabled = 1
" }}}
" {{{ ===== UI =================================================================

" Tabs
set tabpagemax=15
set showtabline=2

set termguicolors

"set t_Co=256
"SOL set background=dark
"SOL if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
"SOL "let g:solarized_termtrans=1
"SOL "let g:solarized_termcolors=256
"SOL "let g:solarized_contrast="high"
"SOL "let g:solarized_visibility="high"
"SOL color solarized                 " load a colorscheme
"SOL endif

"let g:hybrid_use_Xresources = 1
"colorscheme hybrid
"colorscheme neverland
"colorscheme xoria256
"colorscheme wombat256

"gruvbox
set background=dark
"let g:gruvbox_guisp_fallback = "bg"
"let g:gruvbox_contrast_dark = "hard"
"let g:gruvbox_transp_bg = 1
"let g:gruvbox_plugin_hi_groups = 1
"colorscheme gruvbox8_hard
"colorscheme gruvbox
colorscheme nord
"let g:gruvbox_termcolors=16

" https://github.com/ajmwagar/vim-deus
"colors deus


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
set cursorcolumn
augroup cursor_comd
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
  au WinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorcolumn
augroup END
if &term =~? "xterm\\|rxvt\\|screen-it\\|screen"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;white\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;orange\x7"
  silent !echo -ne "\033]12;orange\007"
  " reset cursor when vim exits
  augroup vim_exit
    autocmd VimLeave * silent !echo -ne "\033]112\007"
augroup END
endif
if &term =~? "xterm\\|rxvt\\|screen-it\\|screen"
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
endif
set hlsearch
set incsearch
set laststatus=2   " always show the status line
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set matchtime=5          " how many tenths of a second to blink matching brackets for
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
set scrolloff=10          " Keep 10 lines (top/bottom) for scope
set title
" }}}
" {{{ ===== Language specific settings =========================================
" Python
augroup python_conf
  autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
  autocmd BufRead *.c,*h set cindent ts=8 st=8 sw=8 noexpandtab
augroup END
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

"map <F11> :let &bg = ( &bg = 'dark' ? 'light' : 'dark' )<CR>   # shitch dark lingh bg

"Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remap ctrl-] to Enter and ctrl-T to esc to make help sane.

augroup remapping
  :au FileType help nnoremap <buffer> <CR> <c-]>
  :au FileType help nnoremap <buffer> <BS> <c-T>
augroup END

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

" Resizing splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Useful functions keys
set pastetoggle=<F12>
map <F11> :let &bg = ( &bg == 'dark'? 'light' : 'dark' )<CR>

" Insert Date and time 20 Dec 2013 10:39 PM
imap <silent> <C-D><C-D> <C-R>=strftime("%e %b %Y")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M %p")<CR>

"for unhighlighing the selections
nmap <Space>x :let @/=''<CR>

" Spelling
map <F5> :setlocal spell! spelllang=en_us<CR>
set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add
augroup mrkd_grp
  autocmd Filetype markdown setlocal spell
augroup END

" }}}
" {{{ ===== Ruby ===============================================================
augroup ruby_grp
  au FileType ruby set ts=2 sts=2 et sw=2
  au FileType rb set foldmethod=expr
  au FileType rb set foldexpr=FoldSomething(v:lnum)
augroup END
" }}}
" {{{ ===== Ruby foldings ======================================================
fun! FoldSomething(lnum)
  let line1=getline(a:lnum)
  let line2=getline(a:lnum+1)
  if line1 =~# '^\s\+#\s[A-Z]\+'
    return 1
   if line2 =~# '^\s\+when'
     return '>1'
   elseif line2 =~# '^$'
     return 0
   elseif foldlevel(a:lnum-1)==2
     return 1
   endif
 elseif line1 =~# '^#\s[A-Z][a-z]'
   return '>2'
  endif
endfun

"au FileType rb set foldcolumn=3
"function! RubyMethodFold(line)
"  let stack = synstack(a:line, (match(getline(a:line), '^\s*\zs'))+1)
"
" for synid in stack
"   if GetSynString(GetSynDict(synid)) ==? "rubyMethodBlock" || GetSynString(GetSynDict(synid)) ==? "rubyDefine" || GetSynString(GetSynDict(synid)) ==? "rubyDocumentation"
"     return 1
"   endif
" endfor
"
" return 0
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
    if line =~# '^\t*[^:\t]'
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
    if line =~# '^\s*$'
      continue
    endif
    if line =~# '^#\+'
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
" {{{ ===== ALE ================================================================
"let g:ale_linters = {'c': ['clang-check', 'gcc', 'make', 'uncrustify']}
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 0
let g:ale_set_highlights = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_completion_enabled = 0
let g:ale_linters = {
			\	'c':['clang'],
			\	'rust':['rls'],
			\	'markdown':['mdl'],
			\}
let g:ale_linters_explicit = 0
"nmap <silent> <C-h> <Plug>(ale_previous_wrap)
"nmap <silent> <C-l> <Plug>(ale_next_wrap)
""" ale-c-options
let g:ale_c_build_dir_names = ['build']
let g:ale_c_parse_compile_commands = 1
"" '-g -gdwarf-2 -mcpu=cortex-m4 -mthumb -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -std=c99 -ffunction-sections -fdata-sections -Wall'
"let g:ale_c_clang_options = '-g -gdwarf-2 -mcpu=cortex-m4 -mthumb -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -std=c99 -ffunction-sections -fdata-sections -Wall'
"let g:ale_c_gcc_executable = 'arm-none-eabi-gcc'
"let g:ale_c_gcc_options = '-g -gdwarf-2 -mcpu=cortex-m4 -mthumb -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -std=c99 -ffunction-sections -fdata-sections -Wall'
let g:ale_lint_on_text_changed = 1
" let g:ale_open_list = 'on_save'
let g:ale_open_list = 1
let g:ale_set_quickfix=1

augroup ale_cmake
  autocmd BufNewFile,BufRead CMakeLists.txt let g:ale_open_list = 0
augroup END
let g:ale_c_uncrustify_options = '-c ~/.uncrustify.cfg -l C --replace'
"https://github.com/richq/cmake-lint
let g:ale_cmake_cmakelint_options = '--filter=-linelength'
"nmap <F8> <Plug>(ale_fix)
"nnoremap <C-F11> <Plug>(ale_fix)
nnoremap <C-F9> :ALEFix<CR>
nnoremap <leader>rr :%s/$//g<CR>
nnoremap <leader>rt :%s/\r//g<CR>
nnoremap <leader>re ::%s/\s\+$//<CR>
let g:ale_fixers = {
			\ 'c': [
			\ 'uncrustify',
			\ 'remove_trailing_lines',
			\ 'trim_whitespace',
			\ ],
			\ 'cmake': [
			\ 'remove_trailing_lines',
			\ 'trim_whitespace',
			\ ]
			\ }
" }}}
" {{{ ===== Bash Support Plugin ================================================
let g:BASH_MapLeader                = ','
let g:BASH_DoOnNewLine              = 'yes'
let g:BASH_LineEndCommColDefault    = 49
let g:BASH_AuthorName               = 'Antenore Gatta'
let g:BASH_Email                    = 'agatt@ch.ibm.com'
let g:BASH_Company                  = 'IBM Switzerland'
" }}}
" {{{ ===== Other commands =====================================================
command! Thtml :%!tidy -q -i --show-errors 0
command! Txml  :%!tidy -q -i --show-errors 0 -xml
" }}}
" {{{ ===== notes.vim ==========================================================
" comma separated paths
let g:notes_directories = ['~/Notes']
" }}}
" {{{ ===== NERDTree ===========================================================
" Open a NERDTree automatically when vim starts up if no files were specified
augroup nerd_open
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  "Close vim if the only window left open is a NERDTree?
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END
"Open NERDTree
map <F10> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=0
" }}}
" {{{ ===== Easytags & Tagbar ==================================================
nmap <F8> :TagbarToggle<CR>
" Open tagbar with supported files
"autocmd VimEnter * nested :call tagbar#autoopen(1)
set tags=./tags;,~/.vimtags,~/vim/tags
let g:easytags_cmd = '/usr/bin/ctags'
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

let g:tagbar_show_linenumbers=0
let g:tagbar_width=65
" DO NOT SPECIFY THE CTAGS BINARY. tagbar detect automatically the one to use
" on FreeBSD we use extags (detected)
let g:tagbar_indent=1
let g:tagbar_autopreview=0
" Open Tagbar automatically inside vim
" autocmd FileType * nested :call tagbar#autoopen(0)
" Open Tagbar automatically in the current tab
" autocmd BufEnter * nested :call tagbar#autoopen(0)
" }}}
" {{{ ===== Mini Buffer Explorer ===============================================
" }}}
" {{{ ===== Folding template ===================================================
" }}}
" {{{ ===== Mutt ===============================================================
augroup mutt_grp
  au BufRead /tmp/mutt-* set tw=72
augroup END
" }}}
" {{{ ===== Auto Commands ======================================================
augroup number_ft
  autocmd BufWinEnter,WinEnter * if index(excludeft, &ft) <0 | set number
  autocmd BufWinLeave,WinLeave * set nonumber
augroup END
let excludeft = ['tagbar']
augroup WinNumber
  au BufNewFile,BufRead * setlocal formatoptions-=t formatoptions-=c
  au BufEnter *i3/config setlocal filetype=i3
  autocmd!
augroup END
"autocmd FileType nerdtree set nonumber
"autocmd FileType tagbar set nonumber
"autocmd FileType minibufexpl set nonumber
" Remove trailing whitespace on save
augroup trim_space
  autocmd BufWritePre * :%s/\s\+$//e
augroup END
" }}}
" {{{ ===== VimSafe ============================================================
" Defined in the plugin
"set conceallevel=1
" }}}
" {{{ ===== Doxygen Plugin======================================================
let g:DoxygenToolkit_authorName= 'Antenore Gatta'
let g:DoxygenToolkit_licenseTag= 'Copyright (C) 2014-2020 Antenore Gatta, Giovanni Panozzo\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'This program is free software; you can redistribute it and/or modify\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'it under the terms of the GNU General Public License as published by\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'the Free Software Foundation; either version 2 of the License, or\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . '(at your option) any later version.\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'This program is distributed in the hope that it will be useful,\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'but WITHOUT ANY WARRANTY; without even the implied warranty of\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'GNU General Public License for more details.\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'You should have received a copy of the GNU General Public License\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'along with this program; if not, write to the Free Software\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'Foundation, Inc., 51 Franklin Street, Fifth Floor,\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'Boston, MA  02110-1301, USA.\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'In addition, as a special exception, the copyright holders give\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'permission to link the code of portions of this program with the\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'OpenSSL library under certain conditions as described in each\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'individual source file, and distribute linked combinations\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'including the two.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'You must obey the GNU General Public License in all respects\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'for all of the code used other than OpenSSL.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'If you modify file(s) with this exception, you may extend this exception\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'to your version of the file(s), but you are not obligated to do so.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'If you do not wish to do so, delete this exception statement from your\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'version.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'If you delete this exception statement from all source\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'files in the program, then also delete it here.\<enter>'
" }}}
" {{{ ===== CTags ==============================================================
set tags+=~/.vim/tags/gtk2
set tags+=~/.vim/tags/gtk3
set tags+=~/.vim/tags/glib
" }}}
" {{{ ===== Devhelp ============================================================
" cp /usr/share/doc/devhelp/devhelp.vim ~/.vim/plugin
let g:devhelpSearch=1
let g:devhelpAssistant=1
let g:devhelpSearchKey = '<S-F5>'
" }}}
" {{{ ===== Rust plugins and settings===========================================
let g:racer_cmd = '/home/tmow/.cargo/bin/racer'
let g:racer_experimental_completer = 1
augroup rust_grp
  au FileType rust nmap gd <Plug>(rust-def)
  au FileType rust nmap gs <Plug>(rust-def-split)
  au FileType rust nmap gx <Plug>(rust-def-vertical)
  au FileType rust nmap <leader>gd <Plug>(rust-doc)
augroup END
" }}}
" {{{ ===== LaTeX ==============================================================
set grepprg=grep\ -nH\ $*
let g:tex_flavor = 'latex'
" }}}
" {{{ ===== Deoplete ===========================================================
let g:deoplete#enable_at_startup = 1
" }}}
" {{{ ===== UltiSnip ===========================================================
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
" }}}
" {{{ ===== fugitive / Gitlab===================================================
let g:fugitive_gitlab_domains = ['https://www.gitlab.com']
source ~/.gitlabtoken.vimrc
" }}}
" {{{ ===== Markdown ===========================================================
" mappings are local to markdown buffers
"
"     <Space> (NORMAL_MODE) switch status of things:
"         Cases
"             A list item * item becomes a check list item * [ ] item
"             A check list item * [ ] item becomes a checked list item * [x] item
"             A checked list item * [x] item becomes a list item * item
"         Can be changed with g:markdown_mapping_switch_status = '<Leader>s
"     <Leader>ft (NORMAL_MODE) format the current table
"     <Leader>e (NORMAL_MODE, VISUAL_MODE) :MarkdownEditCodeBlock edit the current code block in another buffer with a guessed file type. The guess is based on the start of the range for VISUAL_MODE. If it's not possible to guess (you are not in a recognizable code block like a fenced code block) then the default is markdown. If it's not possible to guess and the current range is a single line and the line is empty then a new code block is created. It's asked to the user the file type of the new code block. The default file type is markdown.
"
let g:markdown_enable_folding = 1

" }}}
" {{{ ===== Empty Entry ========================================================
" }}}
" =============================== EOF ==========================================
" vim:set ts=2 sts=2 sw=2 expandtab:
