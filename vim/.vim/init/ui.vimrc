"$HOME/.vim/init/ui.vimrc
"
" All the settings related to the UI goes here
"
" ==============================================================================

" {{{ ===== Colorschemes =======================================================
" This option doesn't play well with most themes.
"if !has('gui_running')
  "set t_Co=256
"endif

"set termguicolors
"colorscheme nord
"colorscheme Luciano
"colorscheme wal
colorscheme preto

"zenbones
"colorscheme zenbones
"colorscheme zenwritten
"colorscheme neobones
"colorscheme vimbones
"colorscheme rosebones
"colorscheme forestbones
"colorscheme nordbones
" colorscheme tokyobones
"colorscheme seoulbones
"colorscheme duckbones
"colorscheme zenburned
"colorscheme kanagawabones
"colorscheme randombones

set background=dark
" }}}
" {{{ ===== Tabs ===============================================================
set tabpagemax=15
set showtabline=2
" }}}
" {{{ ===== Visual Cues ========================================================
" Highlight if more then 96 chars
set colorcolumn=80
"highlight ColorColumn term=reverse cterm=reverse
"highlight CursorLine term=underline cterm=underline gui=underline
"highlight CursorLine guibg=#303000 ctermbg=234
"highlight CursorColumn guibg=#303000 ctermbg=234

set cmdheight=2
set cursorline
set cursorcolumn
if &term =~? "tmux\\|st\\|xterm\\|rxvt\\|screen-it\\|screen"
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
if &term =~? "tmux\\|st\\|xterm\\|rxvt\\|screen-it\\|screen"
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
set laststatus=2                               " always show the status line
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set showmatch                                  " show matching brackets
set matchtime=5                                " Tenths of a second to show the matching paren (showmatch)
set modeline                                   " in source settings --> # vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
set nostartofline                              " keep the cursor in the same colon when changing line
set number
set scrolloff=3
set ruler
set showcmd
set showmatch                                  " show matching brackets
set sidescroll=1
set sidescrolloff=10
set smartcase
set scrolloff=10                               " Keep 10 lines (top/bottom) for scope
set title
" }}}
" vim:set ts=2 sts=2 sw=2 expandtab:
