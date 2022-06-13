" $HOME/.vim/init/general.vimrc
let g:mapleader = ','
let g:maplocalleader = ','
"Let vim automatically load .vimrc found on folders
set exrc
"with clipboard=autoselect visual selection should go automatically into primary
"in case of needs I can user registers "+y
if !has('nvim')
    set clipboard=autoselect
else
    set clipboard+=unnamedplus
endif
set regexpengine=1
set autoread
set autowrite
set backspace=indent,eol,start
set browsedir=current
set formatoptions+=ro/qj
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=2000
set ignorecase
set noerrorbells
set novisualbell
set printoptions=paper:A4,syntax:y
" Enable error files & error jumping.
set report=0                         " tell us when anything is changed via :...
set wildmenu
" stuff to ignore when tab completing
set wildignore+=*.o,*.obj,*~,*.egg-info/**,node_modules/**,dist/**,build/**
set wildmode=list:longest,full
" ignore case (mostly for rediculous camel-cased idioms).
set wildignorecase
set wildchar=<Tab>
set grepprg=grep\ -nH\ $*

" Completion
set completeopt=menu,menuone,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Avoid windows have all the same size, this should prevent linter windows to gain space
set noequalalways

" file extensions to append.
set suffixesadd+=.c
set suffixesadd+=.css
set suffixesadd+=.ex
set suffixesadd+=.go
set suffixesadd+=.h
set suffixesadd+=.html
set suffixesadd+=.js
set suffixesadd+=.json
set suffixesadd+=.md
set suffixesadd+=.php
set suffixesadd+=.phpt
set suffixesadd+=.pl
set suffixesadd+=py
set suffixesadd+=.rb
set suffixesadd+=.rs
set suffixesadd+=.scss
set suffixesadd+=.swift
set suffixesadd+=.sh
set suffixesadd+=.xml
set suffixesadd+=.zsh
