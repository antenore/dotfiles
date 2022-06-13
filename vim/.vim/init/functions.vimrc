" $HOME/.vim/init/functions.vimrc

" Used only for ruby folding at the moment, see ft.vimrc
fun! FoldSomething(lnum)
  let l:line1=getline(a:lnum)
  let l:line2=getline(a:lnum+1)
  if l:line1 =~# '^\s\+#\s[A-Z]\+'
    return 1
    if l:line2 =~# '^\s\+when'
      return '>1'
    elseif l:line2 =~# '^$'
      return 0
    elseif foldlevel(a:lnum-1)==2
      return 1
    endif
  elseif l:line1 =~# '^#\s[A-Z][a-z]'
    return '>2'
  endif
endfun
