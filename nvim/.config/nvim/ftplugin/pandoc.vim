call SetIndentSize(2)
setlocal omnifunc=pandoc#completion#Complete
hi Conceal             guifg=#AF005F ctermfg=125
hi pandocAtxHeader     guifg=#AF005F ctermfg=125 gui=bold term=bold
hi pandocAtxHeaderMark guifg=#AF005F ctermfg=125
hi pandocAtxStart      guifg=#AF005F ctermfg=125
nnoremap <buffer> <silent> <Leader>pdn :execute 'Pandoc pdf --defaults='.expand('$HOME').'/.config/pandoc/notes.yaml --resource-path=.:'.expand('$HOME').'/.config/pandoc --citeproc -H '.expand('$HOME').'/.config/pandoc/disablefloat.tex'<CR>
