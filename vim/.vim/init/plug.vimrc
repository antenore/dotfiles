"" $HOME/.vim/init/plug.vimrc
"Preload variables -= START =-
"Preload variables -= END =-
 if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif
call plug#begin('~/.vim/plugged')

" fuzzy finder
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'                       " Autocomplete, need pynvim
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/vim-hug-neovim-rpc'                   " Needed by yarp
  Plug 'roxma/nvim-yarp'                            " Vim library needed by deoplete, denite
endif
"it doesn't work with encrypted files
"Plug 'tmux-plugins/vim-tmux-focus-events'           " FocusGained and FocusLost autocmd
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder.
Plug 'Shougo/vimproc.vim', {'do' : 'make'}          " Async exec library for Vim
Plug 'Shougo/deol.nvim'                             " Vim shell replacement
Plug 'antenore/vim-safe'
Plug 'chrisbra/csv.vim'
Plug 'godlygeek/tabular'                            " Needed by vim-markdown (and me :- )
Plug 'honza/vim-snippets'                           " ultisnip, snipmate and neosnippet
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar'
Plug 'mboughaba/i3config.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvie/vim-pep8'
"Plug 'gabrielelana/vim-markdown'                    " Needs tabular
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'rodjek/vim-puppet'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'rust-lang/rust.vim'
Plug 'zchee/deoplete-zsh'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'                           " :G*
Plug 'shumphrey/fugitive-gitlab.vim'                " :Gbrowse
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tmux-plugins/vim-tmux'
Plug 'w0rp/ale'
Plug 'wincent/command-t'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'PProvost/vim-ps1'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'https://gitlab.com/antenore/Luciano.git'      " Hey it's me!!
Plug 'dpelle/vim-Grammalecte'
"Plug 'morhetz/gruvbox'
"Plug 'lifepillar/vim-gruvbox8'
"Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
call plug#end()
