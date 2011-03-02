"=================================================
" vim: set sw=4 sts=4 et fdm=marker fdc=3 fdl=1:
"=================================================
let g:Is_unix  = has('unix')
let g:Is_mac   = has('gui_macvim')
let g:Is_linux = ! g:Is_mac && g:Is_unix
let g:Is_win   = has('win32')
let g:GUI_MODE = has("gui_running") ? 1 : 0

filetype off
let g:pathogen_disabled = [
            \ "endwise",
            \ "textobj-between",
            \ "YAIFA",
            \ "ManPageView",
            \ "minibufexpl.vim",
            \ "trailing-whitespace"
            \ ]
call pathogen#runtime_append_all_bundles()

" Basic setting {{{
"-----------------------------------------------------------------
let $VIMDIR=$HOME."/.vim"
filetype indent plugin on
syntax on
set nocompatible
set clipboard=unnamed
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set hlsearch
set noshowmatch
set matchtime=2
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set ignorecase
set smartcase
set autoindent
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P
set laststatus=2 "ステータスラインを常に表示
set wildmenu
set helplang=en,ja
set showtabline=1 " show tab page when at least two tab exist"
set hidden
set grepprg=grep\ -n\ $*\ /dev/null\ --exclude\ \"\*\.svn\*\"
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore&
set wildignore+=*.swp,*.bak,*.pyc,*.pyo,*.class
set title                " change the terminal's title
set visualbell t_vb=
set noerrorbells         " don't beep

" Syntax highlight for complex documents is a little slow.  Tweaking
" the settings a bit to reduce the load (especially on remote
" machines)
set synmaxcol=400
syn sync minlines=50

runtime macros/matchit.vim      " Make '%' more useful
set shortmess=atI               " get rid of prompts I don't care about
set winaltkeys=no

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=utf-8,latin1
endif

if exists('&ambiwidth')
    set ambiwidth=double
endif
"}}}

if Is_mac
    let $RUBY_DLL = "/Users/taqumd/.rvm/rubies/ruby-1.8.7-p302/lib/libruby.dylib"
endif

if g:Is_mac
    let macvim_skip_cmd_opt_movement = 1
endif


" SnipMate {{{
let g:my_snippets_dir = "$HOME/.vim/snippets"
"}}}

" Flag to tweek behavior {{{
let g:select_win_with_Contrl_hjkl        = 1
let g:select_win_with_Arrow_key          = 1
let g:change_winsize_with_Shift_allow    = 1
let g:swap_colon_and_semicolon           = 1 " US key board
let g:move_win_with_Shift_META_Arrow_key = 1
let g:move_win_with_META_HJKL            = 1
let g:duplicate_selection                = 1
let g:move_selection_with_Control_hjkl   = 1
"}}}

" GUI Specific {{{
"-----------------------------------------------------------------
" CoffeeScript Like {{{
autocmd FileType coffee nnoremap  <buffer> <silent> <M-R> :QuickRun<CR>
autocmd FileType coffee inoremap  <buffer> <silent> <M-R> <C-o>:QuickRun<CR>
autocmd FileType coffee vnoremap  <buffer> <silent> <M-R> :QuickRun<CR>
autocmd FileType coffee nnoremap  <buffer> <silent> <M-r> :QuickRun 'coffee -cp --no-wrap'<CR>
autocmd FileType coffee inoremap  <buffer> <silent> <M-r> <C-o>:QuickRun 'coffee -cp --no-wrap'<CR>
autocmd FileType coffee vnoremap  <buffer> <silent> <M-r> :QuickRun 'coffee -cp --no-wrap'<CR>
"}}}

autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
" autocmd FileType python inoremap <buffer> <silent> <C-Space> <C-x><C-o>

" autocmd BufWritePost *.rb silent make -c %
autocmd FileType ruby noremap  <buffer> <silent> <M-r> moHmt:%call Xmpfilter()<CR>'tzt`o
autocmd FileType ruby inoremap <buffer> <silent> <M-r> <Esc>moHmt:%call Xmpfilter()<CR>'tzt`oa
autocmd FileType ruby vnoremap <buffer> <silent> <M-r> :call Xmpfilter()<CR>
autocmd FileType ruby noremap  <buffer> <silent> <M-m> :call XmpCommentToggle()<CR>
autocmd FileType ruby inoremap <buffer> <silent> <M-m> <C-o>:call XmpCommentToggle()<CR>
autocmd FileType ruby vnoremap <buffer> <M-x>r      :RubyBlockSwitch<CR>
autocmd FileType ruby nnoremap <buffer> <M-x>r      :RubyBlockSwitch<CR>
"}}}

" Color and ColorScheme {{{
"-------------------------------------------------
colorscheme molokai
" colorscheme vividchalk
" colorscheme railscasts
" colorscheme skittles_dark
" colorscheme ir_black

set t_Co=256
set t_Sb=[4%dm
set t_Sf=[3%dm

highlight Folded     ctermfg=117 ctermbg=NONE  guifg=Grey70 guibg=NONE
highlight FoldColumn ctermfg=117 ctermbg=NONE  guifg=Grey70 guibg=#000000
highlight SignColumn ctermfg=117 ctermbg=NONE  guifg=Grey70 guibg=#000000
highlight NonText    ctermfg=244 guifg=#4a4a59
highlight SpecialKey ctermfg=244 guifg=#4a4a59

"}}}

" Key Binding {{{
"-----------------------------------------------------------------
let mapleader = ","

nnoremap <silent> <M-W> :<C-u>WrapToggle<CR>
nnoremap <C-S-M-=> :<C-u>call SetTransparency("+")<CR>
nnoremap <C-M--> :<C-u>call SetTransparency("+")<CR>
nnoremap <C-M-=> :<C-u>call SetTransparency("-")<CR>
nnoremap <S-LeftMouse> :<C-u>help<Space><C-r><C-W><CR>
nnoremap <C-Tab>   :bnext<CR>
nnoremap <C-S-Tab> :bNext<CR>
nnoremap >  :bnext<CR>
nnoremap <  :bNext<CR>

" move window with hljk such as M-S-h(=M-H)
if g:move_win_with_META_HJKL
    nnoremap <silent> <M-H> :wincmd H<CR>
    nnoremap <silent> <M-L> :wincmd L<CR>
    nnoremap <silent> <M-K> :wincmd K<CR>
    nnoremap <silent> <M-J> :wincmd J<CR>
endif
nnoremap <silent> <M-2> :split<CR>
nnoremap <silent> <M-3> :vsplit<CR>

" Chose Alternate buffer
inoremap <M-e> <C-o><C-^>
nnoremap <M-e> <C-^>
nnoremap <M-E> :<C-u>Eijiro <C-r><C-w><CR>

if g:move_win_with_Shift_META_Arrow_key
    nnoremap <silent> <S-M-Left>  :wincmd H<CR>
    nnoremap <silent> <S-M-Right> :wincmd L<CR>
    nnoremap <silent> <S-M-Up>    :wincmd K<CR>
    nnoremap <silent> <S-M-Down>  :wincmd J<CR>
endif

" Tag Jump with split
nnoremap <M-g>  <C-w>]
nnoremap <M-G>  <C-w>]<C-w>T

" Select Linet with <M-l>
inoremap <M-l>  <Esc>V
nnoremap <M-l>  V
vnoremap <M-l>  ip

" Comment toggle with <M-;> powered by NERDCommenter
nnoremap <silent> <M-;>      :call NERDComment(0, "toggle")<CR>
vnoremap <silent> <M-;>      :call NERDComment(0, "toggle")<CR>
inoremap <silent> <M-;> <C-o>:call NERDComment(0, "toggle")<CR>

" QuckRun with <M-r> powered by thinca's QuickRun
nnoremap <silent> <M-r>      :<C-u>QuickRun<CR>
vnoremap <silent> <M-r>      :QuickRun<CR>
inoremap <silent> <M-r> <C-o>:<C-u>QuickRun<CR>

nnoremap <M-t>      :<C-u>tabnew<CR>
nnoremap <M-T>      <C-w>T
" nnoremap <M-f>f     :CommandT<CR>

" nnoremap <M-f><M-g> :Occur<CR>
cnoremap <M-o> <CR>:Occur<CR>
cnoremap <C-o> <CR>:Occur<CR>

" code fold movement
nnoremap <M-z> za
nnoremap <M-P> zk
nnoremap <M-N> zj
nnoremap <M-O> za

nnoremap <M-a> ggVG
" Tab movement
nnoremap <M-]> gt
nnoremap <M-[> gT

if g:duplicate_selection
    vmap <M-d>    <Plug>(TextManup.duplicate_selection_v)
    nmap <M-d>    <Plug>(TextManup.duplicate_selection_n)
    nmap <Space>d <Plug>(TextManup.duplicate_selection_n)
    vmap <Space>d <Plug>(TextManup.duplicate_selection_v)
    vmap D        <Plug>(TextManup.duplicate_selection_v)
endif

" Save in insertmode by <M-s>
inoremap <M-s> <C-o>:<C-u>write<CR>
nnoremap <silent> <M-R> :NERDTreeFind<CR>
nnoremap <silent> <M-n> :NERDTreeFind<CR>

" close window
nnoremap <M-w> :wincmd q<CR>
vnoremap <M-w> :wincmd q<CR>
vnoremap <M-c> y
nnoremap <M-v> p
vnoremap <M-v> p

nnoremap <Space>v ggVG
nnoremap <silent> <Space>/ :nohlsearch<CR>
nnoremap <silent> <Space>l  :set list!\|HighlightTrailingWhiteSpace<CR>
nnoremap <silent> <Space>n  :set number!<CR>
nnoremap <silent> <Space>w  :set wrap!<CR>
" nnoremap <silent> <Leader>cp  :checkpath<CR>
nnoremap Y y$
vnoremap Q gq
nnoremap Q gqap
set listchars=tab:▸\ ,eol:¬ " Use the same symbols as TextMate for tabstops and EOLs

nmap     <silent> <Leader>f  <Plug>(CheckFileTypeAtCursor)

nnoremap <silent> M  :PhraseEdit<CR>
vnoremap <silent> M  :PhraseCreate<CR>
nnoremap <silent> <Space>p  :PhraseList<CR>
" nnoremap <silent> <Space>pe  :PhraseEdit<CR>
" vnoremap <silent> <Space>pe  :PhraseEdit<CR>
" vnoremap <silent> <Space>pc  :PhraseCreate<CR>

if g:select_win_with_Contrl_hjkl
    nnoremap <silent> <C-h> :wincmd h<CR>
    nnoremap <silent> <C-l> :wincmd l<CR>
    nnoremap <silent> <C-k> :wincmd k<CR>
    nnoremap <silent> <C-j> :wincmd j<CR>
endif

if g:select_win_with_Arrow_key
    nnoremap <silent> <Left>  :wincmd h<CR>
    nnoremap <silent> <Right> :wincmd l<CR>
    nnoremap <silent> <Up>    :wincmd k<CR>
    nnoremap <silent> <Down>  :wincmd j<CR>
endif

if g:change_winsize_with_Shift_allow
    " > increase height
    " ^ increase width
    " < decrease height
    " V decrease width
    nnoremap <silent> <S-Left>  :10wincmd -<CR>
    nnoremap <silent> <S-Right> :10wincmd +<CR>
    nnoremap <silent> <S-Up>    :10wincmd ><CR>
    nnoremap <silent> <S-Down>  :10wincmd <<CR>
endif

if g:move_selection_with_Control_hjkl
    vmap <C-j> <Plug>(TextManup.move_selection_down)
    vmap <C-k> <Plug>(TextManup.move_selection_up)
    vmap <C-h> <Plug>(TextManup.move_selection_left)
    vmap <C-l> <Plug>(TextManup.move_selection_right)
endif

if g:swap_colon_and_semicolon
    noremap ;     :
    noremap :     ;
endif

" if g:Is_mac
    " nnoremap <space>d  :DictionaryApp <C-r><C-w><CR>
    " vnoremap <space>d  y:DictionaryApp <C-r>"<CR>
" endif

nnoremap gc `[V`]
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>
" nnoremap gC `[V`]
" vnoremap gC :<C-u>normal gC<CR>
" onoremap gC :<C-u>normal gC<CR>

nnoremap <silent> <F2> :NERDTreeToggle<CR>
nmap     <silent> <F3>  <plug>NERDCommenterToggle
vmap     <silent> <F3>  <plug>NERDCommenterToggle

" QuickRun
nnoremap <silent> <F5> :<C-u>QuickRun<CR>
inoremap <silent> <F5> <C-o>:<C-u>QuickRun<CR>
vnoremap <silent> <F5> :QuickRun<CR>
nnoremap <silent> <Space>rr :<C-u>QuickRun<CR>
vnoremap <silent> <Space>rr :QuickRun<CR>

nnoremap <Space>h :<C-u>help<Space><C-r><C-W><CR>   
nnoremap <Space>.  :<C-u>edit   $MYVIMRC<CR>
nnoremap <Space>e  :<C-u>edit   $HOME/.vimperatorrc<CR>
nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>:echo ".vimrc sourced!"<CR>

nnoremap <Space>f :CommandT %:p:h<CR>
nnoremap <Space>F :CommandT<CR>

" snipmate helper
nnoremap <silent> <Space>se  :<C-u>SnippetsEdit<CR>
nnoremap <silent> <Space>sE  :<C-u>SnippetsEdit 
nnoremap <silent> <Space>sr  :<C-u>SnippetsReload<CR>

" close window easily
nnoremap <silent> <Space>q :wincmd q<CR>
nnoremap <silent>  cc      :wincmd q<CR>
nnoremap <silent> <Space>c :wincmd q<CR>
nnoremap <silent> <Space>2 :wincmd s<CR>
nnoremap <silent> <Space>3 :wincmd v<CR>

" ResizeWin plugin
" Resize window easily
vmap _     <Plug>(ResizeWinMaxH)
vmap <bar> <Plug>(ResizeWinMaxV)
vmap F     <Plug>(ResizeWinMaxHV)
nmap _     <Plug>(ResizeWinMaxH)
nmap <bar> <Plug>(ResizeWinMaxV)
nmap F     <Plug>(ResizeWinMaxHV)
nmap     <M-f>     <Plug>(ResizeWinMaxHV)
nmap     <M-F>     <Plug>(ResizeWinMinV)
" nmap     <M-\|>     <Plug>(ResizeWinMinV)
" nmap     <M-_>     <Plug>(ResizeWinMinV)

" I'm not use HML moving  so I prefe use this key for another purpose.
nnoremap <silent> H :NERDTreeFind<CR>
" nnoremap <silent> M
" use L as linewise-visual
nnoremap <silent> L V
vnoremap <silent> L ip
vnoremap <silent> V ip
vnoremap <silent> <CR> <Esc>

nnoremap <silent> <Space>; :call NERDComment(0, "toggle")<CR>
vnoremap <silent> <Space>; :call NERDComment(0, "toggle")<CR>

" nnoremap <Space>j :python anything(src=ac_src_cmd, ac_src_dict=ac_src_dict, mode='n')<CR>
" vnoremap <Space>j :python anything(src=ac_src_cmd, ac_src_dict=ac_src_dict, mode='v')<CR>

inoremap <C-l>  <C-r>=ShowAvailableSnips()<CR>

nmap <silent> zl <Plug>(FoldcolumnIncrease)
nmap <silent> zh <Plug>(FoldcolumnDecrease)

" scroll a bit faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
set scrolloff=3
set nowrap
"}}}

  " Function and Command {{{
function! SetTransparency(ope) "{{{
  if !exists('&transparency')
    return
  endif
  execute "let newval = &transparency " . a:ope . " " . 3
  let newval = (newval <   0) ? 0   : newval
  let newval = (newval > 100) ? 100 : newval
  let &transparency = newval
endfunction "}}}

function! ToggleOption(optname,...) "{{{
    let optvar = '&'.a:optname
    let cmd_toggle = 'let '.optvar.' = !'.optvar
    exe cmd_toggle

    let cmd_status = 'let status = '.optvar.' ? "ON" : "OFF"'
    exe cmd_status

    echohl Function
    let msg = a:0 > 0 ? a:1 : optvar.": "
    echo msg.status
    echohl Normal
endfunction "}}}
command! PasteToggle :call ToggleOption('paste', "Paste Mode: ")
command! WrapToggle  :call ToggleOption('wrap')
command! -nargs=* -complete=mapping AllMaps map <args> | map! <args> | lmap <args>
command! NumberToggle  :call ToggleOption('number')

command! Cp932     edit ++enc=cp932
command! Eucjp     edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! UTF8      edit ++enc=utf-8
command! Jis  Iso2022jp
command! SJis Cp932
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis

command! SudoWrite write !sudo tee %
command! HelptagUpdate call pathogen#helptags()
command! DisableEndwizeCR inoremap <buffer> <silent> <CR> <CR>
command! EnableEndwizeCR iunmap <buffer> <CR>

" vimcasts {{{
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
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
endfunction
"}}}
"}}}

" Auto Command {{{
"-----------------------------------------------------------------
augroup InsModeAu
    autocmd!
    autocmd! InsertEnter * set noimdisable
    autocmd! InsertLeave * set imdisable
augroup END

" augroup MiniBuffExproler
    " autocmd!
" augroup END

augroup my_config
    autocmd!

    autocmd FileType * call SetupSurroundMapping('b')
    au BufNewFile,BufReadPost *.node.js let b:quickrun_config = {}  | let b:quickrun_config = { 'command': 'node' }
    " 次に開いたときに同じ場所を開く。
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif

    au BufNewFile,BufReadPost .vimrc nnoremap <buffer> <M-r> :so %<CR>
    au BufNewFile,BufReadPost about_*.py nnoremap <buffer> <M-r> :python anything.run(py_koan)<CR>
    au BufNewFile,BufReadPost vim_util.rb nnoremap <buffer> <M-r> :rubyfile %<CR>
    au BufNewFile,BufReadPost ac_source_cmd.py nnoremap <buffer> <M-r> :pyfile %<CR>
    au BufNewFile,BufReadPost ac_source_buffer.py nnoremap <buffer> <M-r> :pyfile %<CR>
    au BufNewFile,BufReadPost anything.py nnoremap <buffer> <M-r> :pyfile %<CR>
    au BufNewFile,BufReadPost py-anything.vim nnoremap <buffer> <M-r> :so %<CR>
    au BufNewFile,BufRead *.json set filetype=json
    au BufNewFile,BufRead *vimperator-*.tmp set filetype=textile
    au BufNewFile,BufRead /tmp/*.eml set filetype=markdown | nnoremap <buffer> <silent> <M-w> :bd!<CR>| DisableEndwizeCR
    au BufNewFile,BufRead */phrase/*/phrase.* setlocal noswapfile

    autocmd FileType text setlocal textwidth=78
    autocmd FileType sh vnoremap <buffer> <silent> <F5> :<C-u>QuickRunWrapper "v"<CR>
    autocmd FileType sh nnoremap <buffer> <silent> <F5> :<C-u>QuickRunWrapper "n"<CR>

    autocmd FileType haskell vnoremap <buffer> <M-r> :<C-U>call conque_term#send_selected(visualmode())<CR>

    " help mode
    autocmd FileType help nnoremap <buffer> <Return> <C-]>
    autocmd FileType help nnoremap <buffer> <BS>     <C-t>
    autocmd FileType help nnoremap <buffer> .j  /\|[^ \|]\+\|<CR>
    autocmd FileType help vnoremap <buffer> <silent> <F5> :QuickRun vim<CR>

    autocmd FileType c set ts=4 sw=4

    autocmd FileType ruby        setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html        setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType haml        setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType sass        setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css         setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType coffee      setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType coffee nnoremap <buffer> <silent> <S-F5> :QuickRun 'coffee -cp --no-wrap'<CR>
    autocmd FileType coffee inoremap <buffer> <silent> <S-F5> <C-o>:QuickRun 'coffee -cp --no-wrap'<CR>
    autocmd FileType coffee vnoremap <buffer> <silent> <S-F5> :QuickRun 'coffee -cp --no-wrap'<CR>

    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

    autocmd FileType ruby :compiler ruby
    autocmd BufReadPost *_spec.rb :compiler rspec
    autocmd FileType ruby noremap  <buffer> <silent> <F5> moHmt:%call Xmpfilter()<CR>'tzt`o
    autocmd FileType ruby inoremap <buffer> <silent> <F5> <Esc>moHmt:%call Xmpfilter()<CR>'tzt`oa
    autocmd FileType ruby noremap  <buffer> <silent> <F4> :call XmpCommentToggle()<CR>
    autocmd FileType ruby inoremap <buffer> <silent> <F4> <C-o>:call XmpCommentToggle()<CR>
    autocmd FileType ruby setlocal complete-=i

    autocmd FileType ruby setlocal path+=**/lib

    " fix default gf and C-wf behavior
    autocmd FileType ruby :call OverwiteRubyFindFileMapping()

    autocmd FileType markdown inoremap <buffer> <silent> <F5> :MarkDown2HTML<CR>
    autocmd FileType markdown nnoremap <buffer> <silent> <F5> :MarkDown2HTML<CR>
    autocmd FileType markdown DisableEndwizeCR

    autocmd FileType vim noremap  <buffer> <silent> <F5> :<C-u>QuickRun<CR>
    autocmd FileType vim inoremap <buffer> <silent> <F5> <C-o>:<C-u>QuickRun<CR>
    " autocmd FileType vim noremap  <buffer> <silent> <S-F5> :so %<CR>
    autocmd FileType vim noremap  <buffer> <silent> <Space>so :so %<CR>
    " autocmd FileType vim inoremap <buffer> <silent> <S-F5> :so %<CR>
    autocmd FileType vim noremap  <buffer> <silent> <M-m> A\|" => 
    autocmd FileType vim inoremap  <buffer> <silent> <M-m> <Esc>A\|" => 
    autocmd FileType vim setlocal path=.,$VIMRUNTIME,,
    autocmd FileType vim setlocal iskeyword+=#
    " autocmd FileType vim nnoremap <buffer> <M-x>r      :<C-u>call U_InsertRunResult()<CR>
    " autocmd FileType vim inoremap <buffer> <M-x>r      :<C-o>call U_InsertRunResult()<CR>

    autocmd FileType nerdtree nnoremap <buffer> <silent> q <Nop>

    " autocmd FileType mysql nnoremap <buffer> <silent> <F5> :MySQLSend<CR><Esc>
    " autocmd FileType mysql vnoremap <buffer> <silent> <F5> :MySQLSend<CR><Esc>
    " autocmd FileType mysql inoremap <buffer> <silent> <F5> <C-o>:MySQLSend<CR>

    " autocmd FileType vimwiki nnoremap <buffer> <silent> <F5> :call UVimwiki2HTML()<CR>
    " autocmd FileType vimwiki nnoremap <buffer> <silent> <S-F5> :call UVimwiki2ALLHTML()<CR>

    autocmd WinEnter,BufWinEnter * call HighlightCursor("")
    autocmd WinLeave             * call HighlightCursor("no")

    " GUI Specific {{{
    "-----------------------------------------------------------------
    " CoffeeScript Like {{{
    autocmd FileType coffee nnoremap  <buffer> <silent> <M-R> :QuickRun<CR>
    autocmd FileType coffee inoremap  <buffer> <silent> <M-R> <C-o>:QuickRun<CR>
    autocmd FileType coffee vnoremap  <buffer> <silent> <M-R> :QuickRun<CR>
    autocmd FileType coffee nnoremap  <buffer> <silent> <M-r> :QuickRun 'coffee -cp --no-wrap'<CR>
    autocmd FileType coffee inoremap  <buffer> <silent> <M-r> <C-o>:QuickRun 'coffee -cp --no-wrap'<CR>
    autocmd FileType coffee vnoremap  <buffer> <silent> <M-r> :QuickRun 'coffee -cp --no-wrap'<CR>
    "}}}

    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    " autocmd FileType python inoremap <buffer> <silent> <C-Space> <C-x><C-o>

    " autocmd BufWritePost *.rb silent make -c %
    autocmd FileType ruby noremap  <buffer> <silent> <M-r> moHmt:%call Xmpfilter()<CR>'tzt`o
    autocmd FileType ruby inoremap <buffer> <silent> <M-r> <Esc>moHmt:%call Xmpfilter()<CR>'tzt`oa
    autocmd FileType ruby vnoremap <buffer> <silent> <M-r> :call Xmpfilter()<CR>
    autocmd FileType ruby noremap  <buffer> <silent> <M-m> :call XmpCommentToggle()<CR>
    autocmd FileType ruby inoremap <buffer> <silent> <M-m> <C-o>:call XmpCommentToggle()<CR>
    "}}}

    fun! HighlightCursor(flag)
        if (&filetype == 'nerdtree')
            return
        endif
        execute "setlocal " . a:flag ."cursorline"
    endfun
augroup END
"}}}

" Plugin Configuration  {{{
"=================================================
" Align {{{
vmap   <M-a>=           <Plug>AM_t=
vmap   <M-a><           <Plug>AM_t<
vmap   <M-a>;           <Plug>AM_t;
vmap   <M-a>:           <Plug>AM_t:
vmap   <M-a>,           <Plug>AM_t,
vmap   <M-a>#           <Plug>AM_t#
vmap   <M-a>\|           <Plug>AM_t\|
vnoremap   <M-a>t           :Align "\|"<CR>
vnoremap   <M-a>h           :Align "=>"<CR>
vmap   <M-a>sp           <Plug>AM_tsp
vmap   <M-a>sq           <Plug>AM_tsq
vmap   <M-A>=           <Plug>AM_T=
vmap   <M-A><           <Plug>AM_T<
vmap   <M-A>;           <Plug>AM_T;
vmap   <M-A>:           <Plug>AM_T:
vmap   <M-A>,           <Plug>AM_T,
vmap   <M-A>#           <Plug>AM_T#
vmap   <M-A>\|           <Plug>AM_T\|
vmap   <M-A>t           <Plug>AM_T\|
"}}}

let NERDTreeWinSize=30

" NERDCommenter
let NERDSpaceDelims=1
let NERDCreateDefaultMappings = 0

" Unite.vim {{{
let g:unite_enable_start_insert = 1

nnoremap [unite] <Nop>
nmap     <M-u>   [unite]
nmap     <Space>u   [unite]

nnoremap [unite]u           :<C-u>Unite<Space>
nnoremap [unite]<M-u>       :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]f  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]d  :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]m  :<C-u>Unite file_mru<CR>
" nnoremap <silent> [unite]b  :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]b  :<C-u>Unite -auto-preview buffer<CR>
nnoremap <silent> <Space>m  :<C-u>Unite file_mru<CR>
nnoremap <silent> <Space>b  :<C-u>Unite buffer<CR>
" nnoremap <silent> <Space><Space>  :<C-u>Unite buffer<CR>
nnoremap <silent> <C-n> :<C-u>Unite buffer<CR>
" nnoremap <silent> <C-n>      :<C-u>Unite buffer<CR>
" nnoremap <silent> [unite]g  : <C-u>Unite -input=.rvm/gems/ruby-1.8.7-p302/gems/ file<CR>
nnoremap <silent> [unite]g  : <C-u>Unite -input=.rvm/gems/ruby-1.8.7-p302/gems/ -buffer-name=files file<CR>

autocmd FileType unite call s:unite_my_settings()

function! s:unite_my_settings()"{{{
    " Overwrite settings.

    imap <buffer> jj      <Plug>(unite_insert_leave)
    nnoremap <silent><buffer> <C-k> :<C-u>call unite#mappings#do_action('preview')<CR>
    nmap <silent><buffer> m <Plug>(unite_toggle_mark_current_candidate)
    vmap <silent><buffer> m <Plug>(unite_toggle_mark_selected_candidates)|

    imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

    " Start insert.
    let g:unite_enable_start_insert = 1
endfunction"}}}

let g:unite_source_file_mru_limit = 200
"}}}

" Surround.vim {{{
nmap  s        ysiw
nmap  S        ysiW
nmap  ss       yss
nmap  <M-s>    ysiw
nmap  <M-S>    ysiW
vmap  <M-s>    <Plug>VSurround
vmap  s    <Plug>VSurround

" surround helper
function! SetupSurroundMapping(scope)
    if (a:scope != 'g') && empty(&ft)
        return
    endif
    let map_dict =  a:scope == 'g' ? 'global' : &ft

    if !has_key(g:surround_mapping, map_dict)
        return
    end
    for [key, action] in items(g:surround_mapping[map_dict])
        let command = "let ".a:scope.":surround_".char2nr(key)." = ".string(action)
        execute command
    endfor
endfunction

" mapping definition
let g:surround_mapping = {}
let g:surround_mapping.global = {
            \ 'p':  "<pre> \r </pre>",
            \ 'w':  "%w(\r)",
            \ }
let g:surround_mapping.ruby = {
            \ '-':  "<% \r %>",
            \ '=':  "<%= \r %>",
            \ '5':  "%(\r)",
            \ '%':  "%(\r)",
            \ 'w':  "%w(\r)",
            \ '#':  "#{\r}",
            \ '3':  "#{\r}",
            \ 'e':  "begin \r end",
            \ 'E':  "<<EOS \r EOS",
            \ 'i':  "if \1if\1 \r end",
            \ 'u':  "unless \1unless\1 \r end",
            \ 'c':  "class \1class\1 \r end",
            \ 'm':  "module \1module\1 \r end",
            \ 'd':  "def \1def\1\2args\r..*\r(&)\2 \r end",
            \ 'p':  "\1method\1 do \2args\r..*\r|&| \2\r end",
            \ 'P':  "\1method\1 {\2args\r..*\r|&|\2 \r }",
            \ }
let g:surround_mapping.javascript = {
            \ 'f':  "function(){ \r }"
            \ }
let g:surround_mapping.python = {
            \ 'p':  "print \r",
            \ '[':  "[\r]",
            \ }
let g:surround_mapping.vim= {
            \'f':  "function! \r endfunction"
            \ }

call SetupSurroundMapping('g')
"}}}

" Phrase.vim
let g:phrase_dir = "$HOME/.vim/phrase/t9md"
let g:phrase_comment = {}
let g:phrase_comment.vim = '"'
let g:phrase_comment.lua = '--'
let g:phrase_ft2ext = {}
let g:phrase_ft2ext.perl = "pl"

" TryIt
let g:tryit_dir = "$HOME/.vim/tryit"
nnoremap <silent> T  :TryIt<CR>
vnoremap <silent> T  :TryItSelection<CR>
nnoremap <silent> <Space>t  :TryItInteractive<CR>

" CommandT
let g:CommandTMaxHeight = 30

" Foldtext
let g:Foldtext_enable      = 1
let g:Foldtext_perl_enable = 1
let g:Foldtext_tex_enable  = 1
let g:Foldtext_cpp_enable  = 1

" Ref
command! -nargs=? Refe    :call ref#ref("refe " . <q-args>)
command! -nargs=? Eijiro  :call ref#ref("alc " . <q-args>)
command! -nargs=? Pydoc   :call ref#ref("pydoc " . <q-args>)
command! -nargs=? Perldoc :call ref#ref("perldoc " . <q-args>)
command! -nargs=? Erlang  :call ref#ref("erlang " . <q-args>)
command! -nargs=? Man     :call ref#ref("man " . <q-args>)


" nnoremap <Space>b :call BuffListWindow()<CR>
nnoremap <silent> <Space><Space> :call BuffListWindow()<CR>

" macvim-kaoriya workaround {{{
if g:Is_mac
    let plugin_dicwin_disable = 1
endif
"}}}
"}}}

" Vim Bundle {{{
" Generally Useful:
" Bundle: git://github.com/scrooloose/nerdtree.git
" # Bundle: git://github.com/vim-scripts/bufexplorer.zip.git
" Bundle: git://github.com/bronson/vim-closebuffer.git
" Bundle: git://github.com/vim-scripts/IndexedSearch.git
" Bundle: git://github.com/bronson/vim-trailing-whitespace.git
" # Bundle: git://github.com/Raimondi/YAIFA.git
" Bundle: git://github.com/tpope/vim-vividchalk.git
"
" BUNDLE: git://git.wincent.com/command-t.git
" #   If rvm is installed, make sure we compile command-t with the system ruby
" # BUNDLE-COMMAND: if which rvm >/dev/null 2>&1; then rvm system exec rake make; else rake make; fi

" Programming:
" Bundle: git://github.com/scrooloose/nerdcommenter.git
" Bundle: git://github.com/tpope/vim-surround.git

" #Bundle: git://github.com/vim-scripts/taglist.vim
" #Bundle: git://github.com/msanders/snipmate.vim.git
"
" Bundle: git://github.com/vim-scripts/tlib.git
" BUNDLE: git://github.com/MarcWeber/snipmate.vim.git
" BUNDLE: git://github.com/MarcWeber/vim-addon-mw-utils.git

" # Bundle: git://github.com/scrooloose/snipmate-snippets.git
" Bundle: git://github.com/vim-scripts/Align.git
" Bundle: git://github.com/tpope/vim-endwise.git
" Bundle: git://github.com/tpope/vim-repeat.git
" Bundle: git://github.com/tpope/vim-fugitive.git
" # Bundle: git://github.com/ervandew/supertab.git
" # Bundle: git://github.com/vim-scripts/jQuery.git
" # Bundle: git://github.com/tpope/vim-git.git
" Bundle: git://github.com/tpope/vim-markdown.git
" Bundle: git://github.com/timcharper/textile.vim.git
" Bundle: git://github.com/kchmck/vim-coffee-script.git

" Ruby/Rails Programming:
" Bundle: git://github.com/vim-ruby/vim-ruby.git
" # Bundle: git://github.com/tpope/vim-rails.git
" # Bundle: git://github.com/tpope/vim-rake.git
" # Bundle: git://github.com/janx/vim-rubytest.git
" # Bundle: git://github.com/tsaleh/vim-shoulda.git
" # Bundle: git://github.com/tpope/vim-cucumber.git
" # Bundle: git://github.com/tpope/vim-haml.git
" # Bundle: git://github.com/astashov/vim-ruby-debugger.git

" Other compilation by t9md
" # BUNDLE: git://github.com/Raimondi/delimitMate.git
" # BUNDLE: git://github.com/Townk/vim-autoclose
" BUNDLE: git://github.com/fholgado/minibufexpl.vim.git
" BUNDLE: git@github.com:t9md/vim-text-manup.git
" BUNDLE: git@github.com:t9md/vim-foldtext.git
" BUNDLE: git@github.com:t9md/vim-phrase.git
" BUNDLE: git@github.com:t9md/vim-tryit.git
" BUNDLE: git@github.com:t9md/vim-resizewin.git
" BUNDLE: git://github.com/vim-scripts/Color-Sampler-Pack.git
" BUNDLE: git://github.com/vim-scripts/Super-Shell-Indent.git
" BUNDLE: git://github.com/Shougo/unite.vim.git
" BUNDLE: git://github.com/vim-scripts/ManPageView.git
" BUNDLE: git://github.com/thinca/vim-quickrun.git
" BUNDLE: git://github.com/thinca/vim-ref.git
" BUNDLE: git://github.com/thinca/vim-openbuf.git
"
" textobj extention
" BUNDLE: git://github.com/vim-scripts/textobj-user.git
" BUNDLE: git://github.com/vim-scripts/textobj-indent.git
" BUNDLE: git://github.com/vim-scripts/textobj-syntax.git
" BUNDLE: git://github.com/vim-scripts/textobj-user.git
" BUNDLE: git://github.com/vim-scripts/textobj-function.git
" BUNDLE: git://github.com/thinca/vim-textobj-function-javascript.git
" BUNDLE: git://github.com/thinca/vim-textobj-function-perl.git
" BUNDLE: git://github.com/thinca/vim-textobj-between.git
" BUNDLE: git://github.com/thinca/vim-textobj-comment.git
" BUNDLE: git@github.com:t9md/vim-textobj-function-ruby.git
"}}}
