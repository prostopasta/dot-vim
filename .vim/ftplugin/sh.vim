" Shellcheck for VIM
" Taken from here:
" https://jezenthomas.com/2015/05/shell-script-static-analysis-in-vim

" ~/.vim/ftplugin/sh.vim
set makeprg=shellcheck\ -f\ gcc\ %
au BufWritePost * :silent make | redraw!
