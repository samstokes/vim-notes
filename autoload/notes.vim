function! notes#newNoteFilename(...) abort
  let prefix = vimwiki#path#wikify_path(strftime('%Y%m%dT%H%M'))
  return join([prefix] + a:000, '-') . '.md'
endfunction

function! notes#noteId(filename) abort
  let [id; rest] = s:parseNoteFilename(a:filename)
  return id
endfunction

function! notes#noteTitle(filename) abort
  let [id, name; rest] = s:parseNoteFilename(a:filename)
  let titlecased = substitute(name, '\(\<\|-\)\(.\)', '\1\U\2', 'g')
  let wordified = substitute(titlecased, '-', ' ', 'g')
  return wordified
endfunction

" returns [id, name, name-parts]
function! s:parseNoteFilename(filename) abort
  let basename = fnamemodify(a:filename, ':t:r')
  let items = split(basename, '-')
  if match(items[0], '^\d\+T\d\+$') < 0
    return [basename, basename, items]
  else
    let id = items[0]
    let name_parts = items[1:]
    let name = join(name_parts, '-')
    return [id, name, name_parts]
  endif
endfunction

" CtrlP function for inserting a markdown link with Ctrl-T
" based on
" https://www.edwinwenink.xyz/posts/48-vim_fast_creating_and_linking_notes/
function! notes#CtrlPOpenFunc(action, line) abort
  if a:action == 't' && fnamemodify(a:line, ':e') =~? '^md\|markdown$'
    let [id, name; rest] = s:parseNoteFilename(a:line)

    " Close CtrlP
    call ctrlp#exit()
    call ctrlp#mrufiles#add(a:line)

    let relpath = vimwiki#path#relpath(expand('%:h'), a:line)

    " Insert the markdown link to the file in the current buffer
    let mdlink = "[".name."](".relpath.")"
    put=mdlink
  else
    " Use CtrlP's default file opening function
    call call('ctrlp#acceptfile', [a:action, a:line])
  endif
endfunction
