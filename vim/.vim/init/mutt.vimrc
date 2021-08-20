" $HOME/.vim/init/mutt.vimrc
augroup mutt_grp
  autocmd!
  autocmd BufRead /tmp/mutt-* set tw=72
augroup END

