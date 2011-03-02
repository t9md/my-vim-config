" Trailing Wite Space: {{{
"============================================================
let s:highlight_trailing_witespace = 0
function! s:HighlightTrailingWhiteSpace()
    let s:highlight_trailing_witespace = !s:highlight_trailing_witespace
    if ! s:highlight_trailing_witespace
        highlight clear ExtraWhitespace
        return
    endif
    " highlight ExtraWhitespace ctermbg=darkred guibg=#382424
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    match ExtraWhitespace /\s\+$/
    match ExtraWhitespace /\s\+\%#\@<!$/
endfunction

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space.
command! HighlightTrailingWhiteSpace call <SID>HighlightTrailingWhiteSpace()
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)
"}}}

" BuffSelecter: {{{
"============================================================
" EXAMPLE:
" nnoremap <silent> <Space><Space> :call BuffListWindow()<CR>
function! s:bufflist()
  return map(
        \ filter(range(1,bufnr('$')), "buflisted(v:val)"),
        \ "printf('%2d: %s', v:val, bufname(v:val))")
endfunction

let s:bufflist_bufname = "*bufflist*"
function! BuffListWindow()
  if bufname('%') == s:bufflist_bufname| return| endif
  let lis = s:bufflist()
  let s:bufforg = bufnr("%")
  let s:restore_cmd = winrestcmd()
  silent execute "topleft " . len(lis) . "split " . s:bufflist_bufname
  silent normal! gg"_dG
  call setline(1,lis)
  normal! gg
  call search(s:bufforg)
  setlocal  bufhidden=delete  buftype=nofile noswapfile nobuflisted nomodifiable
  " setlocal  bufhidden=delete  buftype=nofile noswapfile  nomodifiable
  autocmd  CursorMoved <buffer>  call s:bufflist_showbuffer()
  nnoremap <buffer> <silent> <CR> :call <SID>bufflist_close()<CR>
  nnoremap <buffer> <silent> q    :call <SID>bufflist_cancel()<CR>
endfunction

function! s:bufflist_close()
    let thisbuff = bufnr('%')
    silent wincmd p
    silent exe "bdelete" . thisbuff
    exe s:restore_cmd
endfunction

function! s:bufflist_cancel()
  call s:bufflist_close()
  exec "buffer " . s:bufforg
endfunction

function! s:bufflist_showbuffer()
  let num = split(getline('.'), ':')[0]
  silent wincmd p
  silent execute "buffer ".num
  silent wincmd p
endfunction

" }}}

" Util_capitalize: {{{
"============================================================
function! Util_capitalize(string)
    return substitute(a:string,'^\(.\)','\u\1',"")
endfunction
" }}}

" NeoComplCache: {{{
"============================================================
command! -nargs=1 NeoComplCacheSwitch :call <SID>NeoComplCacheSwitch(<q-args>)
function! s:NeoComplCacheSwitch(switch)
    let msg = a:switch
    if a:switch == 'on'
        let command = "NeoComplCacheEnable"
    elseif a:switch == 'off'
        let command = "NeoComplCacheDisable"
    end

    try
        execute command
    catch /E492/
        let msg = "already off"
    endtry

    echohl function
    echo "NeoComplCache " . msg
    echohl normal
endfunction
" }}}

" StringInterporation: {{{
"============================================================
command! -nargs=0 StrinInterporate :call <SID>StringInterporate()
function! s:StringInterporate()
    let old_str = getline(".")
    let new_str = substitute(old_str, '\(#{\(.\{-1,}\)}\)','".\2."','g')
    let new_str = substitute(new_str, '\."\+$', '','')
    call append(line('.'), new_str)
endfunction
"}}}

" Sinatra : {{{
"============================================================
command! -nargs=0 CheckSinatra :call <SID>CheckSinatra()
function! s:CheckSinatra()
    execute "silent !open http://localhost:9292/"
endfunction
" }}}

" CodeReadingMemo: {{{
"============================================================
" let g:CodeLeadingBuffer = "$HOME/.vim/util/cr/bitclust.coderead"
command!  CodeReadingMemo :call <SID>CodeReadingMemo()
function! s:CodeReadingMemo()
    if !exists("g:CodeLeadingBuffer")
        echohl Error
        echo "please set g:CodeLeadingBuffer"
        echohl Normal
        return
    endif
    let file_and_line = expand("%:p") . ":" . line('.')
    let file_and_line = substitute(file_and_line,$HOME,'$HOME','')
    execute "edit " g:CodeLeadingBuffer
    call append(line('$'), file_and_line)
    call s:CodeReadingSetupBuffer()
    call cursor(line('$'),0)
endfunction

function! s:CodeReadingSetupBuffer()
    " if exists("b:cr_setup_finish")
    " return
    " endif
    nnoremap <buffer> <silent> <CR> :<C-u>call <SID>CodeReadingJumpToSource()<CR>
    let b:cr_setup_finish = 1
endfunction

function! s:CodeReadingJumpToSource()
    if getline('.') =~ '.*:\d\+$'
        normal gF
    endif
endfunction
" }}}

" vim-Ruby: {{{
"============================================================
" default 'gf' find directory befer try suffixesadd
" so such as 'require "rbconfig"' open rbconfig directory
" following use findfile to ensure search only file.
" and overwrite default gf, C-wf
function! s:RubyFindFile(cmd)
    let file = findfile(expand("<cfile>"))
    if !filereadable(file)
        echohl Error
        echo "File not found in 'path"
        echohl Normal
        return
    endif
    if !empty(a:cmd)
        exe a:cmd
    end
    exe "edit " . file
endfunction

" 
function! OverwiteRubyFindFileMapping()
    nnoremap <buffer> <silent> gf     :<C-u>call <SID>RubyFindFile("")<CR>
    nnoremap <buffer> <silent> <C-w>f :<C-u>call <SID>RubyFindFile("split")<CR>
endfunction
" }}}

" UtilCtermColorList: {{{
"============================================================
command! UtilCtermColorList :call UtilCtermColorList()
function! UtilCtermColorList()
    " code
    for num in range(1,255)
        let hl_name = "UTilCtermColor" . num
        exe "highlight " . hl_name  . " ctermfg=" . num
        exe "highlight " . hl_name
        exe "highlight clear " .  hl_name
    endfor
endfunction
" }}}

" StripTrailingWhitespaces: from vimcasts #4 {{{
"============================================================
command! StripTrailingWhitespaces :call <SID>SaveExcursion('%s/\s\+$//e')
command! IndentBuffer :call <SID>SaveExcursion('normal gg=G')

function! s:SaveExcursion(command)
    " from vimcasts #4
    " Preparation: save last search, and cursor position.
    let _s=@/
    let save_cursor = getpos(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call setpos('.', save_cursor)
endfunction
" }}}


" PreviewWord: fro helpfile {{{
"============================================================
" au! CursorHold *.rb nested call PreviewWord()
func! PreviewWord()
    if &previewwindow			" don't do this in the preview window
        return
    endif
    let w = expand("<cword>")		" get the word under cursor
    if w =~ '\a'			" if the word contains a letter

        " Delete any existing highlight before showing another tag
        silent! wincmd P			" jump to preview window
        if &previewwindow			" if we really get there...
            match none			" delete existing highlight
            wincmd p			" back to old window
        endif

        " Try displaying a matching tag for the word under the cursor
        try
            exe "silent ptag " . w
        catch
            return
        endtry

        silent! wincmd P			" jump to preview window
        if &previewwindow		" if we really get there...
            if has("folding")
                silent! .foldopen		" don't want a closed fold
            endif
            call search("$", "b")		" to end of previous line
            let w = substitute(w, '\\', '\\\\', "")
            call search('\<\V' . w . '\>')	" position cursor on match
            " Add a match highlight to the word at this position
            "hi previewWord term=bold ctermbg=green guibg=green
            highlight previewWord cterm=underline gui=underline
            " hi def link previewWord Define
            exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
            wincmd p			" back to old window
        endif
    endif
endfun
" }}}

" Small Utility: {{{
"============================================================
command! -nargs=0 UshowRTP :echo join(split(&runtimepath,","),"\n")
command! -nargs=0 NERDTreeToCurrentFile :execute "NERDTree " . expand("%:p:h")

command! -nargs=0 UscriptNames         :echo join(<SID>Scriptnames(),"\n")
command! -nargs=0 UscriptNamesBuffer   :call <SID>ScriptnamesBuffer()
command! -nargs=0 UpluginConfigs       :echo join(<SID>PluginConfigs(), "\n")
command! -nargs=0 UpluginConfigsBuffer :call <SID>PluginConfigsBuffer()
command! -nargs=? -complete=function Fhelp :call <SID>FuncHelp('<args>')

function! s:FuncHelp(arg)
    if strlen(a:arg) > 0
        execute "help " . a:arg
    else
        execute "help function-list@ja"
    endif
endfunction

function! s:Scriptnames()
    redir => result
    silent! scriptnames
    redir END
    return map(split(result,"\n"), 'substitute(v:val, "^\\s*\\d\\+: ","","")')
endfunction

function! s:ScriptnamesBuffer()
    " code
    belowright split
    execute "edit " . tempname()
    call setline(1, s:Scriptnames())
    setlocal nomodifiable
    set buftype=nofile
    set bufhidden=hide
    setlocal noswapfile
    set syntax=bplist
    nnoremap <buffer> <CR> :<C-u>split <cfile><CR>
endfunction

function! s:PluginConfigs()
    return split(globpath(&rtp, "plugin/1_CONFIG.vim"), "\n")
endfunction

function! s:PluginConfigsBuffer()
    belowright split
    execute "edit " . tempname()
    call setline(1, s:PluginConfigs())
    setlocal nomodifiable
    set buftype=nofile
    set bufhidden=hide
    setlocal noswapfile
    set syntax=bplist
    nnoremap <buffer> <CR> :<C-u>split <cfile><CR>
endfunction


function! FoldTextForVimRC()
    let line = getline(v:foldstart)
    let num = printf("%5d", v:foldend - v:foldstart)
    " avoid tring in regexp is regarded as fold marker '{' x 3
    let regexp = '"\|/\*\|\*/\|{' . '{{\d\='
    let sub = substitute(line, regexp, '', 'g')
    return v:folddashes . num . ":" . sub
endfunction
" }}}

" Rocco Utility: {{{
"============================================================
function! s:Rocco()
    let src = expand("%:p")
    let fname = fnamemodify(src, ":t")
    let dst = g:rocco_output_dir . "/" . fnamemodify(fname,":s?\.rb?\.rb\.html?")
    let cmd = "rocco -o " . g:rocco_output_dir . " " . src
    call system(cmd)
    " execute "silent !open " . dst
    if v:shell_error
        echohl Error
        echo "Error: " . cmd
        echohl Normal
    else
        echo "Success"
    endif
endfunction
command! -nargs=0 Rocco :call <SID>Rocco()
" }}}


" Markdown Utility: {{{
"============================================================
command! -nargs=0 MarkDown2HTML :call <SID>MarkDown2HTML()

function! s:MarkDown2HTML()
    let src = expand("%:p")
    let fname = fnamemodify(src, ":t")
    let dst = g:markdown_output_dir . "/" . fnamemodify(fname,":s?\.md?\.html?")
    let cmd = g:markdown_render_cmd . " " . src
    call writefile(split(system(cmd), "\n"), dst)
    execute "silent !open " . dst
    redraw!
endfunction

function! s:MarkDown2HTMLForBlueFeather()
    let src = expand("%:p")
    let fname = fnamemodify(src, ":t")
    let dst = g:markdown_output_dir . "/" . fnamemodify(fname,":s?\.md?\.html?")
    let cmd = g:markdown_render_cmd . " " . src . " -q -f d -o " . g:markdown_output_dir
    call system(cmd)
    execute "silent !open " . dst
    redraw!
endfunction

" }}}

" CD to CurrentFile: {{{
"============================================================
command! -nargs=0 CDtoCurrentFile :call <SID>CDtoCurrentFile()
nnoremap <Plug>(CDtoCurrentFile) :<C-u>call <SID>CDtoCurrentFile()<CR>
"nmap <F4> <Plug>(CDtoCurrentFile)
function! s:CDtoCurrentFile()
    let dir = expand('%:h')
    if isdirectory(dir)
        exec 'cd ' . dir
        redraw!
    endif
endfunction

"}}}

" CheckFileType: {{{
"============================================================
command! -nargs=0 CheckFileTypeAtCursor :call <SID>CheckFileTypeAtCursor()
nnoremap <Plug>(CheckFileTypeAtCursor) :<C-u>call <SID>CheckFileTypeAtCursor()<CR>
vnoremap <Plug>(CheckFileTypeAtCursor) :<C-u>call <SID>CheckFileTypeAtCursor()<CR>

function! s:CheckFileTypeAtCursor()
    echohl Function
    echo s:CheckFileType(expand("<cfile>"))
    echohl Normal
endfunction

function! s:CheckFileType(file)
    return system("file " . shellescape(a:file))[0 : -2 ]
    " return result[0 : -2] "delete new line
endfunction
"}}}

" Fold Utility: {{{
"============================================================
" Sample:
" nmap zl <silent> <Plug>(FoldcolumnIncrease)
" nmap zh <silent> <Plug>(FoldcolumnDecrease)
nnoremap <Plug>(FoldcolumnDecrease) :<C-u>call <SID>FoldcolumnDecrease()<CR>
nnoremap <Plug>(FoldcolumnIncrease) :<C-u>call <SID>FoldcolumnIncrease()<CR>
vnoremap <Plug>(FoldcolumnDecrease) :<C-u>call <SID>FoldcolumnDecrease()<CR>
vnoremap <Plug>(FoldcolumnIncrease) :<C-u>call <SID>FoldcolumnIncrease()<CR>

function! s:FoldcolumnDecrease()
    let &foldcolumn = &foldcolumn - 1
endfunction

function! s:FoldcolumnIncrease()
    let &foldcolumn = &foldcolumn + 1
endfunction

command! -nargs=+ -complete=customlist,<SID>Fdm FoldEnableWith :call <SID>FoldEnableWith(<f-args>)
command! -nargs=0 FoldDisable                                  :call <SID>FoldDisable()
command!  FoldStatus                                           :call <SID>FoldStatus()

function! s:Fdm(A,L,P)
    return [ "manual", "indent", "expr", "marker", "syntax", "diff",]
endfun

function! s:FoldEnableWith(fdm,...)
    if exists("a:1") && (a:1 > 0)
        let level = a:1
    else
        let level = 3
    endif
    let cmd = "setlocal fdm=". a:fdm . " fen fdc=".level." fdl=".level
    exe cmd
    call s:FoldStatus()
endfunction

function! s:FoldStatus()
    echo printf("fdm=%s ,fdc=%d, fdl=%d", &fdm, &fdc, &fdl)
endfunction

function! s:FoldDisable()
    let cmd = "set fdm& nofen fdc& fdl&"
    exe cmd
    call s:FoldStatus()
endfunction

" }}}

" Misc: {{{
"============================================================
command! -nargs=* Echo :call Echo(<args>)
fun! Echo(msg)
    echohl function
    echo a:msg
    echohl normal
endfun
"}}}

" SnipMate Utility: {{{
"============================================================
command! -nargs=0 SnippetsReload :call <SID>SnippetsReload()
command! -complete=customlist,<SID>SnippetsDirList -nargs=?
            \ SnippetsEdit :call <SID>SnippetsEdit('<args>')

function! s:SnippetsReload()
    call ReloadAllSnippets()
    redraw
    Echo "Snippets reloaded"
endfunction

function! s:SnippetsDirList(A,L,P)
    return split(g:snippets_dir, ',')
endfunction

function! s:SnippetsEdit(dir)
    let dir = !empty(a:dir) ? a:dir : g:my_snippets_dir
    let file = dir . "/" . &ft  . ".snippets"
    belowright split 
    execute "edit " file
endfunction

"}}}

" SyntaxIdUnderCursor : {{{
"============================================================
command! -complete=customlist, -nargs=0 SyntaxIdUnderCursor :call <SID>_syntaxIdUnderCursor()

function! s:_syntaxIdUnderCursor()
    let attr_list = [ "name" ,"fg" ,"bg" ]
    for attr in attr_list
        let result = synIDattr(synIDtrans(synID(line("."), col("."), 1)), attr)
        echo attr ":\t" result
    endfor
endfunction
"}}}

" CommandInFile: {{{
"============================================================
command! -nargs=1 CommandInFile :call <SID>CommandInFile('<args>')

function! s:CommandInFile(fname)
    redir @a
    silent verbose command
    redir END
    let result = split(getreg('a'), "\n")
    let idx = 0
    for line in result
        if line =~# 'Last set from'
            if line =~? a:fname
                echo result[idx-1]
                "echo line
            endif
        endif
        let idx = idx + 1
    endfor
endfunction
" }}}

" Generic Shell: {{{
"============================================================
command! -nargs=0 Shell :call <SID>ShellWithCurrentFile()

function! s:ShellWithCurrentFile()
    let oldCWD = getcwd()
    let dir = expand('%:h')
    try
        if isdirectory(dir) | exec 'cd ' . dir | endif
        redraw!
        shell
    finally
        exec 'cd ' . oldCWD
    endtry
endfunction
"}}}

" QuickRun Utility: {{{
"============================================================
command! -nargs=1 QuickRunWrapper :call QuickRunWrapper('<args>')

function! QuickRunWrapper(mode) range
    let ans = input("arg -- env: ")
    let args = split(ans, '--')

    if len(args) == 1
        if ans =~# '^--'
            let env = args[0]
        else
            let arg = args[0]
        endif
    elseif len(args) == 2
        let [arg, env] = args
    endif

    let opt_arg = exists("arg") ? " -args '" . arg . "'" : "" 
    let opt_env = exists("env") ? env : ""

    let cmd = "QuickRun -mode " . a:mode . opt_arg . " -exec '" . opt_env . " %c %s %a'"
    execute cmd
endfunction
" }}}

" Xmpfilter Utility: {{{
"============================================================

function! Xmpfilter() range
    let cursor_pos = getpos(".")
    let wintop_pos = getpos('w0')
    set lazyredraw

    execute ":" . a:firstline . "," . a:lastline . "!xmpfilter -a"

    call setpos('.', wintop_pos)
    normal zt
    call setpos('.', cursor_pos)
    set nolazyredraw
    redraw
endfunction

function! XmpCommentToggle() range
    let ruby_eval_str = " # =>"
    let cursor_pos = getpos(".")
    let wintop_pos = getpos('w0')
    set lazyredraw
    for line in range(a:firstline,a:lastline)
        let lineStr = getline(line)
        let found = strridx(lineStr, ruby_eval_str)
        let lineStr = found == -1
                    \ ? lineStr . ruby_eval_str
                    \ : strpart(lineStr, 0, found)
        call setline(line, lineStr)
    endfor
    call setpos('.', wintop_pos)
    normal zt
    call setpos('.', cursor_pos)
    set nolazyredraw
    redraw
endfunction
" }}}

" HighLight Tag: {{{
"============================================================
command! -nargs=0 HlTagToggle :call U_hlTagToggle()
function! U_hlTagToggle()
    if exists("b:u_hl_tag") && b:u_hl_tag == 1
        highlight clear U_Tag
        execute "set syn=" .  &syntax
        let b:u_hl_tag = 0
    else

        for tagfile in tagfiles()
            let cmd="cat ". tagfile . "| awk '{print $1}' "
            for tag in split(system(cmd), "\n")
                exe 'syntax keyword Tag ' . tag
            endfor
        endfor
        exe "highlight Tag term=underline cterm=underline"
        let b:u_hl_tag = 1
    endif
endfunction
" }}}

" Generic Util: {{{
"============================================================
function! U_echohl(hl, msg)
    execute "echohl " . a:hl
    echo   a:msg
    echohl Normal
endfunction

function! U_checkCmdSuccess(tag)
    let tag = "[ " . a:tag  . " ]"
    if v:shell_error
        call U_echohl("Error", tag ." Fail " . v:shell_error)
    else
        call U_echohl("Function", tag ." Success")
    endif
endfunction

function! _determineFileName(base, query)
    let ext   = get(s:ft_ext_dict, a:query, a:query)
    let fname = !empty(ext) ? a:base . "." . ext : a:base
    return fname
endfunction

function! _typeOf(obj)
    let typelist = [ 'Number', 'String', 'Funcref', 'List', 'Dictionary', 'Float' ]
    return typelist[type(a:obj)]
endfunction

function! _initCounter()
    " code
endfunction

function! _getCount()
    if !exists("b:counter")
        let b:counter = 0
    endif
    let b:counter = b:counter + 1
    return b:counter
endfunction

function! _countUP()
    call _echo(_getCount())
endfunction

function! _echoError(msg)
    echohl Error
    echo a:msg
    echohl normal
endfunction

function! _echo(msg)
    echohl function
    echo a:msg
    echohl normal
endfunction

function! _resetCounter()
    let b:counter = 0
    call _echo("counter reset")
endfunction

command! -nargs=0 CountUp    :call _countUP()
command! -nargs=0 CountReset :call _resetCounter()

"}}}

" Make Helper: {{{
"============================================================
fun! MakeWhenAutoWrite()
    execute "autocmd BufWritePost ". expand('%') . " silent make -c %"
endfun
command! MakeWhenAutoWrite :call MakeWhenAutoWrite()

"}}}

" vim: set sw=4 sts=4 et fdm=marker fdc=2:
