" $HOME/.vim/init/functions.vimrc

"A mapping to make a backup of the current file.
function! WriteBackup()
  let l:fname = expand('%:p') . '__' . strftime('%Y%m%d%H%M')
  silent execute 'write' l:fname
  echomsg 'Wrote' l:fname
endfunction

function! VO2MD()
  let l:lines = []
  let l:was_body = 0
  for l:line in getline(1,'$')
    if l:line =~# '^\t*[^:\t]'
      let l:indent_level = len(matchstr(l:line, '^\t*'))
      if l:was_body " <= remove this line to have body lines separated
        call add(l:lines, '')
      endif " <= remove this line to have body lines separated
      call add(l:lines, substitute(l:line, '^\(\t*\)\([^:\t].*\)', '\=repeat("#", l:indent_level + 1)." ".submatch(2)', ''))
      call add(l:lines, '')
      let l:was_body = 0
    else
      call add(l:lines, substitute(l:line, '^\t*: ', '', ''))
      let l:was_body = 1
    endif
  endfor
  silent %d _
  call setline(1, l:lines)
endfunction

function! MD2VO()
  let l:lines = []
  for l:line in getline(1,'$')
    if l:line =~# '^\s*$'
      continue
    endif
    if l:line =~# '^#\+'
      let l:indent_level = len(matchstr(l:line, '^#\+')) - 1
      call add(l:lines, substitute(l:line, '^#\(#*\) ', repeat("\<Tab>", l:indent_level), ''))
    else
      call add(l:lines, substitute(l:line, '^', repeat("\<Tab>", l:indent_level) . ': ', ''))
    endif
  endfor
  silent %d _
  call setline(1, l:lines)
endfunction

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
