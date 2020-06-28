set encoding=utf-8
scriptencoding utf-8
"        ________ ++     ________
"       /VVVVVVVV\++++  /VVVVVVVV\      __   _(_)_ __ ___  _ __ ___
"       \VVVVVVVV/++++++\VVVVVVVV/      \ \ / / | '_ ` _ \| '__/ __|
"        |VVVVVV|++++++++/VVVVV/'        \ V /| | | | | | | | | (__
"        |VVVVVV|++++++/VVVVV/'         (_)_/ |_|_| |_| |_|_|  \___|
"       +|VVVVVV|++++/VVVVV/'+
"     +++|VVVVVV|++/VVVVV/'+++++     - My .vimrc file.
"   +++++|VVVVVV|/VVVVV/'+++++++++     You can use it at your own risk, before to
"     +++|VVVVVVVVVVV/'+++++++++       ask question RTFM.
"       +|VVVVVVVVV/'+++++++++         To quit this file type :q
"        |VVVVVVV/'+++++++++         - Vim License
"        |VVVVV/'+++++++++           - Antenore Gatta
"        |VVV/'+++++++++             - https://antenore.simbiosi.org
"        'V/'   ++++++               - https://github.com/antenore/dotfiles
"                 ++
"
" {{{ ===== Before everything else =============================================
"set nocompatible
filetype plugin indent on
set foldenable
set foldmethod=marker
syntax enable
set pyxversion=3
let g:ale_completion_enabled = 1
" }}}
" {{{ ===== Files ==============================================================
set viminfo='10,\"1000,:20,%,n~/.viminfo
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/temp
set makeef=error.err
set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add
let g:netrw_home=$XDG_CACHE_HOME.'/vim'
" CTags
set tags+=~/.vim/tags/gtk2
set tags+=~/.vim/tags/gtk3
set tags+=~/.vim/tags/glib
" }}}
" {{{ ===== VIMRC Functions ====================================================
source $HOME/.vim/init/functions.vimrc  " Functions
" }}}
" {{{ ===== Plug ===============================================================
source $HOME/.vim/init/plug.vimrc       " Plugin loader
" }}}
" {{{ ===== General ============================================================
source $HOME/.vim/init/general.vimrc    " General Settings
" }}}
" {{{ ===== Text Formatting/Layout =============================================
source $HOME/.vim/init/autoformat.vimrc " Auto formatting
" }}}
" {{{ ===== Text Highlighting ==================================================
source $HOME/.vim/init/highlight.vimrc  " Highlight text, columns, …
" }}}
" {{{ ===== UI =================================================================
source $HOME/.vim/init/ui.vimrc         " Colors and appearance
" }}}
" {{{ ===== Language specific settings =========================================
source $HOME/.vim/init/ft.vimrc         " File type based commands
" }}}
" {{{ ===== LaTeX ==============================================================
source $HOME/.vim/init/latex.vimrc      " Special settings for LaTeX
" }}}
" {{{ ===== Mutt ===============================================================
source $HOME/.vim/init/mutt.vimrc       " Mutt ;-)
" }}}
" {{{ ===== Plugin settings ====================================================
source $HOME/.vim/init/plugins.vimrc    "Plugin settings
" }}}
" {{{ ===== Auto Commands ======================================================
source $HOME/.vim/init/autocmd.vimrc    " Auto commands
" }}}
" {{{ ===== Mappings ===========================================================
source $HOME/.vim/init/mappings.vimrc   " Keyboard mappings
" }}}
" {{{ ===== Empty Entry ========================================================
" }}}
" =============================== EOF ==========================================
" vim:set ts=2 sts=2 sw=2 expandtab:
