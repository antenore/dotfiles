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
" Plugins pre-initialization
" {{{ ===== ALE ================================================================
"let g:ale_linters = {'c': ['clang-check', 'gcc', 'make', 'uncrustify']}
"TEMP: let g:airline#extensions#ale#enabled = 1
"TEMP: let g:ale_set_signs = 1
"TEMP: let g:ale_sign_column_always = 0
"TEMP: let g:ale_set_highlights = 0
"TEMP: let g:ale_sign_error = '>>'
"TEMP: let g:ale_sign_warning = '--'
"TEMP: let g:ale_completion_enabled = 0
"TEMP: "let g:ale_puppet_puppetlint_executable = '/home/antenore/bin/puppet-lint'
"TEMP: "let g:ale_markdown_mdl_executable = '/home/antenore/bin/mdl'
"TEMP: "let g:ale_markdown_pandoc_executable = '/home/antenore/.local/bin/pandoc'
"TEMP: let g:ale_cpp_cppcheck_executable = '/usr/local/bin/cppcheck'
"TEMP: let g:ale_c_cppcheck_options = '--enable=style'
"TEMP: let g:ale_linter_aliases = {
  "TEMP: \ 'ps1': 'powershell',
  "TEMP: \ 'md': 'markdown',}
"TEMP: "let g:ale_linters_explicit = 1
"TEMP: let g:ale_linters = {
"TEMP:   \ 'bash': ['shellcheck'],
"TEMP:   \ 'sh': ['shellcheck'],
"TEMP:   \ 'c': ['cppcheck', 'clang'],
"TEMP:   \ 'cpp': ['cppcheck', 'clang'],
"TEMP:   \ 'cmake': ['cmakelint'],
"TEMP:   \ 'rust': ['rls'],
"TEMP:   \ 'tex': ['chktex', 'write-good', 'textlint'],
"TEMP:   \ 'latex': ['chktex', 'cspell', 'write-good', 'textlint'],
"TEMP:   \ 'markdown': ['pandoc','mdl', 'proselint'],
"TEMP:   \ 'pandoc': ['markdown'],
"TEMP:   \ 'python': ['autopep8', 'isort'],
"TEMP:   \ 'rst': ['proselint'],
"TEMP:   \ 'json': ['fixjson'],
"TEMP:   \ 'puppet': ['puppetlint'],
"TEMP:   \ 'vim': ['vint'],
"TEMP:   \ 'powershell': ['psscriptanalyzer'],
"TEMP:   \ 'html': ['fecs', 'tidy'],
"TEMP:   \ 'ruby': ['rubocop', 'brakeman', 'prettier', 'reek', 'rails_best_practices'],
"TEMP:   \ 'erb': ['brakeman', 'prettier', 'reek', 'rubocop', 'rails_best_practices'],
"TEMP:   \ 'javascript': ['fecs', 'standard'],}
"TEMP: let g:ale_fixers = {
"TEMP:   \ 'c': [ 'uncrustify'],
"TEMP:   \ 'cpp': [ 'uncrustify'],
"TEMP:   \ 'json': ['fixjson'],
"TEMP:   \ 'puppet': ['puppetlint'],
"TEMP:   \ 'python': ['nayvy#ale_fixer', 'autopep8', 'isort'],
"TEMP:   \ 'vim': ['vint'],
"TEMP:   \ 'cmake': ['cmakeformat', 'remove_trailing_lines', 'trim_whitespace'],
"TEMP:   \ 'ruby': ['rubocop', 'prettier'],
"TEMP:   \ 'markdown': ['prettier', 'dprint', 'pandoc'],
"TEMP:   \ 'html': ['fecs', 'tidy'],
"TEMP:   \ 'javascript': ['fecs', 'standard'],}
"nmap <silent> <C-h> <Plug>(ale_previous_wrap)
"nmap <silent> <C-l> <Plug>(ale_next_wrap)
""" ale-c-options
"TEMP: let g:ale_cmake_cmakeformat_executable = '/home/antenore/.local/bin/cmake-format'

"TEMP: let g:ale_echo_msg_error_str = 'E'
"TEMP: let g:ale_echo_msg_warning_str = 'W'
"TEMP: let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"TEMP: let g:ale_c_build_dir_names = ['build']
"TEMP: let g:ale_c_parse_compile_commands = 1
"TEMP: let g:ale_lint_on_text_changed = 1
"TEMP: let g:ale_open_list = 0
"TEMP: let g:ale_set_quickfix = 0
"TEMP: let g:ale_list_window_size = 5
" puppet-lint options
"TEMP: let g:ale_puppet_puppetlint_options='--no-puppet_url_without_modules-check'
"TEMP: let g:ale_sh_shellcheck_options = '-x'
"TEMP: "powershell
"TEMP: " let g:ale_powershell_psscriptanalyzer_exclusions =
"TEMP: " \  'PSAvoidUsingWriteHost,PSAvoidGlobalVars'

"TEMP: let g:ale_c_uncrustify_options = '-c ~/.uncrustify.cfg -l C --replace'
"TEMP: "https://github.com/richq/cmake-lint
"TEMP: let g:ale_cmake_cmakelint_options = '--filter=-linelength'
"TEMP: let g:ale_json_fixjson_executable = 'fixjson'
" }}}

if has('nvim')                                        " Only in neovim
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'rktjmp/lush.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/lsp-colors.nvim'                        " Auto add missing colour group for LSP
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'                 " Extentions to built-in LSP, for example, providing type inlay hints
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'p00f/clangd_extensions.nvim'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'
  Plug 'cuducos/yaml.nvim'
  " To enable more of the features of rust-analyzer, such as inlay hints and more!
  Plug 'nvim-lua/plenary.nvim'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-ui-select.nvim'
else
  Plug 'vim-airline/vim-airline'                    " Disabled in nvim
  Plug 'vim-airline/vim-airline-themes'             " Disabled in nvim
endif
"it doesn't work with encrypted files
"Plug 'tmux-plugins/vim-tmux-focus-events'          " FocusGained and FocusLost autocmd
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder.
Plug 'antenore/vim-safe'
Plug 'chrisbra/csv.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'                            " Needed by vim-markdown (and me :- )
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'                           " ultisnip, snipmate and neosnippet
Plug 'mboughaba/i3config.vim'
Plug 'nvie/vim-flake8'                              " Python style guide
Plug 'relastle/vim-nayvy'                           " Enriching python coding.
Plug 'plasticboy/vim-markdown'                      " Needs tabular
Plug 'rodjek/vim-puppet'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'                           " :G*
Plug 'shumphrey/fugitive-gitlab.vim'                " :Gbrowse
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tmux-plugins/vim-tmux'
"Plug 'w0rp/ale'
Plug 'wincent/command-t'
"Plug 'xolox/vim-notes'
Plug 'ryanoasis/vim-devicons'
Plug 'PProvost/vim-ps1'
"Plug 'camspiers/animate.vim'
"Plug 'camspiers/lens.vim'                          " Automatic windows resize
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'https://gitlab.com/antenore/Luciano.git'      " Hey it's me!!
"Plug 'dpelle/vim-Grammalecte'
"Plug 'dylanaraps/wal.vim'
Plug '/home/antenore/software/myvim/plugins/mdview.nvim'
Plug '/home/antenore/software/myvim/plugins/jaflpl.nvim'
Plug 'mcchrish/zenbones.nvim'
Plug 'ewilazarus/preto'
Plug 'luochen1990/rainbow'
Plug 'lervag/vimtex'
"Plug 'neomake/neomake', { 'on': 'Neomake' }  " terrible with airline
call plug#end()
