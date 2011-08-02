Setup
====================
### backup your current vim config

    $ cd ~/
    $ mkdir vim_backup
    $ mv .vimrc .gvimrc .vim vim_backup

### create new vim config dir

    $ git clone git://github.com/t9md/my-vim-config.git 
    $ cd my-vim-config


### install

    $ rake install os=linux
  or
    $ rake install os=mac

### install bundles(vim-plugin)

    $ gem install vim-update-bundles
    $ vim-update-bundles

Setting( following docment is old)
====================

change following setting in .vimrc

    let g:phrase_author = "YOURNAME"

set g:swap_colon_and_semicolon to '0' if you use Japanese keyboard

    let g:swap_colon_and_semicolon           = 0

Keybind
====================
Mac　環境では `M-` は `D-`　になる。
`M-`はAltキー
`D-`はCommandキー

Full screen(MacVim only)
----------------------------------
MacVim の場合 `F11` でフルスクリーンに出来る。

    nnoremap <F11> :emenu Window.Toggle\ Full\ Screen\ Mode<CR>

Tab移動
----------------------------------
### key
    `M-[` 左のタブ
    `M-]` 右のタブ

### setting
    nnoremap <M-]> gt
    nnoremap <M-[> gT

Window の移動を簡単に
----------------------------------
分割したWindow間を Control キーを押しながら`hlkj`で移動出来る。

    nnoremap <silent> <C-h> :wincmd h<CR>
    nnoremap <silent> <C-l> :wincmd l<CR>
    nnoremap <silent> <C-k> :wincmd k<CR>
    nnoremap <silent> <C-j> :wincmd j<CR>

矢印キーだけでも Window を移動できる。

    nnoremap <silent> <Left>  :wincmd h<CR>
    nnoremap <silent> <Right> :wincmd l<CR>
    nnoremap <silent> <Up>    :wincmd k<CR>
    nnoremap <silent> <Down>  :wincmd j<CR>

範囲選択した text を hlkj で移動
--------------------------------------------------------------------
Visual モードで選択したテキストを Control　を押しながら `hlkj`で移動出来る。

### key
    C-h  右
    C-l　左
    C-k　上
    C-j　下

### setting
    vmap <C-j> <Plug>(TextManup.move_selection_down)
    vmap <C-k> <Plug>(TextManup.move_selection_up)
    vmap <C-h> <Plug>(TextManup.move_selection_left)
    vmap <C-l> <Plug>(TextManup.move_selection_right)

範囲選択した text を 下方向に複製
--------------------------------------------------------------------
範囲選択した text を 下方向に複製(Duplicate)
Normal モードではカレント行が下方向に複製される。

### key
    M-d
    <Space>d
    D

### setting

    vmap <M-d>    <Plug>(TextManup.duplicate_selection_v)
    nmap <M-d>    <Plug>(TextManup.duplicate_selection_n)
    vmap <Space>d <Plug>(TextManup.duplicate_selection_v)
    nmap <Space>d <Plug>(TextManup.duplicate_selection_n)
    vmap D        <Plug>(TextManup.duplicate_selection_v)

NERDCommenter
----------------------------------
NERDCommenter

### key
    F3  (Normal)現在行のコメントをトグル
    M-; (Normal)現在行のコメントをトグル
    F3  (Visual)選択範囲のコメントをトグル
    M-; (Visual)選択範囲のコメントをトグル
    <Space>;　(Normal)同じ
    <Space>;  (Visual)同じ

### setting
    nmap     <silent> <F3>  <plug>NERDCommenterToggle
    vmap     <silent> <F3>  <plug>NERDCommenterToggle

    nnoremap <silent> <Space>; :call NERDComment(0, "toggle")<CR>
    vnoremap <silent> <Space>; :call NERDComment(0, "toggle")<CR>
    nnoremap <silent> <M-;>      :call NERDComment(0, "toggle")<CR>
    vnoremap <silent> <M-;>      :call NERDComment(0, "toggle")<CR>
    inoremap <silent> <M-;> <C-o>:call NERDComment(0, "toggle")<CR>

NERDTree
----------------------------------
今開いているファイルを NERDTree 上に表示する。

### key
    <M-R>
    <M-n>
    <Space>n
    H

### setting
    nnoremap <silent> <M-R> :NERDTreeFind<CR>
    nnoremap <silent> <M-n> :NERDTreeFind<CR>
    nnoremap <silent> <Space>n :NERDTreeFind<CR>

Font resize
----------------------------------
フォントサイズの変更

### key
    <M-->   フォントを大きく
    <M-=>   フォントを小さく

### setting
    nnoremap <silent> <M--> :<C-u>call SetGUIFont('-')<CR>
    nnoremap <silent> <M-=> :<C-u>call SetGUIFont('+')<CR>

Window レイアウトの変更
----------------------------------
`M-H(M-Shift-h)` 等で、Windowを`hlkj`それぞれの方向に最大化して寄せる。

    nnoremap <silent> <M-H> :wincmd H<CR>
    nnoremap <silent> <M-L> :wincmd L<CR>
    nnoremap <silent> <M-K> :wincmd K<CR>
    nnoremap <silent> <M-J> :wincmd J<CR>

Window の分割
----------------------------------
### key
    <M-2> 横分割(split)
    <M-3> 縦分割(vsplit)

### setting
    nnoremap <silent> <M-2> :split<CR>
    nnoremap <silent> <M-3> :vsplit<CR>

縦、横、縦横にWindowサイズを最大化
----------------------------------------------------
見える範囲を一時的に広くするために、選択したWindowの サイズを一時的に変更する。

### key
    _    縦に最大化
    |    横に最大化
    F    縦横に最大化

### setting
    vmap _     <Plug>(ResizeWinH)
    vmap <bar> <Plug>(ResizeWinV)
    vmap F     <Plug>(ResizeWinHV)
    nmap _     <Plug>(ResizeWinH)
    nmap <bar> <Plug>(ResizeWinV)
    nmap F     <Plug>(ResizeWinHV)

Align
----------------------------------
`M-a` に続くキーで選択範囲を整列

### key
    <M-a>文字  (Visual) '文字'で選択範囲を整列

### setting

    vmap   <M-a>=           <Plug>AM_t=
    vmap   <M-a><           <Plug>AM_t<
    vmap   <M-a>;           <Plug>AM_t;
    vmap   <M-a>:           <Plug>AM_t:
    vmap   <M-a>,           <Plug>AM_t,
    vmap   <M-a>#           <Plug>AM_t#
    vmap   <M-a>\|          <Plug>AM_t\|
    vmap   <M-a>sp          <Plug>AM_tsp
    vmap   <M-a>sq          <Plug>AM_tsq
    vmap   <M-A>=           <Plug>AM_T=
    vmap   <M-A><           <Plug>AM_T<
    vmap   <M-A>;           <Plug>AM_T;
    vmap   <M-A>:           <Plug>AM_T:
    vmap   <M-A>,           <Plug>AM_T,
    vmap   <M-A>#           <Plug>AM_T#
    vmap   <M-A>\|           <Plug>AM_T\|
    vmap   <M-A>t           <Plug>AM_T\|
    vnoremap   <M-a>t           :Align "\|"<CR>
    vnoremap   <M-a>h           :Align "=>"<CR>

TryIt
----------------------------------
`T`で tryit ファイルを開く。
Visual　モードで `T` を押すと、選択範囲を tryit ファイルに paste　して開く。

### key
    T  (Normal) Tryit ファイルを開く
    T  (Visual) 選択範囲を Tryit ファイルに張り付けて開く

### setting
    let g:tryit_dir = "$HOME/.vim/tryit"
    nnoremap <silent> T  :TryIt<CR>
    vnoremap <silent> T  :TryItSelection<CR>
    nnoremap <silent> <Space>t  :TryItInteractive<CR>


Phrase.vim
----------------------------------
(よくつかう) Phrase の管理。
`<Space>pl`　で PhraseList を開く。
`M` で PhraseFile を開く。
`Visual-M` で 選択範囲を新しくPhraseFileに登録する。

### key
    <Space>p   Unite phrase
    M          (Normal)Phraseファイルを開く
    M          (Visual)選択範囲からPhraseを作成

### setting
    nnoremap <silent> <Space>p  :<C-u>Unite phrase -start-insert<CR>
    nnoremap <silent> M  :PhraseEdit<CR>
    vnoremap <silent> M  :PhraseCreate<CR>

Ref
----------------------------------
    command! -nargs=? Refe    :call ref#ref("refe " . <q-args>)
    command! -nargs=? Eijiro  :call ref#ref("alc " . <q-args>)
    command! -nargs=? Pydoc   :call ref#ref("pydoc " . <q-args>)
    command! -nargs=? Perldoc :call ref#ref("perldoc " . <q-args>)
    command! -nargs=? Erlang  :call ref#ref("erlang " . <q-args>)

Unite
----------------------------------
### key
    C-p             file mru
    <Space><Space>  buffer
    <Space>o        outline
    <Space>ul       line
    <Space>p        phrase
    <Space>urm      ref/man
    <Space>urr      ref/refe
    <Space>urp      ref/pydoc

### setting

    let g:unite_enable_start_insert = 1
    let g:unite_split_rule="botright"
    let g:unite_enable_split_vertically = 0
    nnoremap [unite] <Nop>
    nmap     <M-u>   [unite]
    nmap     U       [unite]
    nmap     <Space>u   [unite]

    nnoremap [unite]u           :<C-u>Unite<Space>
    nnoremap [unite]<M-u>       :<C-u>Unite file_mru<CR>
    " nnoremap <silent> [unite]f  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
    nnoremap <silent> [unite]f  :<C-u>UniteWithCurrentDir file_rec -buffer-name=files<CR>
    nnoremap <silent> [unite]d  :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
    nnoremap <silent> [unite]m  :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]l  :<C-u>Unite lines<CR>
    nnoremap <silent> [unite]t  :<C-u>UniteWithCursorWord tag -vertical<CR>
    nnoremap <silent> <Space>g  :<C-u>UniteWithCursorWord tag -vertical<CR>

    nnoremap <silent> [unite]b  :<C-u>Unite bookmark<CR>
    nnoremap <silent> [unite]rm  :<C-u>UniteWithCursorWord -start-insert ref/man<CR>
    nnoremap <silent> [unite]rr  :<C-u>UniteWithCursorWord -start-insert ref/refe<CR>
    nnoremap <silent> [unite]rp  :<C-u>UniteWithCursorWord -start-insert ref/pydoc<CR>

    nnoremap <silent> [unite]p  :<C-u>Unite phrase -start-insert<CR>
    nnoremap <silent> [unite]o  :<C-u>Unite outline -start-insert<CR>

    nnoremap <silent> <Space>p  :<C-u>Unite phrase -start-insert<CR>
    nnoremap <silent> <Space>o  :<C-u>Unite outline -start-insert<CR>
    nnoremap <silent> <Space>b  :<C-u>Unite bookmark<CR>
    nnoremap <silent> <Space><Space> :<C-u>Unite -start-insert buffer<CR>
    nnoremap <silent> <C-p> :<C-u>Unite file_mru -buffer-name=files<CR>

CommandT
----------------------------------
* install
    if which rvm >/dev/null 2>&1; then rvm system exec rake make; else rake make; fi

### key
    <Space>f   現在のディレクトリから
    <Space>F   バッファのディレクトリから

### setting
    nnoremap <Space>f :CommandT<CR>
    nnoremap <Space>F :CommandT %:p:h<CR>
