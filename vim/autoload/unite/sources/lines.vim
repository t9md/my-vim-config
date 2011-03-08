" Unite source lines {{{
" http://d.hatena.ne.jp/thinca/20101105/1288896674
let s:unite_source = {}
let s:unite_source.name = 'lines'
function! s:unite_source.gather_candidates(args, context)
  let path = expand('%:p')
  let lines = getbufline('%', 1, '$')
  let format = '%' . strlen(len(lines)) . 'd: %s'
  return map(lines, '{
  \   "word": printf(format, v:key + 1, v:val),
  \   "source": "lines",
  \   "kind": "jump_list",
  \   "action__path": path,
  \   "action__line": v:key + 1,
  \ }')
endfunction

function! unite#sources#lines#define() "{{{
  return s:unite_source
endfunction "}}}

" call unite#define_source(s:unite_source)
" unlet s:unite_source
" }}}
