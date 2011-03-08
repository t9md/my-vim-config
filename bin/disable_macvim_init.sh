VIMRC_LOCAL='/Applications/MacVim.app/Contents/Resources/vim/vimrc_local.vim'
GVIMRC_LOCAL='/Applications/MacVim.app/Contents/Resources/vim/gvimrc_local.vim'
echo "let g:vimrc_local_finish = 1" > ${VIMRC_LOCAL}
echo "set langmenu=ja_ja.utf-8.macvim" >> ${VIMRC_LOCAL}
echo "let g:gvimrc_local_finish = 1" > ${GVIMRC_LOCAL}

