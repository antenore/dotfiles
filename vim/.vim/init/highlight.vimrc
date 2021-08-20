" $HOME/.vim/init/highlight.vimrc
highlight LeadingTab ctermbg=blue guibg=blue
highlight LeadingSpace ctermbg=darkgreen guibg=darkgreen
highlight EvilSpace ctermbg=darkred guibg=darkred
augroup syn_clean
  autocmd Syntax * syn match LeadingTab /^\t\+/
  autocmd Syntax * syn match LeadingSpace /^\ \+/
  autocmd Syntax * syn match EvilSpace /\(^\t*\)\@<!\t\+/ " tabs not preceeded by tabs
  autocmd Syntax * syn match EvilSpace /[ \t]\+$/ " trailing space
augroup END
