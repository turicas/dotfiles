if exists("did_load_filetypes")
	finish
endif
augroup filetypdetect
	autocmd! BufRead,BufNewFile *.pde setfiletype arduino
	autocmd! BufRead,BufNewFile *.ino setfiletype arduino
augroup END
