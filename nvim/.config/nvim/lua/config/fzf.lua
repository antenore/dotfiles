-- {{{ ===== Fuzzy finder =======================================================
-- locate command integration
vim.api.nvim_exec([[
command! -nargs=1 -bang Locate call fzf#run(fzf#wrap(
      \ {'source': 'locate <q-args>', 'options': '-m'}, <bang>0))

" Search lines in all open vim buffers
" require set hidden to prevent vim unload buffer)
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

"nnoremap <silent> <Leader><Enter> :call fzf#run({
"\   'source':  reverse(<sid>buflist()),
"\   'sink':    function('<sid>bufopen'),
"\   'options': '+m',
"\   'down':    len(<sid>buflist()) + 2
"\ })<CR>
]], true)


-- }}}
