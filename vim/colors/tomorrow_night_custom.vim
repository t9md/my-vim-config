" Tomorrow Night
" By Chris Kempson
" http://chriskempson.com

set background=dark

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name = "tomorrow_night_custom"

" Vim >= 7.0 Colours
if version >= 700
  hi CursorLine     guibg=#2d2d2d
  hi CursorColumn   guibg=#2d2d2d
  hi MatchParen     guifg=#8e8f8d guibg=#373b41
  hi Pmenu          guifg=#f6f3e8 guibg=#444444
  hi PmenuSel       guifg=#000000 guibg=#cae682
endif

" General Colours
hi Cursor         guifg=#25292c guibg=#afb0ae
hi Normal         guifg=#afb0ae guibg=#25292c
hi NonText        guifg=#afb0ae guibg=#25292c
hi LineNr         guifg=#8e8f8d guibg=#373b41
hi StatusLine     guifg=#8e8f8d guibg=#373b41
hi StatusLineNC   guifg=#8e8f8d guibg=#373b41
hi VertSplit      guifg=#373b41 guibg=#373b41
hi Folded         guibg=#384048 guifg=#a0a8b0
hi FoldColumn     guibg=#384048 guifg=#a0a8b0
hi Directory      guifg=#c0e0b0 
hi Title          guifg=#f6f3e8 guibg=NONE
" hi Title            guifg=#62bdde                                   gui=none
" hi Visual         guifg=NONE  guibg=#444444
hi Visual         guifg=NONE  guibg=#403D3D
hi SpecialKey     guifg=#808080 guibg=#343434

" Syntax highlighting
hi Comment      guifg=#8e8f8d gui=none  
hi Todo         guifg=#8f8f8f gui=none 
hi Constant     guifg=#e5786d gui=none 
hi String       guifg=#a7b367 gui=none 
hi Identifier   guifg=#d56c69 gui=none 
hi Function     guifg=#ba9ac2 gui=none 
hi Type         guifg=#e7f6da gui=none
" hi Statement    guifg=#ba9ac2 gui=none 
hi Statement    guifg=#82a3bf gui=none 

hi Keyword      guifg=#afb0ae gui=none 
hi Operator     guifg=#afb0ae gui=none 
" hi PreProc      guifg=#e5786d gui=none 
hi PreProc      guifg=#f0dfaf gui=none
hi Number       guifg=#d09562 gui=none 
hi Special      guifg=#e7f6da gui=none 
hi Structure    guifg=#ba9ac2 gui=none 
hi Parent       guifg=#afb0ae gui=none 
hi None         guifg=#a7b367 gui=none 
hi Delimiter    guifg=#d09562 gui=none 

" " PHP Colours
" hi phpSpecialFunction   guifg=#ba9ac2
" hi phpComparison        guifg=#afb0ae
" hi phpMemberSelector    guifg=#afb0ae
" hi phpRegion            guifg=#82a3bf
" hi phpStringSingle      guifg=#a7b367
" hi phpDefine            guifg=#c3a2cc
" hi phpMethodsVar        guifg=#d3b96b
" hi phpVarSelector       guifg=#d56c69
" hi phpType              guifg=#ba9ac2
" hi phpStorageClass      guifg=#ba9ac2
" 
" " HTML Colours
" hi htmlTag        guifg=#92b3c8
" hi htmlTagName    guifg=#92b3c8
" hi htmlScriptTag  guifg=#c3a2cc
" hi htmlTitle      guifg=#afb0ae
" hi htmlArg        guifg=#ddc387
" hi htmlEndTag     guifg=#82a3bf
" 
" " VIM Colours
" hi vimSynType     gui=none
" hi vimCommand     guifg=#82a3bf
" hi vimSetEqual    guifg=#a7b367
" 
" " CSS Colours
" hi cssTagName     guifg=#82a3bf
" hi cssClassName   guifg=#d3b96b

" Tab Lines
" ---------
" tab pages line, not active tab page label
hi TabLine          guifg=#b6bf98           guibg=#363946           gui=none
" " tab pages line, where there are no labels
hi TabLineFill      guifg=#cfcfaf           guibg=#363946           gui=none
" " tab pages line, active tab page label
hi TabLineSel       guifg=#efefef           guibg=#414658           gui=bold
