command! -nargs=? EditNewNote execute '<mods> edit ' . notes#newNoteFilename(<f-args>)
command! -nargs=? SplitNewNote execute '<mods> split ' . notes#newNoteFilename(<f-args>)
command! -nargs=0 EditCurrentWeek execute '<mods> edit ' . notes#currentWeekFilename()
command! -nargs=0 SplitCurrentWeek execute '<mods> split ' . notes#currentWeekFilename()

nnoremap <Leader>n :vertical SplitNewNote 
autocmd FileType vimwiki nnoremap <Leader>k :vertical SplitCurrentWeek<CR>
