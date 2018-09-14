if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/suguruoki/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim80,/usr/share/vim/vimfiles/after,/Users/suguruoki/.vim/after,/Users/suguruoki/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/suguruoki/.vim/bundles/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/suguruoki/.vimrc'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/suguruoki/.vim/bundles'
let g:dein#_runtime_path = '/Users/suguruoki/.vim/bundles/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/suguruoki/.vim/bundles/.cache/.vimrc'
let &runtimepath = '/Users/suguruoki/.vim,/usr/share/vim/vimfiles,/Users/suguruoki/.vim/bundles/repos/github.com/Shougo/vimproc.vim,/Users/suguruoki/.vim/bundles/repos/github.com/Shougo/dein.vim,/Users/suguruoki/.vim/bundles/.cache/.vimrc/.dein,/usr/share/vim/vim80,/Users/suguruoki/.vim/bundles/.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/Users/suguruoki/.vim/after,/Users/suguruoki/.vim/dein/repos/github.com/Shougo/dein.vim'
