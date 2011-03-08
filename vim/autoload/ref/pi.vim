" [FIXME] all copid from thinca's ref/man.vim don't use this

let s:save_cpo = &cpo
set cpo&vim

scriptencoding utf-8

" config. {{{1
if !exists('g:ref_pi_cmd')  " {{{2
  let g:ref_pi_cmd = executable('pi') ? 'pi' : ''
endif

if !exists('g:ref_pi_lang')  " {{{2
  let g:ref_pi_lang = ''
endif

let s:source = {'name': 'pi'}  " {{{1

function! s:source.available()  " {{{2
  return !empty(self.option('cmd'))
endfunction

function! s:source.get_body(query)  " {{{2
  let [query, sec] = s:parse(a:query)
  let q = sec =~ '\d' ? [sec, query] : [query]

  let opt_lang = self.option('lang')
  if !empty(opt_lang)
    let lang = $LANG
    let $LANG = opt_lang
  endif
  try
    let use_vimproc = g:ref_use_vimproc
    let g:ref_use_vimproc = 0
    let res = ref#system(ref#to_list(self.option('cmd')) + q)
  finally
    if exists('lang')
      let $LANG = lang
    endif
    let g:ref_use_vimproc = use_vimproc
  endtry
  if !res.result
    let body = res.stdout
    if &termencoding != '' && &encoding != '' && &termencoding !=# &encoding
      let encoded = iconv(body, &termencoding, &encoding)
      if encoded != ''
        let body = encoded
      endif
    endif

    " let body = substitute(body, '.\b', '', 'g')
    " let body = substitute(body, '\e\[[0-9;]*m', '', 'g')
    " let body = substitute(body, '‘', '`', 'g')
    " let body = substitute(body, '’', "'", 'g')
    " let body = substitute(body, '[−‐]', '-', 'g')
    " let body = substitute(body, '·', 'o', 'g')

    return body
  endif
  let list = self.complete(a:query)
  if !empty(list)
    return list
  endif
  throw matchstr(res.stderr, '^\_s*\zs.\{-}\ze\_s*$')
endfunction



function! s:source.opened(query)  " {{{2
  call s:syntax()
endfunction



function! s:source.get_keyword()  " {{{2
  return ref#get_text_on_cursor('[[:alnum:]_.:+-]\+\%((\d)\)\?')
endfunction



function! s:source.complete(query)  " {{{2
  let [query, sec] = s:parse(a:query)
  let sec -= 0  " to number

  return filter(copy(self.cache(sec, self)),
  \             'v:val =~# "^\\V" . query')
endfunction



function! s:source.normalize(query)  " {{{2
  let [query, sec] = s:parse(a:query)
  return query . (sec == '' ? '' : '(' . sec . ')')
endfunction



function! s:source.call(name)  " {{{2
  let list = []
  if a:name is 0
    for n in range(1, 9)
      let list += self.cache(n, self)
    endfor

  else
    let pipath = self.option('pipath')
    let pat = '.*/\zs.*\ze\.\d\w*\%(\.\w\+\)\?$'
    for path in split(matchstr(pipath, '^.\{-}\ze\_s*$'), ':')
      let dir = path . '/pi' . a:name
      if isdirectory(dir)
        let list += map(split(glob(dir . '*/*'), "\n"),
        \                  'matchstr(v:val, pat)')
      endif
    endfor
  endif

  return ref#uniq(list)
endfunction



function! s:source.option(opt)  " {{{2
  return g:ref_pi_{a:opt}
endfunction



function! s:parse(query)  " {{{2
  let l = matchlist(a:query, '\([^[:space:]()]\+\)\s*(\(\d\))$')
  if !empty(l)
    return l[1 : 2]
  endif
  let l = matchlist(a:query, '\(\d\)\s\+\(\S*\)')
  if !empty(l)
    return [l[2], l[1]]
  endif
  return [a:query, '']
endfunction




function! s:syntax()  " {{{2
  if exists('b:current_syntax') && b:current_syntax ==# 'ref-pi'
    return
  endif

  syntax clear
  runtime! syntax/puppet.vim
  " syntax include @refRefeRuby syntax/ruby.vim

  syntax match refPuppetTitle '^==\+'
  syntax match refPuppetSection '^--\+'
  syntax match refPuppetOption '\*\*.*\*\*'
  highlight default link refPuppetTitle Constant
  highlight default link refPuppetSection Function
  highlight default link refPuppetOption Statement

  let b:current_syntax = 'ref-pi'
endfunction




function! ref#pi#define()  " {{{2
  return copy(s:source)
endfunction

if s:source.available()  " {{{1
  " call ref#register_detection('c', 'pi')
  call ref#register_detection('puppet', 'pi')
endif



let &cpo = s:save_cpo
unlet s:save_cpo
