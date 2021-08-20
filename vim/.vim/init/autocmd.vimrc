"$HOME/.vim/init/autocmd.vimrc

augroup vimrc_autocmd
  autocmd!
  autocmd BufWinEnter,WinEnter * if index(excludeft, &ft) <0 | set number
  autocmd BufWinLeave,WinLeave * set nonumber
  autocmd BufNewFile,BufRead * setlocal formatoptions-=t formatoptions-=c
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter * setlocal cursorcolumn
  autocmd WinLeave * setlocal nocursorcolumn
  autocmd BufEnter *i3/config setlocal filetype=i3
  autocmd Filetype markdown setlocal spell
  autocmd Filetype md setlocal spell
  autocmd FileType powershell set colorcolumn=115
  autocmd FileType ps1 set colorcolumn=115
augroup END

