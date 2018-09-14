if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/suguruohki/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim80,/usr/share/vim/vimfiles/after,/Users/suguruohki/.vim/after,/Users/suguruohki/vimrc-settings/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/suguruohki/vimrc-settings/.vim/bundle/.//repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/suguruohki/.vimrc'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/suguruohki/vimrc-settings/.vim/bundle/.'
let g:dein#_runtime_path = '/Users/suguruohki/vimrc-settings/.vim/bundle/./.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/suguruohki/vimrc-settings/.vim/bundle/./.cache/.vimrc'
let &runtimepath = '/Users/suguruohki/.vim,/usr/share/vim/vimfiles,/Users/suguruohki/vimrc-settings/.vim/bundle/./repos/github.com/Shougo/vimproc.vim,/Users/suguruohki/vimrc-settings/.vim/bundle/./repos/github.com/Shougo/dein.vim,/Users/suguruohki/vimrc-settings/.vim/bundle/./.cache/.vimrc/.dein,/usr/share/vim/vim80,/Users/suguruohki/vimrc-settings/.vim/bundle/./.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/Users/suguruohki/.vim/after,/Users/suguruohki/vimrc-settings/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/suguruohki/vimrc-settings/.vim/bundle/.//repos/github.com/Shougo/dein.vim'
filetype off
