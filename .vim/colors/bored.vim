" Vim color file
" Maintainer:        Bert Muennich <be.muennich at googlemail.com>
" Last Change: 2012 Nov 21

" This color scheme uses a dark background.

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif        
let g:colors_name = "bored"

hi Normal guifg=#EEEEEE guibg=#111111
hi Comment guifg=#777777 gui=none ctermfg=darkblue cterm=none
hi Constant guifg=#D05656 gui=none ctermfg=darkred cterm=none
hi Identifier guifg=#72B4B5 gui=none ctermfg=darkcyan cterm=none
hi Statement guifg=#D2B459 gui=none ctermfg=darkyellow cterm=none
hi PreProc guifg=#A672BF gui=none ctermfg=darkmagenta cterm=none
hi Type guifg=#61B961 gui=none ctermfg=darkgreen cterm=none
hi Special guifg=#5D90C9 gui=none ctermfg=darkblue cterm=none
hi MatchParen guifg=black guibg=#72B4B5 gui=none ctermfg=black ctermbg=darkcyan cterm=none
hi Error guifg=black guibg=#D05656 gui=none ctermfg=black ctermbg=darkred cterm=none
hi Todo guifg=black guibg=#A672BF gui=none ctermfg=black ctermbg=darkmagenta cterm=none
hi Directory guifg=#5D90C9 ctermfg=darkblue
hi LineNr guifg=#888888 gui=none ctermfg=darkyellow cterm=none
hi StatusLine guifg=white guibg=#5D90C9 gui=bold ctermfg=white ctermbg=darkblue cterm=bold
hi StatusLineNC guifg=#111111 guibg=#CCCCCC gui=none ctermfg=none ctermbg=none cterm=reverse
hi VertSplit guifg=#111111 guibg=#CCCCCC gui=none ctermfg=none ctermbg=none cterm=reverse
hi Search guifg=black guibg=#D2B459 ctermfg=black ctermbg=darkyellow
hi Visual guifg=black guibg=#999999 gui=none ctermbg=none cterm=reverse
hi Pmenu guifg=#EEEEEE guibg=#555555 gui=none ctermfg=white ctermbg=darkblue cterm=none
hi PmenuSel guifg=white guibg=#5D90C9 gui=none ctermfg=black ctermbg=darkyellow
hi PmenuSbar guifg=#333333 guibg=#333333 ctermfg=black ctermbg=black
hi PmenuThumb guifg=#999999 guibg=#999999 ctermfg=white ctermbg=white
hi ModeMsg guifg=#5D90C9 gui=none ctermfg=blue cterm=bold
hi ErrorMsg guifg=black guibg=#D05656 gui=none ctermfg=black ctermbg=darkred cterm=none
hi WarningMsg guifg=#D05656 gui=none ctermfg=darkred cterm=none
hi Question guifg=#61B961 ctermfg=darkgreen
hi TabLine guifg=#444444 guibg=#DDDDDD gui=none cterm=underline
hi TabLineFill guifg=#111111 guibg=#AAAAAA gui=none cterm=reverse
hi TabLineSel guifg=white guibg=#333333 gui=bold cterm=bold
hi FoldColumn guifg=#72B4B5 guibg=#444444 gui=none ctermfg=darkcyan ctermbg=none cterm=none
hi Folded guifg=#72B4B5 guibg=#444444 gui=none ctermfg=darkcyan ctermbg=darkgray cterm=none
hi DiffAdd guifg=#EEEEEE guibg=#116666 gui=none ctermfg=black ctermbg=darkcyan cterm=none
hi DiffChange guifg=#EEEEEE guibg=#666611 gui=none ctermfg=black ctermbg=darkyellow cterm=none
hi DiffDelete guifg=#EEEEEE guibg=#662222 gui=none ctermfg=black ctermbg=darkred cterm=none
hi DiffText guifg=#111111 guibg=#A672BF gui=none ctermfg=black ctermbg=darkmagenta cterm=none
