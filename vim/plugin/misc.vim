function! s:BundleGet() "{{{
    let bundle_dir = expand('~/.vim/bundle')
    try
        let org_cwd = getcwd()
        silent lcd `=bundle_dir`

        let repo = matchstr(getline('.'), 'Bundle:\s\+\zs.*')
        if repo != ''
            let local_name = fnamemodify(repo, ':t')
            if isdirectory(local_name)
                let cmd = 'cd ' . local_name
                echo cmd
                lcd `=local_name`
                let cmd = 'git pull'
                echo cmd
                let output = vimproc#system(cmd)
                " let output = system(cmd)
                echo output
            else
                if repo =~# '^git'
                    let repo = repo
                elseif repo !~# '^https://'
                    let repo = 'https://github.com/' . repo . ".git"
                endif
                let cmd = 'git clone ' . repo . ' ' . local_name
                echo cmd
                let output = vimproc#system(cmd)
                " let output = system(cmd)
                echo output
            endif
        endif
    finally
        silent lcd `=org_cwd`
    endtry
endfunction"}}}
command! BundleGet :call s:BundleGet()
" }}}
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

function! OverwiteRubyFindFileMapping()
    nnoremap <buffer> <silent> gf     :<C-u>call <SID>RubyFindFile("")<CR>
    nnoremap <buffer> <silent> <C-w>f :<C-u>call <SID>RubyFindFile("split")<CR>
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
