"$HOME/.vim/init/plugins.vimrc
" {{{ ===== Airline ============================================================
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#branch#enabled = 1
" let g:airline_powerline_fonts = 1 "change 0 to 1 if you have a powerline font
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_theme='Luciano'
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#ale#enabled = 1
" If things goes nasty
"let g:airline_extensions = []
" }}}
" {{{ ===== ALE ================================================================
"let g:ale_linters = {'c': ['clang-check', 'gcc', 'make', 'uncrustify']}
let g:airline#extensions#ale#enabled = 1
let g:ale_set_signs = 1
let g:ale_sign_column_always = 0
let g:ale_set_highlights = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_completion_enabled = 0
let g:ale_puppet_puppetlint_executable = '/home/antenore/bin/puppet-lint'
let g:ale_linter_aliases = {
  \ 'ps1': 'powershell',
  \ 'md': 'markdown',}
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'bash': ['shellcheck'],
  \ 'sh': ['shellcheck'],
  \ 'c': ['clang'],
  \ 'cpp': ['clang'],
  \ 'cmake': ['cmakelint'],
  \ 'rust': ['rls'],
  \ 'markdown': ['proselint', 'mdl'],
  \ 'pandoc': ['markdown'],
  \ 'rst': ['proselint'],
  \ 'json': ['fixjson'],
  \ 'puppet': ['puppetlint'],
  \ 'vim': ['vint'],
  \ 'powershell': ['psscriptanalyzer'],
  \ 'html': ['fecs', 'tidy'],
  \ 'javascript': ['fecs', 'standard'],}
let g:ale_fixers = {
  \ 'c': [ 'uncrustify'],
  \ 'cpp': [ 'uncrustify'],
  \ 'json': ['fixjson'],
  \ 'puppet': ['puppetlint'],
  \ 'vim': ['vint'],
  \ 'cmake': ['cmakeformat', 'remove_trailing_lines', 'trim_whitespace'],
  \ 'html': ['fecs', 'tidy'],
  \ 'javascript': ['fecs', 'standard'],}
"nmap <silent> <C-h> <Plug>(ale_previous_wrap)
"nmap <silent> <C-l> <Plug>(ale_next_wrap)
""" ale-c-options
let g:ale_cmake_cmakeformat_executable = '/home/antenore/.local/bin/cmake-format'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
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
" puppet-lint options
let g:ale_puppet_puppetlint_options='--no-puppet_url_without_modules-check'
let g:ale_sh_shellcheck_options = '-x'
"powershell
" let g:ale_powershell_psscriptanalyzer_exclusions =
" \  'PSAvoidUsingWriteHost,PSAvoidGlobalVars'

augroup ale_cmake
  autocmd BufNewFile,BufRead CMakeLists.txt let g:ale_open_list = 1
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
let g:ale_json_fixjson_executable = 'fixjson'
" }}}
" {{{ ===== Animates ============================================================
" Settings for https://github.com/camspiers/animate.vim
if exists('g:animate#loaded')
    nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
    nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
    nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
    nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>
else
    " disable arrow keys
    map <up> <nop>
    map <down> <nop>
    map <left> <nop>
    map <right> <nop>
endif
" }}}
" {{{ ===== Bash Support Plugin ================================================
let g:BASH_MapLeader                = ','
let g:BASH_DoOnNewLine              = 'yes'
let g:BASH_LineEndCommColDefault    = 49
let g:BASH_AuthorName               = 'Antenore Gatta'
let g:BASH_Email                    = 'agatt@ch.ibm.com'
let g:BASH_Company                  = 'IBM Switzerland'
" }}}
" {{{ ===== Deoplete ===========================================================
let g:deoplete#enable_at_startup = 1
" }}}
" {{{ ===== Devhelp ============================================================
" cp /usr/share/doc/devhelp/devhelp.vim ~/.vim/plugin
let g:devhelpSearch=1
let g:devhelpAssistant=1
let g:devhelpSearchKey = '<S-F5>'
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
" {{{ ===== fugitive / Gitlab===================================================
let g:fugitive_gitlab_domains = ['https://www.gitlab.com']
source ~/.gitlabtoken.vimrc
" }}}
" {{{ ===== Fuzzy finder =======================================================
" locate command integration
command! -nargs=1 -bang Locate call fzf#run(fzf#wrap(
      \ {'source': 'locate <q-args>', 'options': '-m'}, <bang>0))

" Search lines in all open vim buffers
"(require set hidden to prevent vim unload buffer)
function! s:line_handler(l)
  let l:keys = split(a:l, ':\t')
  exec 'buf' l:keys[0]
  exec l:keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let l:res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(l:res, map(getbufline(b,0,'$'), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return l:res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

"Select buffer
function! s:buflist()
  redir => l:ls
  silent ls
  redir END
  return split(l:ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


" }}}
" {{{ ===== Easytags & Tagbar ==================================================
let g:excludeft = ['tagbar']
nmap <F8> :TagbarToggle<CR>
" Open tagbar with supported files
"autocmd VimEnter * nested :call tagbar#autoopen(1)
set tags=./tags;,~/.vimtags,~/vim/tags
let g:easytags_cmd = '/usr/local/bin/ctags'
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
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
" {{{ ===== Lens ===============================================================
" https://github.com/camspiers/lens.vim

"The plugin can be disabled completely with:
"let g:lens#disabled = 1

" The plugin can be disabled for specific filetypes:
" let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
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
let g:NERDTreeShowLineNumbers=0
" }}}
" {{{ ===== notes.vim ==========================================================
" comma separated paths
let g:notes_directories = ['~/Notes']
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
"let g:markdown_enable_folding = 1
let g:vim_markdown_folding_disabled= 1

" }}}
" {{{ ===== Mini Buffer Explorer ===============================================
" }}}
" {{{ ===== Rust plugins and settings===========================================
let g:racer_cmd = '/home/tmow/.cargo/bin/racer'
let g:racer_experimental_completer = 1
augroup rust_grp
  autocmd!
  autocmd FileType rust nmap gd <Plug>(rust-def)
  autocmd FileType rust nmap gs <Plug>(rust-def-split)
  autocmd FileType rust nmap gx <Plug>(rust-def-vertical)
  autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)
augroup END
" }}}
" {{{ ===== UltiSnip ===========================================================
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
" }}}
" {{{ ===== VimSafe ============================================================
" Defined in the plugin
"set conceallevel=1
" }}}
" {{{ ===== Grammalecte ========================================================
let g:grammalecte_cli_py='/usr/local/bin/grammalecte-cli.py'
" }}}
" {{{ ===== Pandoc =============================================================
"let g:pandoc#filetypes#handled = ['pandoc', 'markdown']
let g:pandoc#filetypes#pandoc_markdown = 0
" }}}
" {{{ ===== Empty Entry ========================================================
" }}}
