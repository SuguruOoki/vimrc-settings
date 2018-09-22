if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/oki.suguru/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/Users/oki.suguru/.vim/after,/Users/oki.suguru/vimfiles/.vim/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/oki.suguru/.vimrc'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/oki.suguru/vimfiles/.vim/dein'
let g:dein#_runtime_path = '/Users/oki.suguru/vimfiles/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/oki.suguru/vimfiles/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/oki.suguru/.vim,/usr/share/vim/vimfiles,/Users/oki.suguru/vimfiles/.vim/dein/repos/github.com/Shougo/vimproc.vim,/Users/oki.suguru/vimfiles/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/oki.suguru/vimfiles/.vim/dein/.cache/.vimrc/.dein,/usr/share/vim/vim74,/Users/oki.suguru/vimfiles/.vim/dein/.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/Users/oki.suguru/.vim/after'
autocmd dein-events InsertEnter * call dein#autoload#_on_event("InsertEnter", ['neocomplete.vim', 'emmet-vim'])
