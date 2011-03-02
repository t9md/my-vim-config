set visualbell t_vb=
set guioptions=
set antialias
nnoremap <silent> ,M :set go&<CR>
nnoremap <silent> ,m :set go=<CR>

if g:Is_linux
  function! SetGUIFont(ope) "{{{
    " ope is '+' or '-'
    exe "let s:font_size = s:font_size " . a:ope . " " . 1
    " 6 - 18
    let s:font_size = (s:font_size <   6) ? 6   : s:font_size
    let s:font_size = (s:font_size >  30) ? 30  : s:font_size
    let &guifont= s:font_family.' '.s:font_size
  endfunction "}}}

  let s:font_size = 13
  let s:font_family = 'VL ゴシック'
  let &guifont= s:font_family.' '.s:font_size
  set antialias
  nnoremap <silent> <M--> :<C-u>call SetGUIFont('-')<CR>
  nnoremap <silent> <M-=> :<C-u>call SetGUIFont('+')<CR>
endif

if g:Is_mac
  macm File.New\ Tab key=<Nop>
  macm File.Open\.\.\. key=<Nop>
  macm File.Open\ Tab\.\.\. key=<Nop>
  macm File.Open\ Recent action=recentFilesDummy:
  macm File.Close\ Window key=<Nop>
  " macm File.Close key=<Nop>
  macm File.Save key=<Nop>
  macm File.Save\ All key=<Nop>
  macm File.Save\ As\.\.\. key=<Nop>
  macm File.Print key=<Nop>

  macm Edit.Undo key=<Nop>
  macm Edit.Redo key=<Nop>
  macm Edit.Cut key=<Nop>
  " macm Edit.Copy key=<Nop>
  " macm Edit.Paste key=<Nop>
  macm Edit.Select\ All key=<Nop>
  macm Edit.Find.Find\.\.\. key=<Nop>
  macm Edit.Find.Find\ Next key=<Nop>
  macm Edit.Find.Find\ Previous key=<Nop>
  macm Edit.Find.Use\ Selection\ for\ Find key=<Nop>
  macm Edit.Special\ Characters\.\.\. key=<Nop>
  macm Edit.Font.Show\ Fonts action=orderFrontFontPanel:
  " macm Edit.Font.Bigger key=<Nop>
  " macm Edit.Font.Smaller key=<Nop>
  macm Edit.Special\ Characters\.\.\. action=orderFrontCharacterPalette:

  macm Tools.Spelling.To\ Next\ error key=<Nop>
  macm Tools.Spelling.Suggest\ Corrections key=<Nop>
  macm Tools.Make key=<Nop>
  macm Tools.List\ Errors key=<Nop>
  macm Tools.List\ Messages key=<Nop>
  macm Tools.Next\ Error key=<Nop>
  macm Tools.Previous\ Error key=<Nop>
  macm Tools.Older\ List key=<Nop>
  macm Tools.Newer\ List key=<Nop>

  macm Window.Minimize key=<Nop>
  macm Window.Minimize\ All key=<Nop>
  macm Window.Zoom key=<Nop>
  macm Window.Zoom\ All key=<Nop>
  macm Window.Toggle\ Full\ Screen\ Mode key=<Nop>

  " macm Window.Select\ Window\ Next=<Nop>
  " macm Window.Select\ Window\ Previous=<Nop>
  macm Window.次のウインドウ key=<Nop>
  macm Window.前のウインドウ key=<Nop>

  macm Window.Select\ Previous\ Tab key=<Nop>
  macm Window.Select\ Next\ Tab key=<Nop>
  macm Window.Bring\ All\ To\ Front action=arrangeInFront:

  macm Help.MacVim\ Help key=<Nop>
  macm Help.MacVim\ Website action=openWebsite:

  nnoremap <F11> :emenu Window.Toggle\ Full\ Screen\ Mode<CR>
  " colorscheme railscasts
  " set guifont=Monaco:h14
  set guifont=Monaco:h14
endif

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

colorscheme molokai
" colorscheme railscasts
" colorscheme vividchalk
" colorscheme manuscript
" colorscheme blackboard
" colorscheme desert
" colorscheme ir_black
" colorscheme rdark
