" vim: set sw=2 sts=2 et fdm=marker fdc=3 fdl=5:
" Init {{{1
let g:Is_unix  = has('unix')
let g:Is_mac   = has('gui_macvim')
let g:Is_linux = ! g:Is_mac && g:Is_unix
let g:Is_win   = has('win32')
let g:GUI_MODE = has("gui_running") ? 1 : 0

filetype off
source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
let g:pathogen_disabled = []
call pathogen#infect()

" Default setting: {{{1
"-----------------------------------------------------------------
let g:enable_swap_colon                    = 1 " US key board
let g:loaded_gist_vim                      = 1 " gist is danger
let g:loaded_nerdtree_plugin_easymove      = 1
let g:loaded_nerdtree_plugin_local_mapping = 1

" Basic setting {{{1
"-----------------------------------------------------------------
let $VIMDIR=$HOME."/.vim"
filetype indent plugin on
syntax on
set nocompatible
set guicursor=a:blinkon0,n:hor7
set notagbsearch
" set clipboard=unnamed
set previewheight=20
set noswapfile
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch hlsearch noshowmatch matchtime=2
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set ignorecase smartcase autoindent
set statusline&
set statusline=%<%f\ %m%r%h%w%r%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%{fugitive#statusline()}%=%l,%c%V%8P
set laststatus=2 "ステータスラインを常に表示
set wildmenu helplang=en,ja showtabline=1
set hidden
" set grepprg=grep\ -n\ $*\ /dev/null\ --exclude\ \"\*\.svn\*\"
" let &grepprg="ack-grep -H --nocolor --nogroup --column"
let &grepprg="ack-grep --nocolor --nogroup"
set history=1000 undolevels=1000
set title                " change the terminal's title
set wildignore& wildignore+=*.swp,*.bak,*.pyc,*.pyo,*.class
set visualbell t_vb=
set noerrorbells         " don't beep
set scrolloff=3
set nowrap

" Syntax highlight for complex documents is a little slow.  Tweaking
" the settings a bit to reduce the load (especially on remote
" machines)
set synmaxcol=400
syn sync minlines=200
syn sync maxlines=500

runtime macros/matchit.vim      " Make '%' more useful
set shortmess=atI               " get rid of prompts I don't care about
set winaltkeys=no

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif

if exists('&ambiwidth')
  set ambiwidth=double
endif

let $MYVIMRC_LOCAL = expand("~/.vimrc.local.vim")
if filereadable($MYVIMRC_LOCAL)
  exe "source " . $MYVIMRC_LOCAL
endif

" macvim-kaoriya workaround
if g:Is_mac
  let macvim_skip_cmd_opt_movement = 1
  let plugin_dicwin_disable        = 1
endif

" Key Binding {{{1
"-----------------------------------------------------------------
let mapleader = ","
xnoremap <silent> <D-p>  :<C-u>RubyEvalPrint<CR>
xnoremap <silent> <D-i>  :<C-u>RubyEvalInsert<CR>
xnoremap <silent> <C-x>p :<C-u>RubyEvalPrint<CR>
xnoremap <silent> <C-x>e :<C-u>RubyEvalInsert<CR>

nnoremap <C-S-D-=> :<C-u>call SetTransparency("+")<CR>
nnoremap <C-D--> :<C-u>call SetTransparency("+")<CR>
nnoremap <C-D-=> :<C-u>call SetTransparency("-")<CR>
nnoremap <S-LeftMouse> :<C-u>help<Space><C-r><C-W><CR>
nnoremap <BS> <C-t>

" Flag to tweek behavior {{{2
function! s:setup_winmove_hjkl(...)
  let is_buffer_local = a:0 > 0 ? '<buffer>' : ''
  exe "nnoremap " . is_buffer_local . "<silent> <C-h> :wincmd h<CR>"
  exe "nnoremap " . is_buffer_local . "<silent> <C-l> :wincmd l<CR>"
  exe "nnoremap " . is_buffer_local . "<silent> <C-k> :wincmd k<CR>"
  exe "nnoremap " . is_buffer_local . "<silent> <C-j> :wincmd j<CR>"
endfunction
call s:setup_winmove_hjkl()

" nnoremap <silent> <Left>  :wincmd h<CR>
" nnoremap <silent> <Right> :wincmd l<CR>
" nnoremap <silent> <Up>    :wincmd k<CR>
" nnoremap <silent> <Down>  :wincmd j<CR>

nnoremap <silent> <S-Left>  :10wincmd -<CR>
nnoremap <silent> <S-Right> :10wincmd +<CR>
nnoremap <silent> <S-Up>    :10wincmd ><CR>
nnoremap <silent> <S-Down>  :10wincmd <<CR>

if g:enable_swap_colon
  nnoremap ;     :
  nnoremap :     ;
  xnoremap ;     :
  xnoremap :     ;
endif

" nnoremap <silent> <S-D-Left>  :wincmd H<CR>
" nnoremap <silent> <S-D-Right> :wincmd L<CR>
" nnoremap <silent> <S-D-Up>    :wincmd K<CR>
" nnoremap <silent> <S-D-Down>  :wincmd J<CR>

" move window with hljk such as M-S-h(=M-H)
nnoremap <silent> <D-H> :wincmd H<CR>
nnoremap <silent> <D-L> :wincmd L<CR>
nnoremap <silent> <D-K> :wincmd K<CR>
nnoremap <silent> <D-J> :wincmd J<CR>
xnoremap <silent> <D-H> :wincmd H<CR>
xnoremap <silent> <D-L> :wincmd L<CR>
xnoremap <silent> <D-K> :wincmd K<CR>
xnoremap <silent> <D-J> :wincmd J<CR>

" textmanip
xmap <D-d>    <Plug>(textmanip-duplicate-down)
nmap <D-d>    <Plug>(textmanip-duplicate-down)
xmap <D-D>    <Plug>(textmanip-duplicate-up)
nmap <D-D>    <Plug>(textmanip-duplicate-up)

xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

" split with direct key
nnoremap <silent> <D-2> :split<CR>
nnoremap <silent> <D-3> :vsplit<CR>
" swap window
nnoremap <silent> <D-x> :wincmd x<CR>

" Chose Alternate buffer
inoremap <silent> <D-e> <C-o><C-^>
nnoremap <silent> <D-e> <C-^>

" Tag Jump with split
nnoremap <D-g>  <C-w>]
nnoremap <D-G>  <C-w>]<C-w>T

" Left double click
nnoremap <2-LeftMouse> <C-]>

" Ref single click
nmap <S-LeftMouse> <Plug>(ref-keyword)

" Righ click
nnoremap <RightMouse> <C-o>

" Select Linet with <D-l>
inoremap <D-l>  <Esc>V
nnoremap <D-l>  V
xnoremap <D-l>  ip
nnoremap L  V
xnoremap L  ip
xnoremap <CR> <Esc>

nnoremap <D-t>  :<C-u>tabnew<CR>
nnoremap <D-T>   <C-w>T

" move between fold with directkey
nnoremap <D-z> za
xnoremap <D-z> zf
nnoremap <D-k> zk
nnoremap <D-j> zj

" Select all
nnoremap <D-a> ggVG
" Tab movement
nnoremap <D-]> gt
nnoremap <D-[> gT

" Save directly from insert mode with <D-s>
inoremap <D-s>    <C-o>:<C-u>write<CR>

" close window
nnoremap <silent> <D-w> :wincmd q<CR>
xnoremap <silent> <D-w> :wincmd q<CR>

if g:Is_linux
  nnoremap <D-v> "+gP
  xnoremap <D-c> "+y
  xnoremap <D-x> "+x
  inoremap <D-v> <ESC>"+gPa
else
  xnoremap <D-c> y
  nnoremap <D-v> p
  xnoremap <D-v> p
endif

" nnoremap <Space>vs :<C-u>exe 'VimShellPop ' . expand("%:h")<CR>
" nnoremap <Space>vf :<C-u>VimFilerSimple<CR>

nnoremap Y y$
xnoremap Q gq
nnoremap Q gqap

set listchars=tab:▸\ ,eol:¬ " Use the same symbols as TextMate for tabstops and EOLs

nmap     <silent> <Leader>f  <Plug>(CheckFileTypeAtCursor)

nnoremap gc `[V`]
xnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

nnoremap <silent> <F2> :TagbarToggle<CR>
nnoremap <silent> <F2>      :NERDTreeFind<CR>
nmap     <silent> <F3>      <plug>NERDCommenterToggle
xmap     <silent> <F3>      <plug>NERDCommenterToggle
nmap     <silent> <D-;>     <plug>NERDCommenterToggle
xmap     <silent> <D-;>     <plug>NERDCommenterToggle
nmap     <silent> <Space>;  <plug>NERDCommenterToggle
xmap     <silent> <Space>;  <plug>NERDCommenterToggle

" QuickRun
nmap <F5> <Plug>(quickrun)
xmap <F5> <Plug>(quickrun)
inoremap <silent> <F5>  <C-o>:<C-u>QuickRun<CR>

nmap <D-r> <Plug>(quickrun)
xmap <D-r> <Plug>(quickrun)
inoremap <silent> <D-r> <C-o>:<C-u>QuickRun<CR>

nnoremap <Space>h  :<C-u>help<Space><C-r><C-W><CR>
nnoremap <Space>..  :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>.l  :<C-u>edit $MYVIMRC_LOCAL<CR>

" Resize window easily
xmap _     <Plug>(ResizeWinMaxH)
nmap _     <Plug>(ResizeWinMaxH)
xmap <bar> <Plug>(ResizeWinMaxV)
nmap <bar> <Plug>(ResizeWinMaxV)
" xmap F     <Plug>(ResizeWinMaxHV)
" nmap F     <Plug>(ResizeWinMaxHV)
"
nmap <D-o> <Plug>(ResizeWinMaxHV)
" nmap <D-o> <Plug>ZoomWin
" nmap <D-F>     <Plug>(ResizeWinMinV)
inoremap <C-f>  <C-r>=expand("%:p")<CR>

nmap <silent> zl <Plug>(FoldcolumnIncrease)
nmap <silent> zh <Plug>(FoldcolumnDecrease)

" Function and Command {{{1
function! SetTransparency(ope) "{{{
  if !exists('&transparency')
    return
  endif
  execute "let newval = &transparency " . a:ope . " " . 3
  let newval = (newval <   0) ? 0   : newval
  let newval = (newval > 100) ? 100 : newval
  let &transparency = newval
endfunction "}}}

function! Capture(cmd)"{{{
  redir => __
  silent exe a:cmd
  redir END
  return __
endfunction"}}}

function! s:toggle_option(opt) "{{{
  exe "set inv" . a:opt
  let status = eval("&".a:opt) ? "ON" : "OFF"
  echo a:opt . ": " . status
endfunction "}}}

" function! s:TransposeWindow()"{{{
  " if winwidth(0) * 9.0 > winheight(0) * 25.7
    " silent wincmd L
  " else
    " silent wincmd J
  " endif
" endfunction"}}}

" copy and paste from open-browser.vim
function! s:get_selected_text() "{{{
  let save_z = getreg('z', 1)
  let save_z_type = getregtype('z')
  try
    normal! gv"zy
    return @z
  finally
    call setreg('z', save_z, save_z_type)
  endtry
endfunction "}}}

nnoremap <silent> <Space>c  :set list!\|HighlightTrailingWhiteSpace<CR>
nnoremap <silent> <Space>n  :<C-u>call <SID>toggle_option('number')<CR>
nnoremap <silent> <Space>w  :<C-u>call <SID>toggle_option('wrap')<CR>
nnoremap <silent> <Space>/  :<C-u>call <SID>toggle_option('hlsearch')<CR>
nnoremap <Space>d :<C-u>diffthis<CR>
nnoremap <Space>D :<C-u>diffoff!<CR>
" nnoremap <F8> :<C-u>diffthis<CR>
" nnoremap <S-F8> :<C-u>diffoff!<CR>

command! TogglePaste   :call <SID>toggle_option('paste')
command! ToggleSpell   :call <SID>toggle_option('spell')

command! GitPush       :Git  push -u origin master
command! InsertTmp     :r /tmp/memo.tmp
command! SudoWrite     write !sudo tee %
command! HelptagUpdate call pathogen#helptags()
command! FdmMarker     :set fdm=marker

command! -nargs=* -complete=mapping AllMaps map <args> | map! <args> | lmap <args>

command! Cp932     edit ++enc=cp932
command! Eucjp     edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! UTF8      edit ++enc=utf-8
command! Jis       Iso2022jp
command! SJis      Cp932
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis

" vimcasts {{{2
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()"{{{
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction"}}}

function! SummarizeTabs()"{{{
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction"}}}

" Auto Command {{{1
"-----------------------------------------------------------------
" augroup InsModeAu"{{{
" autocmd!
" autocmd! InsertEnter * set noimdisable
" autocmd! InsertLeave * set imdisable
" augroup END"}}}

" augroup Quickhl"{{{
" autocmd!
" " autocmd! BufEnter * call s:init_quickhl()
" augroup END"}}}

" function! s:init_quickhl()"{{{
" QuickhlAdd t9md
" QuickhlRefresh
" endfunction"}}}

augroup my_config "{{{
  autocmd!

  " autocmd FileType javascript let b:quickrun_config = {}  | let b:quickrun_config = { 'command': 'node' }
  autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby          setlocal omnifunc=rubycomplete#Complete
  autocmd FileType ref-*         nnoremap <buffer> q :wincmd q<CR>

  autocmd BufNewFile,BufReadPost *.node.js let b:quickrun_config = {}  | let b:quickrun_config = { 'command': 'node' }

  " 次に開いたときに同じ場所を開く。
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

  au BufNewFile,BufReadPost .vimrc nnoremap <buffer> <D-r> :so %<CR>
  au BufNewFile,BufRead *.json              set  filetype=json
  au BufNewFile,BufRead {Rakefile,*.rake}   let b:phrase_ext = 'rake'
  au BufNewFile,BufRead /tmp/*vimperator*   setlocal filetype=textile bufhidden=delete

  " Chef
  au BufNewFile,BufRead */*cookbooks/*  call s:ft_chef_hook()


  " Koans
  function! s:tmux_send(cmd)
    call vimproc#system( printf("tmux send-keys '%s' Enter", a:cmd) )
  endfunction
  function! s:tmux_koans(cmd)
    let [interpleter, koan_complete] = split(a:cmd)
    let dir  = fnamemodify(koan_complete,":p:h")
    let base = fnamemodify(koan_complete,":p:t")
    let cmd  = "cd " . dir . ";" . interpleter . " " . base
    exe "xnoremap <buffer> <silent> <F5> :<C-u>call <SID>tmux_send('". cmd . "')<CR>"
    exe "nnoremap <buffer> <silent> <F5> :<C-u>call <SID>tmux_send('". cmd . "')<CR>"
  endfunction

  au BufNewFile,BufRead */koans/about_*.py 
        \ call s:tmux_koans("python ~/Dropbox/dev/Python/python2/contemplate_koans.py")
  au BufNewFile,BufRead */koans/about_*.rb 
        \ call s:tmux_koans("ruby ~/local/github/ruby_koans/koans/path_to_enlightenment.rb")

  " Thunderbird
  au BufNewFile,BufRead /tmp/*.eml  setlocal filetype=markdown bufhidden=delete

  autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown
  autocmd FileType text setlocal textwidth=78
  autocmd FileType sh xnoremap <buffer> <silent> <F5> :<C-u>QuickRunWrapper "v"<CR>
  autocmd FileType sh nnoremap <buffer> <silent> <F5> :<C-u>QuickRunWrapper "n"<CR>
  autocmd FileType qf nnoremap <buffer> p <CR>:call <SID>preview()<CR>

  autocmd FileType {vim,markdown,ruby,html,haml,sass,css,javascript,coffee} setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType {c,python} setlocal ts=4 sts=4 sw=4 expandtab

  " Ruby: {{{
  autocmd BufReadPost *_spec.rb :compiler rspec
  autocmd FileType vim setlocal iskeyword+=#
  " set cursorline
  " CoffeeScript: {{{
  autocmd FileType coffee nnoremap  <buffer> <silent> <D-r> :call QuickRunScrollEnd()<CR>
  autocmd FileType coffee inoremap  <buffer> <silent> <D-r> <C-o>:call QuickRunScrollEnd()<CR>
  autocmd FileType coffee xnoremap  <buffer> <silent> <D-r> :call QuickRunScrollEnd()<CR>

  fun! CoffeeCompile()
    QuickRun -cmdopt '-pb'
    wincmd k
    normal! G
    wincmd j
  endf
  fun! QuickRunScrollEnd()
    QuickRun
    wincmd k
    normal! G
    wincmd j
  endf
  autocmd FileType coffee nnoremap  <buffer> <silent> <D-p> :call CoffeeCompile()<CR>
  autocmd FileType coffee inoremap  <buffer> <silent> <D-p> <C-o>:call CoffeeCompile()<CR>
  autocmd FileType coffee xnoremap  <buffer> <silent> <D-p> :call CoffeeCompile()<CR>
  autocmd FileType coffee nnoremap <buffer> <silent> <S-F5> :QuickRun -cmdopt '-pb'<CR>
  autocmd FileType coffee inoremap <buffer> <silent> <S-F5> <C-o>:QuickRun -cmdopt '-pb'<CR>
  autocmd FileType coffee xnoremap <buffer> <silent> <S-F5> :QuickRun -cmdopt '-pb'<CR>
  "}}}

  autocmd ColorScheme * highlight link markdownCodeBlock Comment
  autocmd ColorScheme * highlight Normal ctermbg=NONE

  autocmd BufNewFile,BufRead haproxy.cfg set filetype=haproxy
  autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
  autocmd BufRead,BufNewFile *.pp set filetype=puppet
  autocmd FileType scheme :let is_gauche=1
  autocmd BufNewFile,BufRead *.txt set filetype=txt

	autocmd FileType ref call s:initialize_ref_viewer()
	function! s:initialize_ref_viewer()
	  nnoremap <buffer> q <C-w>c
	  setlocal nonumber
	endfunction

augroup END "}}}

function! s:preview() "{{{
  normal! zv
  normal! zz
  normal! V
  redraw
  sleep 250m
  wincmd p
endfunction "}}}

" Experiment {{{1
nnoremap <Space>q <C-w>q
nnoremap sj :<C-u>SplitjoinSplit<CR>
nnoremap sk :<C-u>SplitjoinJoin<CR>

cnoremap <expr> <Space> ambicmd#expand("\<Space>")
cnoremap <expr> <CR>    ambicmd#expand("\<CR>")

" Color and ColorScheme {{{1
"-------------------------------------------------
if g:GUI_MODE
  " colorscheme tomorrow_night_custom
  " colorscheme  tommorow_night_custom
  
	" syntax enable
	" set background=light
	" colorscheme solarized
	" colorscheme newspaper
	" set background=light
  " colorscheme  solarized
  colorscheme molokai_custom
else
  colorscheme lucius_custom
endif

" {{{ ColorRoller
let ColorRoller = {}
let ColorRoller.colors = [
      \ 'molokai_custom',
      \ 'solarized',
      \ 'tomorrow_night_custom',
      \ 'lucius_custom',
      \ 'github256_custom',
      \ 'pyte',
      \ 'newspaper',
      \ ]
function! ColorRoller.change()
  let color = get(self.colors, 0)
  silent exe "colorscheme " . color
  redraw
  echo self.colors
endfunction

function! ColorRoller.roll()
  let item = remove(self.colors, 0)
  call insert(self.colors, item, len(self.colors))
  call self.change()
endfunction

function! ColorRoller.unroll()
  let item = remove(self.colors, -1)
  call insert(self.colors, item, 0)
  call self.change()
endfunction
" }}}
nnoremap <silent><F9>   :<C-u>call ColorRoller.roll()<CR>
nnoremap <silent><S-F9> :<C-u>call ColorRoller.unroll()<CR>

set t_Co=256
set t_Sb=[4%dm
set t_Sf=[3%dm
" set t_ti= t_te=

" Plugin Configuration  {{{1
"=================================================
" IndentGuides: {{{2
nnoremap <Space>i :IndentGuidesToggle<CR>
let g:indent_guides_guide_size=1

" OpenBrowser: {{{2
let g:openbrowser_search_engines = {
      \ 'google': 'http://google.com/search?q={query}',
      \ 'nova': 'http://google.com/search?q=site:docs.openstack.org {query}',
      \ 'novawiki': 'http://wiki.openstack.org/StartingPage?action=fullsearch\&fullsearch=Text\&value={query}',
      \ 'chef': 'http://wiki.opscode.com/dosearchsite.action?queryString={query}',
      \ 'yahoo': 'http://search.yahoo.com/search?p={query}',
      \ }

let  g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
xmap gx <Plug>(openbrowser-smart-search)

nmap go <Plug>(openbrowser-open)
xmap go <Plug>(openbrowser-open)

function! s:set_search_engine(type)"{{{
  let g:openbrowser_default_search = a:type
  " endif
endfunction"}}}

function! s:openbrowser_search_from(engine, mode)"{{{
  if a:mode == 'v'
    call openbrowser#search(<SID>get_selected_text(), a:engine)
  else
    call openbrowser#search(expand('<cword>'), a:engine)
  endif
endfunction"}}}

command!
      \   -nargs=1 -complete=customlist,<SID>engine_list
      \   SetSearchEngine
      \   call <SID>set_search_engine(<q-args>)

function! s:engine_list(_1, _2, _3) "{{{
   return keys(g:openbrowser_search_engines)
endfunction

nmap gss <Plug>(openbrowser-search)
xmap gss <Plug>(openbrowser-search)

nnoremap gsn :<C-u>call <SID>openbrowser_search_from('nova','n')<CR>
xnoremap gsn :<C-u>call <SID>openbrowser_search_from('nova','v')<CR>
nnoremap gsw :<C-u>call <SID>openbrowser_search_from('novawiki','n')<CR>
xnoremap gsw :<C-u>call <SID>openbrowser_search_from('novawiki','v')<CR>
nnoremap gsc :<C-u>call <SID>openbrowser_search_from('chef','n')<CR>
xnoremap gsc :<C-u>call <SID>openbrowser_search_from('chef','v')<CR>

nnoremap <silent> gh :NERDTreeFind<CR>
nnoremap ge :<C-u>Eijiro <C-r><C-w><CR>
xnoremap ge :<C-u>call ref#ref("-new alc " . <SID>get_selected_text())<CR>
nnoremap gm :<C-u>Man <C-r><C-w><CR>
xnoremap gm :<C-u>call ref#ref("-new man " . <SID>get_selected_text())<CR>

" Gist: {{{2
let g:gist_detect_filetype         = 1
let g:gist_open_browser_after_post = 1

" SmartWord: {{{2
map w  <Plug>(smartword-w)
map b  <Plug>(smartword-b)
map e  <Plug>(smartword-e)
" map ge  <Plug>(smartword-ge)
" TOhtml: {{{2
let html_use_css      = 1
let html_whole_filter = 1

" FiletypeFook: {{{2
let g:fthook = {}
function! g:fthook._()"{{{
  if &ft != 'nerdtree'
    call s:setup_winmove_hjkl('buffer')
  endif
endfunction"}}}
function! g:fthook.help()"{{{
  nnoremap <buffer> <Return> <C-]>
  nnoremap <buffer> <BS>     <C-t>
  " nnoremap <buffer> .j  /\|[^ \|]\+\|<CR>
endfunction"}}}
function! g:fthook.ruby()"{{{
  set tags&
  " let stdlib = expand("~/.vim/tagfiles") . "/ruby_stdlib.tags"
  " exe "setlocal tags+=" . stdlib
  " " exe "setlocal tags+=" . gems

  setlocal complete-=i
  setlocal path+=**/lib

  compiler ruby
  nmap <buffer> <silent> <F5> <Plug>(quickrun)

  " noremap  <buffer> <silent> <F5> moHmt:%call Xmpfilter()<CR>'tzt`o"{{{
  " noremap  <buffer> <silent> <F5> moHmt:%call Xmpfilter()<CR>'tzt`o
  " inoremap <buffer> <silent> <F5> <Esc>moHmt:%call Xmpfilter()<CR>'tzt`oa
  " noremap  <buffer> <silent> <F4> :call XmpCommentToggle()<CR>
  " inoremap <buffer> <silent> <F4> <C-o>:call XmpCommentToggle()<CR>
  " noremap  <buffer> <silent> <F5> moHmt:%call Xmpfilter()<CR>'tzt`o
  " inoremap <buffer> <silent> <F5> <Esc>moHmt:%call Xmpfilter()<CR>'tzt`oa
  " xnoremap <buffer> <silent> <F5> :call Xmpfilter()<CR>
  " noremap  <buffer> <silent> <F4> :call XmpCommentToggle()<CR>
  " inoremap <buffer> <silent> <F4> <C-o>:call XmpCommentToggle()<CR>"}}}
  
  " Gvim
  nmap <buffer> <D-r> <Plug>(xmpfilter-run)
  xmap <buffer> <D-r> <Plug>(xmpfilter-run)
  imap <buffer> <D-r> <Plug>(xmpfilter-run)

  nmap <buffer> <D-m> <Plug>(xmpfilter-mark)
  xmap <buffer> <D-m> <Plug>(xmpfilter-mark)
  imap <buffer> <D-m> <Plug>(xmpfilter-mark)

  " Terminal
  nmap <buffer> <F5> <Plug>(xmpfilter-run)
  xmap <buffer> <F5> <Plug>(xmpfilter-run)
  imap <buffer> <F5> <Plug>(xmpfilter-run)

  nmap <buffer> <F4> <Plug>(xmpfilter-mark)
  xmap <buffer> <F4> <Plug>(xmpfilter-mark)
  imap <buffer> <F4> <Plug>(xmpfilter-mark)

  map <buffer> <D-j>   <Plug>BlockToggle
  call OverwiteRubyFindFileMapping()
endfunction"}}}
function! g:fthook.nerdtree()"{{{
  nmap <buffer> v go
  nnoremap <silent> <buffer>  f    :call <SID>normal_other("80j")<CR>
  nnoremap <silent> <buffer>  b    :call <SID>normal_other("80k")<CR>
  nnoremap <silent> <buffer>  gh   :<C-u> NERDTreeClose<CR>
  " nnoremap <silent> <buffer>  H    :<C-u> NERDTreeClose<CR>
  nnoremap <silent> <buffer>  ~          :<C-u>NERDTree $HOME<CR>
  nnoremap <silent> <buffer>  <Leader>g  :<C-u>NERDTree /var/lib/gems/1.8/gems<CR>
  nnoremap <silent> <buffer>  <Leader>b  :<C-u>NERDTree ~/.vim/bundle<CR>
  nnoremap <silent> <buffer>  <Leader>v  :<C-u>NERDTree ~/.vim<CR>
endfunction"}}}

" function! g:fthook.lingr_messages()"{{{
  " nmap <buffer> i <Plug>(lingr-messages-show-say-buffer) 
" endfunction"}}}
function! g:fthook.unite() "{{{
  " if b:unite.buffer_name ==# 'phrase-auto-open'
    " nmap <buffer>j ju
    " nmap <buffer>k ku
  " endif

  nmap <buffer> <2-LeftMouse> <Plug>(ext_unite_persist_open)
  nmap <buffer>m  <Plug>(unite_toggle_mark_current_candidate)
  xmap <buffer>m  <Plug>(unite_toggle_mark_selected_candidates)
  nmap <buffer>j  <Plug>(unite_loop_cursor_down)

  imap <buffer> <C-g>  <Plug>(unite_exit)
  nmap <buffer> <C-g>  <Plug>(unite_exit)
  nmap <buffer> <C-z>  <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>  <Plug>(unite_toggle_transpose_window)

  nmap <silent> <buffer> <D-j>  <Plug>(unite_rotate_next_source)
  nmap <silent> <buffer> <D-k>  <Plug>(unite_rotate_previous_source)

  if b:unite.buffer_name ==# 'file'
    imap <silent> <buffer> <C-w>  <Plug>(unite_delete_backward_path)
    imap <silent> <buffer> <F2>  <Plug>(unite_rotate_next_source)
    imap <silent> <buffer> <F2>  <Plug>(unite_rotate_previous_source)
    nmap <silent> <buffer> <F2>  <Plug>(unite_rotate_next_source)
    nmap <silent> <buffer> <F2>  <Plug>(unite_rotate_previous_source)
    nmap <silent> <buffer> h  <Plug>(unite_rotate_next_source)
    nmap <silent> <buffer> g  <Plug>(unite_rotate_previous_source)
  endif

  if b:unite.buffer_name =~# 'file_\d'
    nnoremap <silent> <buffer> <D-[>      :call g:unite_file_resume('previous')<CR>
    nnoremap <silent> <buffer> <D-]>      :call g:unite_file_resume('next')<CR>
    inoremap <silent> <buffer> <D-[> <C-o>:call g:unite_file_resume('previous')<CR>
    inoremap <silent> <buffer> <D-]> <C-o>:call g:unite_file_resume('next')<CR>
    " inoremap <silent> <buffer> <C-z> :call g:unite_file.resume()<CR>
  endif
  if b:unite.buffer_name =~# 'file_rec_\d'
    nnoremap <silent> <buffer> <D-[>      :call g:unite_file_rec_resume('previous')<CR>
    nnoremap <silent> <buffer> <D-]>      :call g:unite_file_rec_resume('next')<CR>
    inoremap <silent> <buffer> <D-[> <C-o>:call g:unite_file_rec_resume('previous')<CR>
    inoremap <silent> <buffer> <D-]> <C-o>:call g:unite_file_rec_resume('next')<CR>
    " inoremap <silent> <buffer> <C-z> :call g:unite_file.resume()<CR>
  endif
  nmap <buffer> <F5> <Plug>(unite_redraw)
  nmap <buffer>e <Plug>(ext_unite_narrowing_word)
  " imap <buffer>e <Plug>(ext_unite_narrowing_word)
  nmap <buffer>f <Plug>(ext_unite_scroll_previous_win_half_forward)
  nmap <buffer>b <Plug>(ext_unite_scroll_previous_win_half_backward)

  nmap <buffer>J <Plug>(ext_unite_loop_cursor_down_w_persis_open)
  nmap <buffer>K <Plug>(ext_unite_loop_cursor_up_w_persis_open)
  nmap <buffer> <F9> <Plug>(ext_unite_toggle_auto_persist_open)
  nmap <buffer>P <Plug>(unite_toggle_auto_preview)


  nmap <buffer> C <Plug>(ext_unite_project_cd)
  nnoremap <silent> <buffer> <expr> B    unite#do_action('bookmark')
  nnoremap <silent> <buffer>  zR   :call <SID>normal_other("zR")<CR>
  nnoremap <silent> <buffer>  zM   :call <SID>normal_other("zM")<CR>
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('below')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('below')
  nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('above')
  inoremap <silent> <buffer> <expr> <C-k> unite#do_action('above')
  " nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('left')
  " inoremap <silent> <buffer> <expr> <C-h> unite#do_action('left')
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('right')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('right')

  nnoremap <silent> <buffer> <expr> H unite#do_action('vimshell')

  nmap               <buffer>    r <Plug>(unite_redraw)
  inoremap <silent><buffer><expr> <C-o> unite#do_action('open')
  nnoremap <silent><buffer><expr> <C-o> unite#do_action('open')
  nnoremap <silent><buffer><expr> u unite#do_action('persist_open')
endfunction  "}}}

function! g:fthook.vimshell() "{{{
  inoremap <buffer><silent> <C-p> <C-o>:<C-u>Unite file_mru -buffer-name=files<CR>
  call vimshell#altercmd#define('g', 'git')
  call vimshell#altercmd#define('i', 'iexe')
  call vimshell#altercmd#define('l', 'll')
  call vimshell#altercmd#define('ll', 'ls -l')
  call vimshell#altercmd#define('c', 'clear')
endfunction "}}}

" PrettyPrint: {{{2
let g:prettyprint_show_expression = 1
let g:prettyprint_width           = 70

" Align: {{{2
" don't load default keymap
" let g:loaded_AlignMaps = 1
xmap       <D-a>=    <Plug>AM_t=
xmap       <D-a><    <Plug>AM_t<
xmap       <D-a>;    <Plug>AM_t;
xmap       <D-a>:    <Plug>AM_t:
xmap       <D-a>,    <Plug>AM_t,
xmap       <D-a>#    <Plug>AM_t#
xmap       <D-a>\|   <Plug>AM_\|
xmap       <D-a>sp   <Plug>AM_tsp
xmap       <D-a>sq   <Plug>AM_tsq
xmap       <D-A>=    <Plug>AM_T=
xmap       <D-A><    <Plug>AM_T<
xmap       <D-A>;    <Plug>AM_T;
xmap       <D-A>:    <Plug>AM_T:
xmap       <D-A>,    <Plug>AM_T,
xmap       <D-A>#    <Plug>AM_T#
xmap       <D-A>\|   <Plug>AM_T\|
xmap       <D-A>t    <Plug>AM_T\|
xnoremap   <D-a>t    :Align "\|"<CR>
xnoremap   <D-a>h    :Align "=>"<CR>

" Ack: {{{2
" let g:ackprg="ack-grep -H --nocolor --nogroup --column"
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" Underlinetag:  {{{2
nnoremap <silent> <Space>] :<C-u>UnderlineTagToggle<CR>

" NERDTree: {{{2
let NERDTreeWinSize             = 31 "default
let NERDTreeShowBookmarks       = 0
let NERDTreeMinimalUI           = 1
let NERDTreeDirArrows           = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMouseMode           = 1

" NERDCommenter: {{{2
let NERDSpaceDelims                = 1
let NERDCreateDefaultMappings      = 0
let g:NERDCustomDelimiters         = {}
let g:NERDCustomDelimiters.puppet  = { 'left': '#' }
let g:NERDCustomDelimiters.snippet = { 'left': '#' }

" Syntastic: {{{2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_enable_signs    = 1
let g:syntastic_auto_jump       = 1
let g:syntastic_auto_loc_list   = 1
let g:syntastic_quiet_warnings  = 1
let g:syntastic_enable_balloons = 0
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes':  ["vim","ruby","lua","sh"],
      \ }

" Unite: {{{2
let g:unite_enable_start_insert         = 1
let g:unite_split_rule                  = "botright"
" let g:unite_source_file_mru_time_format = "%Y/%m/%d(%a)-%H:%M:%S - "
let g:unite_enable_split_vertically     = 0
let g:unite_source_file_rec_ignore_pattern = '\%(.*\.chef/checksums/.*\)|\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'

nnoremap [unite]  <Nop>
nmap     <D-u>    [unite]
nmap     U        [unite]
nmap     <Space>u [unite]

let g:unite_source_ack_enable_print_cmd       = 1

" call unite#custom_max_candidates('file_rec', 1500)
" call unite#custom_max_candidates('ack', 100)

" Unite_Converters: {{{
" converter_numberd_register: {{{
let s:converter = {
      \ 'name' : 'converter_numberd_register',
      \ 'description' : 'numberd register only',
      \ }
function! s:converter.filter(candidates, context)"{{{
  if a:context.buffer_name == 'yankring'
    return a:candidates[0:10]
  else
    return a:candidates
  endif
endfunction"}}}
call unite#define_filter(s:converter)
unlet s:converter
" }}}
" }}}

call unite#custom_filters('register',
            \ ['matcher_default', 'sorter_default', 'converter_default'] )

" call unite#custom_filters('file_rec/async',
            " \ ['converter_relative_word', 'matcher_default',
            " \  'sorter_default', 'converter_relative_abbr'] )

" call unite#custom_filters('file_rec/async',
            " \ ['converter_relative_word', 'matcher_default',
            " \  'sorter_default', 'converter_relative_abbr'] )

if !exists("g:unite_source_ack_targetdir_shortcut")
    let g:unite_source_ack_targetdir_shortcut = {}
endif

function! s:set_SearchCmd(dict)
    for [key, val] in items(a:dict)
      if key =~ '/' | continue | endif
      let k = substitute(key,'\v^(.)','\u\1','')
      let set_cmd = "command! -nargs=1 Search".k." :Unite ack:".key.":<args>"
      exe set_cmd
    endfor
endfunction
call s:set_SearchCmd(g:unite_source_ack_targetdir_shortcut)

let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.unite = {}
let s:unite_menu_list = {
      \ "chef"     : "Unite chef_resource_ref",
      \ "script"   : "Unite scriptnames",
      \ "rtp"      : "Unite rtp",
      \ "outline"  : "Unite outline -no-quit -vertical -no-start-insert",
      \ "function" : "Unite function",
      \ "file_point" : "Unite file_point",
      \ "togglenumber" : "set invnumber",
      \ }

function! s:set_menu(dict)
  for [key, value] in items(a:dict)
    let g:unite_source_menu_menus[key] = {}
    let g:unite_source_menu_menus[key].candidates = [{
          \ "word": key,
          \ "kind": "command",
          \ "action__command": value
          \ }]
  endfor
endfunction
call s:set_menu(s:unite_menu_list)
let g:unite_source_menu_menus.file_rec = {}
let g:unite_source_menu_menus.file_rec.candidates = {
      \ 'ruby'      : "$HOME/Dropbox/dev/Ruby/rubyg/sample",
      \ 'bundle'    : '$HOME/.vim/bundle',
      \ 'neco'      : "$HOME/.vim/bundle/neocomplcache",
      \ 'unite'     : "$HOME/.vim/bundle/unite.vim",
      \ 'fog'       : '/var/lib/gems/1.8/gems/fog-0.10.0',
      \ 'chef'      : '/var/lib/gems/1.8/gems/chef-0.10.4',
      \ 'nova'      : "$HOME/local/github/openstack/nova-2011.1/nova",
      \ 'cookbooks' : "$HOME/local/chef/cookbooks",
      \ 'oscookbooks': "$HOME/local/chef/openstack-cookbooks",
      \ }
function! g:unite_source_menu_menus.file_rec.map(key, value)
  return {
        \ "word": a:key,
        \ "kind": "command",
        \ "action__command": printf("Unite file_rec:%s", expand(a:value))
        \ }
endfunction
let g:unite_source_menu_menus.ack = deepcopy(g:unite_source_menu_menus.file_rec)
function! g:unite_source_menu_menus.ack.map(key, value)
  return {
        \ "word": a:key,
        \ "kind": "command",
        \ "action__command": printf("Unite ack:%s", expand(a:value))
        \ }
endfunction

" Unite_my_menu: {{{
function! s:build_candidate(prefix, dict, cmd_format)"{{{
  let ret = []
  for [key,val] in items(a:dict)
    if key =~ '/' | continue | endif
    call add(ret, {
          \ "word": a:prefix . key,
          \ "source": "my_menu",
          \ "kind": "command",
          \ "action__command": printf(a:cmd_format, expand(val))
          \ })
  endfor
  return ret
endfunction"}}}
let s:unite_source = { "name": 'my_menu' }
function! s:unite_source.gather_candidates(args, context)"{{{
  return 
        \ s:build_candidate('[rec ] ', g:unite_source_ack_targetdir_shortcut, "FileRec %s") +
        \ s:build_candidate('[Ack ] ', g:unite_source_ack_targetdir_shortcut, "Unite ack:%s") +
        \ s:build_candidate('[rake] ', {"rake": "rake"}, "Unite %s")
endfunction"}}}
call  unite#define_source(s:unite_source)
unlet s:unite_source
"}}}

" command! Variables   :Unite -buffer-name=variable var/buffer var/window var/tabpage var/global var/script var/vim
command! Variables   :Unite variable
command! ScriptNames :Unite scriptnames
command! RTP         :Unite rtp
command! OutLine     :Unite outline -no-quit -vertical -no-start-insert
" command! File        :Unite file -buffer-name=file
command! Function    :Unite function

" Unite_ChefResources: {{{
" MENU_ITEMS: {{{
let s:chef_resources = [
      \ "Overview",
      \ "Meta",
      \ "CommonActions",
      \ "CommonAttributes",
      \ "ConditionalExecution",
      \ "Notifications",
      \ "CookbookFile",
      \ "Cron",
      \ "Deploy",
      \ "Directory",
      \ "ErlangCall",
      \ "Execute",
      \ "File",
      \ "Git",
      \ "Group",
      \ "HTTPRequest",
      \ "Ifconfig",
      \ "Link",
      \ "Log",
      \ "Mdadm",
      \ "Mount",
      \ "Ohai",
      \ "Package",
      \ "PowerShellScript",
      \ "RemoteDirectory",
      \ "RemoteFile",
      \ "Route",
      \ "RubyBlock",
      \ "SCM",
      \ "Script",
      \ "Service",
      \ "Subversion",
      \ "Template",
      \ "User",
      \ "OpscodeCookbookLWRPs"
      \ ]

" }}}

let s:unite_source = { 
      \ "name": 'chef_resource_ref',
      \ "hooks": {},
      \ "description": "chef_resource_ref",
      \ }

function! s:unite_source.hooks.on_init(args, context) "{{{
  let url_base = "http://wiki.opscode.com/display/chef/Resources#Resources-"
  let candidates = []
  for resource in s:chef_resources
    call add(candidates, {
          \ "word": resource,
          \ "action__path": url_base . resource,
          \ "kind": "uri",
          \ })
  endfor
  let a:context.source__candidates = candidates
endfunction"}}}

function! s:unite_source.gather_candidates(args, context)"{{{
  let candidates = []
  return a:context.source__candidates
endfunction"}}}

call  unite#define_source(s:unite_source)
unlet s:unite_source
" }}}


if g:GUI_MODE
  nnoremap <silent> <C-z>          :<C-u>UniteResume<CR>
endif
" nnoremap <silent> <C-z>          :<C-u>UniteResume<CR>
nnoremap <silent> [unite]u       :<C-u>Unite<Space>
nnoremap <silent> [unite]f       :<C-u>Unite -buffer-name=file file<CR>
nnoremap <silent> [unite]d       :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]t       :<C-u>UniteWithCursorWord tag<CR>
nnoremap <silent> [unite]a       :<C-u>UniteWithCursorWord -buffer-name=ack ack<CR>
nnoremap <silent> [unite]s       :<C-u>Unite source<CR>
" nnoremap <silent> <Space><Space> :<C-u>Unite buffer<CR>
nnoremap <silent> <D-f>          :<C-u>Unite my_menu<CR>
nnoremap <silent> [unite]rm  :<C-u>UniteWithCursorWord -start-insert ref/man<CR>
nnoremap <silent> [unite]rr  :<C-u>UniteWithCursorWord -start-insert ref/refe<CR>
nnoremap <silent> [unite]rp  :<C-u>UniteWithCursorWord -start-insert ref/pydoc<CR>
nnoremap <silent> <Space>o  :<C-u>Unite outline<CR>
nnoremap <silent> <Space>b :<C-u>Unite buffer<CR>
nnoremap <silent> <C-p> :<C-u>Unite buffer file_mru file -buffer-name=file<CR>
" nnoremap <silent> <Tab> :<C-u>Unite buffer file_mru file -buffer-name=file<CR>
nnoremap <silent> <Space><Space> :<C-u>Unite buffer file_mru file -buffer-name=file<CR>
" nnoremap <silent> <Space>j :<C-u>Unite buffer file_mru file -buffer-name=file<CR>
nnoremap <silent> <D-y> :<C-u>Unite register -no-start-insert -buffer-name=yankring -winheight=13 -auto-resize<CR>
inoremap <silent> <D-y> <Esc>:Unite register -no-start-insert -buffer-name=yankring -winheight=13 -auto-resize<CR>

nnoremap <silent> <Space>g       :<C-u>UniteWithCursorWord tag<CR>
nnoremap <silent> <Space>r       :<C-u>Unite rake<CR>
nnoremap <silent> <Space>F       :<C-u>exe  "Unite file_rec/async:" . expand('%:p:h') . " -buffer-name=files"<CR>
" nnoremap <silent> <Space>F       :<C-u>UniteWithBufferDir file_rec/async -buffer-name=files<CR>
" nnoremap <silent> <Space>f       :<C-u>Unite file -buffer-name=file<CR>
" nnoremap <silent> <Space>F       :<C-u>exe  "Unite file_rec:" . expand('%:p:h') . " -buffer-name=files"<CR>
" nnoremap <silent> <Space>f       :<C-u>Unite file_rec -buffer-name=file<CR>

function! s:escape_visual(...) "{{{
  let escape = a:0 ? a:1 : ''
  normal `<
  let s = col('.') - 1
  normal `>
  let e = col('.') - 1
  let line = getline('.')
  let pat = line[s : e]
  return escape(pat, escape)
endfunction"}}}
function! s:visual_unite_input() "{{{
  return s:escape_visual(" ")
endfunction"}}}
function! s:visual_unite_arg() "{{{
  return s:escape_visual(' :\')
endfunction"}}}

" unite ack
let g:unite_source_ack_ignore_case = 0
command! UniteAckToggleCase :let g:unite_source_ack_ignore_case=!g:unite_source_ack_ignore_case|let g:unite_source_ack_ignore_case
nnoremap <silent> <Space>a  :<C-u>exe "Unite -buffer-name=ack ack::" . escape(expand('<cword>'),' :\')<CR>
xnoremap <silent> <Space>a  :<C-u>exe "Unite -buffer-name=ack ack::" . <SID>visual_unite_arg()<CR>
nnoremap <silent> <Space>A  :<C-u>UniteResume ack<CR>

command! Occur :exe "Unite -input=" . escape(@/, ' ') . " line"
command! -nargs=1 AckUnite :Unite ack::<args>

" unite line
" emacs-occur-like
nnoremap <Space>l       :<C-u>UniteWithCursorWord line<CR>
xnoremap <Space>l  <Esc>:<C-u>exe "Unite -input=" . <SID>escape_visual(' '). " line"<CR>
" nnoremap <Space>o :<C-u>Occur<CR>

" Emacs's incremental-search forward and backward to occur with <C-o>
" =====================================================
let s:cmdtypes = {
      \ 'search_forward': '/',
      \ 'search_backwward': '?',
      \ 'search': '[/?]',
      \ 'ex': ':'
      \ }
function! s:is_search_mode(cmdtype)
  return getcmdtype() =~# get(s:cmdtypes, a:cmdtype)
endfunction

cnoremap <expr> <C-o> <SID>is_search_mode('search')
      \ ? '<Esc>:<C-u>nohlsearch\|Occur<CR>'
      \ : "\<C-o>"

" serch mode で / をエスケープ
" cnoremap <expr> / <SID>is_search_mode('search_forward') ? '\/' : '/'
command! VimShellBuffer :exe "VimShellPop " . expand("%:h")
" cnoremap <expr> vs <SID>is_search_mode('search_forward') ? 'vs' : "VimShellPop " .  expand("%:h")
" cnoremap <expr> vs getcmdtype() == '/' ? 'vs' : "VimShellPop " .  expand("%:h")
nnoremap <silent> [unite]b   :<C-u>Unite bookmark<CR>

" cnoremap <expr> <C-o>  getcmdtype() == '/'
" \ ? '<Esc>:<C-u>nohlsearch\|exe "Unite -input=" . escape(@/," ") . " line:forward"<CR>'
" \ : getcmdtype() == '?'
" \ ? '<Esc>:<C-u>nohlsearch\|exe "Unite -input=" . escape(@/," ") . " line:backward"<CR>'
" \ : "\<C-o>"

" occur(=Unite line) forward/backward
nnoremap ]o :UniteWithCursorWord line:forward<CR>
nnoremap [o :UniteWithCursorWord line:backward<CR>
" nnoremap * :UniteWithCursorWord line:backward<CR>
" nnoremap # :UniteWithCursorWord line:forward<CR>

function! s:normal_other(cmd)
  silent wincmd p
  try
    if a:cmd == '_C-e'
      let cmd = "normal! 3\<C-e>"
    else
      exe "normal! " . a:cmd
      " let cmd = "normal! 3" . a:cmd
    endif
  finally
    silent wincmd p
  endtry
endfunction

let g:unite_source_file_mru_limit = 200
function! Set_subtituite_pattern(buffer_name) "{{{
  " http://d.hatena.ne.jp/thinca/20101027/1288190498
  " 環境変数の展開
  call unite#set_substitute_pattern(a:buffer_name, '\$\w\+', '\=eval(submatch(0))', 200)
  call unite#set_substitute_pattern(a:buffer_name, '[^~.]\zs/', '*/*', 20)
  call unite#set_substitute_pattern(a:buffer_name, '/\ze[^*]', '/*', 10)

  " current file dir
  call unite#set_substitute_pattern(a:buffer_name, '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
  " current dir
  call unite#set_substitute_pattern(a:buffer_name, '^@', '\=getcwd()."/*"', 1)
  " home?
  call unite#set_substitute_pattern(a:buffer_name, '^\\', '~/*')

  " short cut
  call unite#set_substitute_pattern(a:buffer_name, '^;v', '~/.vim/*')
  call unite#set_substitute_pattern(a:buffer_name, '^;b', '~/.vim/bundle/*')
  call unite#set_substitute_pattern(a:buffer_name, '^;g', '/var/lib/gems/1.8/gems/*')
  call unite#set_substitute_pattern(a:buffer_name, '^;r', '\=$VIMRUNTIME."/*"')
  call unite#set_substitute_pattern(a:buffer_name, '^;c', '~/local/chef/cookbooks/*')
  call unite#set_substitute_pattern(a:buffer_name, '^;n', '~/local/github/openstack/')

  call unite#set_substitute_pattern(a:buffer_name, '\*\*\+', '*', -1)
  call unite#set_substitute_pattern(a:buffer_name, '^\~', escape($HOME, '\'), -2)
  " call unite#set_substitute_pattern(a:buffer_name, '\\\@<! ', '\\ ', -20)
  " call unite#set_substitute_pattern(a:buffer_name, '\\ \@!', '/', -30)
  " call unite#set_substitute_pattern(a:buffer_name, '[[:alnum:]]', ' \0', 100)
  " call unite#set_substitute_pattern(a:buffer_name, '[[:alnum:]]', ' \0', 100)

endfunction "}}}
call Set_subtituite_pattern("file")

" history {{{
let s:unite_file = unite#file_with_history#new("file", function("Set_subtituite_pattern") )
function! g:unite_file(...)
  call call(s:unite_file.launch, a:000, s:unite_file)
endfunction
function! g:unite_file_resume(direction)
  call s:unite_file.resume(a:direction)
endfunction

command! -nargs=* -complete=dir File :call g:unite_file(<f-args>)
nnoremap <silent> <Space>f  :<C-u> File<CR>

" file_rec:
let s:unite_file_rec = unite#file_with_history#new("file_rec", function("Set_subtituite_pattern") )
function! g:unite_file_rec(...)
  call call(s:unite_file_rec.launch, a:000, s:unite_file_rec)
endfunction
function! g:unite_file_rec_resume(direction)
  call s:unite_file_rec.resume(a:direction)
endfunction
command! -nargs=* -complete=dir FileRec :call g:unite_file_rec(<f-args>)
nnoremap <silent> <Space>f  :<C-u> FileRec<CR>
" }}}
" Vimfiler: {{{2
let g:vimfiler_safe_mode_by_default = 0
" EchoDoc: {{{2
let g:echodoc_enable_at_startup = 1
" Surround: {{{2
let g:surround_no_mappings = 1
let g:surround_insert_tail = "${" . "9}"
imap <C-S> <Plug>Isurround
imap <C-G> <Plug>ISurround
xmap s     <Plug>VSurround
xmap S     <Plug>VgSurround
" xmap gS    <Plug>VgSurround

nmap ds    <Plug>Dsurround
nmap cs    <Plug>Csurround
nmap ys    <Plug>Ysurround
nmap yS    <Plug>YSurround
nmap yss   <Plug>Yssurround
nmap ySs   <Plug>YSsurround
nmap ySS   <Plug>YSsurround
nmap s     ysiw
nmap S     ysiW
nmap ss    yss
" nmap <D-s> ysiw
" nmap <D-S> ysiW
xmap <D-s> <Plug>VSurround
" xmap s     <Plug>VSurround
let g:surround_custom_mapping = {}"{{{
let g:surround_custom_mapping._ = {
      \ 'p':  "<pre>\r</pre>",
      \ 'w':  "%w(\r)",
      \ }
let g:surround_custom_mapping.help = {
      \ 'p':  "> \r <",
      \ }
let g:surround_custom_mapping.markdown = {
      \ 'c':  "``` ${1" . "} \r```",
      \ 'k':  " <kbd>`\r`</kbd> ",
      \ }
let g:surround_custom_mapping.ruby = {
      \ '-':  "<% \r %>",
      \ '=':  "<%= \r %>",
      \ '9':  "(\r)",
      \ '5':  "%(\r)",
      \ '%':  "%(\r)",
      \ 'w':  "%w(\r)",
      \ '#':  "#{\r}",
      \ '3':  "#{\r}",
      \ 'e':  "begin \r end",
      \ 'E':  "<<EOS \r EOS",
      \ 'i':  "if  \r end",
      \ 'u':  "unless \1unless\1 \r end",
      \ 'c':  "class \1class\1 \r end",
      \ 'm':  "module \1module\1 \r end",
      \ 'd':  "def \1def\1\2args\r..*\r(&)\2 \r end",
      \ 'p':  "\1method\1 do \2args\r..*\r|&| \2\r end",
      \ 'P':  "\1method\1 {\2args\r..*\r|&|\2 \r }",
      \ }
let g:surround_custom_mapping.javascript = {
      \ 'f':  "function(){ \r }"
      \ }
let g:surround_custom_mapping.lua = {
      \ 'f':  "function(){ \r }"
      \ }
let g:surround_custom_mapping.python = {
      \ 'p':  "print( \r)",
      \ '[':  "[\r]",
      \ }
let g:surround_custom_mapping.vim= {
      \'f':  "function! \r endfunction"
      \ }
"}}}

" Phrase: {{{2

command! Phrase     :Unite phrase -no-quit -no-start-insert -vertical
nnoremap <silent>   <Space>p  :<C-u>Unite phrase<CR>
" nmap M <Plug>(phrase#edit)
" xmap M <Plug>(phrase#create)
xmap <Space>p <Plug>(phrase-create)

nmap gp <Plug>(phrase-edit)
xmap gp <Plug>(phrase-create)

" TryIt: {{{2
let g:tryit_dir = "$HOME/.vim/tryit"
nmap  T <Plug>(tryit-this)
xmap  T <Plug>(tryit-this)
nmap  <Space>t <Plug>(tryit-ask)
xmap  <Space>t <Plug>(tryit-ask)

" Quickhl: {{{2
" let g:quickhl_keywords = [
      " \ {"pattern": '\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}', "regexp": 1 },
      " \ ]
" let g:quickhl_keywords = [
      " \ {"pattern": "t9md" },
      " \ {"pattern": "Shougo" },
      " \ {"pattern": '\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}', "regexp": 1 },
      " \ "thinca",
      " \ "ujihisa",
      " \ ]
" 192.168.111.111
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)
" xmap <Space>j <Plug>(quickhl-match)

" QuickRun: {{{2
let g:quickrun_no_default_key_mappings = 1
let g:quickrun_config    = {}
let g:quickrun_config.sh = {'command' : 'bash'}
let g:quickrun_config.markdown = {'outputter' : 'browser'}

" Foldtext: {{{2
let perl_fold              = 1
let g:Foldtext_enable      = 1
let g:Foldtext_perl_enable = 1
let g:Foldtext_tex_enable  = 1
let g:Foldtext_cpp_enable  = 1

" Ref: {{{2
command! -nargs=? Refe    :call ref#ref("refe " . <q-args>)
command! -nargs=? Eijiro  :call ref#ref("-new alc " . <q-args>)
command! -nargs=? Pydoc   :call ref#ref("pydoc " . <q-args>)
command! -nargs=? Perldoc :call ref#ref("perldoc " . <q-args>)
command! -nargs=? Erlang  :call ref#ref("erlang " . <q-args>)
command! -nargs=? Man     :call ref#ref("-new man " . <q-args>)

" NeoCompleCache: {{{2
let g:neocomplcache_text_mode_filetypes          = {}
let g:neocomplcache_text_mode_filetypes = {
      \ "markdown" : 1,
      \ "textile"  : 1,
      \ "help"     : 1,
      \ "cucumber" : 1,
      \ }

let g:neocomplcache_enable_at_startup            = 1

let g:neocomplcache_enable_auto_select           = 0
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion   = 1
let g:neocomplcache_enable_smart_case            = 0
let g:neocomplcache_enable_ignore_case           = 1
" let g:neocomplcache_enable_quick_match           = 0

let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_min_syntax_length            = 3

let g:neocomplcache_snippets_dir = "$HOME/.vim/snippets"
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'tmux' :    $HOME.'/.vim/dict/tmux.dict',
      \ 'scheme' : $HOME.'/.gosh_completions',
      \ }

" let g:neocomplcache_lock_buffer_name_pattern = ""

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_keyword_patterns['tmux'] = '\h\k*'

" Plugin key-mappings.
imap     <C-k>       <Plug>(neocomplcache_snippets_force_expand)
smap     <C-k>       <Plug>(neocomplcache_snippets_force_expand)
imap     <C-j>       <Plug>(neocomplcache_start_unite_complete)
imap     <C-l>       <Plug>(neocomplcache_start_unite_snippet)

inoremap <expr><CR> pumvisible() ?
      \ neocomplcache#smart_close_popup() :
      \ "\<CR>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-e> neocomplcache#cancel_popup()
" inoremap <expr><C-g> neocomplcache#undo_completion()
nnoremap <silent>    <Space>se  :<C-u>NeoComplCacheEditSnippets<CR>

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable()
      \ ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neocomplcache#sources#snippets_complete#expandable()
      \ ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby   = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php    = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c      = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp    = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Other: {{{2
let g:netrw_http_cmd = "elinks"
let g:netrw_http_xcmd = "-dump -no-references >"

" VimShell: {{{2
" nmap <F8> <Plug>(vimshell_split_switch)
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
" let g:vimshell_ignore_case = 0
let g:vimshell_prompt = "$ "
" let g:vimshell_prompt = $USER."% "
call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
let  g:vimshell_execute_file_list['zip'] = 'zipinfo'
call vimshell#set_execute_file('tgz,gz', 'gzcat')
call vimshell#set_execute_file('tbz,bz2', 'bzcat')

function! g:my_chpwd(args, context)
  call vimshell#execute('ls')
endfunction

autocmd FileType int-* call s:interactive_settings()
function! s:interactive_settings()
endfunction

" let g:vimshell_right_prompt = 'getcwd()'
" let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'


" Chef: {{{2
function! ChefNerdTreeFind(env)"{{{
  try
    :NERDTreeFind
    let scrolloff_orig = &scrolloff
    let &scrolloff = 15
    normal! jk
    wincmd p
  finally
    let &scrolloff = scrolloff_orig
  endtry
endfunction"}}}
let g:chef = {}
let g:chef.hooks = ['ChefNerdTreeFind']
" let g:chef.hooks = []
let g:chef.any_finders = ['Attribute', 'Source', 'Recipe', 'Definition', "LWRP"]

function! s:ft_chef_hook()"{{{
  call <SID>set_search_engine('chef')
  " Mouse:
  " Left mouse click to GO!
  nnoremap <buffer> <silent> <2-LeftMouse> :<C-u>ChefFindAny<CR>
  " Right mouse click to Back!
  nnoremap <buffer> <silent> <RightMouse> <C-o>

  " Keyboard:
  nnoremap <buffer> <silent> <D-a> :<C-u>ChefFindAny<CR>
  nnoremap <buffer> <silent> <D-s> :<C-u>ChefFindAnySplit<CR>
  nnoremap <buffer> <silent> <D-r> :<C-u>ChefFindRelated<CR>
  " nnoremap <buffer> <silent> <CR>  :<C-u>ChefFindAny<CR>
  let b:phrase_ext = 'chef'
endfunction"}}}

" Vim Bundle {{{1
" Bundle: tpope/vim-pathogen
"
" Generally Useful:
" Bundle: scrooloose/nerdtree ebb2835c456a3dfc42b36448fb68bd07688e54ca
" Bundle: scrooloose/syntastic
" Bundle: vim-scripts/JSON.vim
" Bundle: vim-scripts/haproxy
" Bundle: vim-scripts/Jinja
" Bundle: vim-scripts/txt.vim
" Bundle: vim-scripts/sudo.vim
"
" # Bundle: tsukkee/lingr-vim
" # Bundle: Raimondi/VimRegEx.vim
"
" not supprt multibyte char? so I don't use this
" # Bundle: vim-scripts/IndexedSearch
" # Bundle: Lokaltog/vim-easymotion
" Bundle: depuracao/vim-rdoc

" Programming:
" Bundle: scrooloose/nerdcommenter
" Bundle: tpope/vim-surround
" Bundle: int3/vim-extradite
" Bundle: majutsushi/tagbar
" Bundle: jgdavey/vim-blockle

" Bundle: vim-scripts/Align
" Bundle: tpope/vim-repeat
" Bundle: tpope/vim-fugitive
" Bundle: vim-scripts/vcscommand.vim
" # Bundle: tpope/vim-endwise
" # Bundle: ervandew/supertab
" # Bundle: vim-scripts/jQuery
" Bundle: tpope/vim-git
" Bundle: tpope/vim-markdown
" Bundle: timcharper/textile.vim
" Bundle: kchmck/vim-coffee-script

" Ruby/Rails Programming:
" Bundle: vim-ruby/vim-ruby
" Bundle: tpope/vim-rails
" # Bundle: tpope/vim-rake
" # Bundle: janx/vim-rubytest
" # Bundle: tsaleh/vim-shoulda
" Bundle: tpope/vim-cucumber
" # Bundle: tpope/vim-haml
" # Bundle: astashov/vim-ruby-debugger
" # Bundle: ecomba/vim-ruby-refactoring

" Bundle: rodjek/vim-puppet
" # Bundle: godlygeek/tabular

" Other compilation by t9md
" Bundle: t9md/vim-quickhl
" Bundle: t9md/vim-ruby-xmpfilter
" Bundle: t9md/vim-chef
" Bundle: t9md/vim-textmanip
" Bundle: t9md/vim-foldtext
" Bundle: t9md/vim-phrase
" Bundle: t9md/vim-tryit
" Bundle: t9md/vim-resizewin
" Bundle: t9md/vim-underlinetag
" Bundle: t9md/vim-ruby_eval
" Bundle: t9md/vim2tmux.vim
" Bundle: t9md/vim-quicktag
" Bundle: t9md/vim-unite-ack
" Bundle: t9md/vim-surround_custom_mapping
" Bundle: t9md/vim-nerdtree_plugin_collections
" Bundle: t9md/vim-misc-experiment
" Bundle: t9md/vim-fthook
" Bundle: t9md/vim-textobj-function-ruby
" Bundle: t9md/vim-unite-experiment
"
" Bundle: nathanaelkane/vim-indent-guides
" Bundle: vim-scripts/Color-Sampler-Pack
" Bundle: vim-scripts/Super-Shell-Indent
" Bundle: mileszs/ack.vim
" Bundle: vim-scripts/ZoomWin
" # Bundle: spf13/vim-easytags
" # Bundle: kikijump/tslime.vim
" # Bundle: vim-scripts/multisearch.vim

" Bundle: Shougo/vimproc
" Bundlecommand: [ "$(uname -s)" = "Darwin" ] && make -f make_mac.mak ||  make -f make_gcc.mak
" Bundle: Shougo/vimshell
" Bundle: Shougo/unite.vim
" Bundle: Shougo/vimfiler
" Bundle: Shougo/neocomplcache
" #Bundle: Shougo/echodoc
"
" Bundle: mattn/gist-vim

" Bundle: thinca/vim-quickrun
" Bundle: thinca/vim-visualstar
" Bundle: thinca/vim-qfreplace
" Bundle: thinca/vim-localrc
" Bundle: thinca/vim-ref
" Bundle: thinca/vim-openbuf
" Bundle: thinca/vim-prettyprint
" Bundle: thinca/vim-scouter
" Bundle: thinca/vim-ambicmd

" Bundle: tyru/restart.vim
" Bundle: tyru/open-browser.vim
" Bundle: vim-scripts/newspaper.vim
" # Bundle: motemen/hatena-vim
" # Bundle: Raimondi/delimitMate
" Bundle: ujihisa/neco-look

" Unite plugin
" Bundle: thinca/vim-poslist
" Bundle: h1mesuke/unite-outline
" Bundle: tsukkee/unite-help
" Bundle: ujihisa/unite-colorscheme
" Bundle: ujihisa/tabpagecolorscheme
" Bundle: tsukkee/unite-tag
" Bundle: sgur/unite-qf
" Bundle: ujihisa/unite-locate
" Bundle: ujihisa/unite-rake
" #Bundle: tacroe/unite-alias

" textobj extention
" Bundle: vim-scripts/textobj-user
" Bundle: vim-scripts/textobj-indent
" Bundle: vim-scripts/textobj-syntax
" Bundle: vim-scripts/textobj-function
" Bundle: thinca/vim-textobj-function-javascript
" Bundle: thinca/vim-textobj-function-perl
" Bundle: thinca/vim-textobj-comment
" Bundle: nelstrom/vim-textobj-rubyblock
" Bundle: kana/vim-textobj-syntax
" Bundle: kana/vim-smartword
"
" Experiment:
" Bundle: AndrewRadev/splitjoin.vim
" Bundle: altercation/vim-colors-solarized
"
"}}}
