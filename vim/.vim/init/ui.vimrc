set encoding=utf-8
scriptencoding utf-8
"$HOME/.vim/init/ui.vimrc
" Tabs
set tabpagemax=15
set showtabline=2

"set termguicolors
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

"gruvbox
"set background=dark
"let g:gruvbox_guisp_fallback = "bg"
"let g:gruvbox_contrast_dark = "hard"
"let g:gruvbox_transp_bg = 1
"let g:gruvbox_plugin_hi_groups = 1
"colorscheme gruvbox8_hard
"colorscheme gruvbox

" Dracula colorscheme setting
"let g:dracula_bold = 1
let g:dracula_italic = 0
"let g:dracula_inverse = 1
let g:dracula_colorterm = 0
colorscheme dracula

"colorscheme nord
"colorscheme Luciano
"let g:gruvbox_termcolors=16

" https://github.com/ajmwagar/vim-deus
"colors deus


" let g:gruvbox_termcolors = 256
" if !has("gui_running")
"    let g:gruvbox_italic=0
" endif
" nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
" nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
" nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
"
" nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
" nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
" nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
"colorscheme hemisu
"colorscheme lucius
"  LuciusBlack

" Highlight if more then 88 chars
set colorcolumn=81
"highlight ColorColumn term=reverse cterm=reverse
highlight CursorLine term=underline cterm=underline gui=underline
highlight CursorLine guibg=#303000 ctermbg=234
highlight CursorColumn guibg=#303000 ctermbg=234

" Visual Cues
set cmdheight=2
set cursorline
set cursorcolumn
if &term =~? "st\\|xterm\\|rxvt\\|screen-it\\|screen"
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
if &term =~? "st\\|xterm\\|rxvt\\|screen-it\\|screen"
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
