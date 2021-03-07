command! -nargs=? EditNewNote execute '<mods> edit ' . notes#newNoteFilename(<f-args>)
command! -nargs=? SplitNewNote execute '<mods> split ' . notes#newNoteFilename(<f-args>)

nnoremap <Leader>n :vertical SplitNewNote 
