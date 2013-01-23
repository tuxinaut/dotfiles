syntax on

set number
set showmatch
set incsearch 
set hlsearch

colorscheme evening

set cursorline
hi CursorLine ctermbg=Blue ctermfg=White

augroup vimrc
augroup END

if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
 
	filetype on
	autocmd BufNewFile,BufRead *.ts set filetype=typoscript
	autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

  	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  	autocmd FileType typoscript setlocal ts=2 sts=2 sw=2 expandtab
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'vim-scripts/SudoEdit.vim'
" ...

filetype plugin indent on
