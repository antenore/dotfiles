" $HOME/.vim/init/ft.vimrc
" NB: Auto ommands specific to a plugins go in the plugin settings.
" Python
augroup python_conf
  autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
  autocmd BufRead *.c,*h set cindent ts=8 st=8 sw=8 noexpandtab
augroup END

" Ruby
augroup ruby_grp
  autocmd FileType ruby set ts=2 sts=2 et sw=2
  autocmd FileType rb set foldmethod=expr
  autocmd FileType rb set foldexpr=FoldSomething(v:lnum)
augroup END

augroup bash_match
  autocmd!
  autocmd FileType sh let g:is_bash=1
  autocmd FileType sh set foldmethod=syntax
augroup END
