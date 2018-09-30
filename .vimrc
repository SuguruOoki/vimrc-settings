set shell=/usr/local/bin/zsh

" vimrcをdotfilesとして利用する場合には、fzfなどbrewで先にインストールしておくと
" トラブルもないため、先にbrew fileのコマンドを実行するようにしておくと良い。

set t_ti=""
set t_ks=""
set t_ke=""

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let mapleader = "\<Space>"

" windowの移動
"nnoremap sj <C-w>j
"nnoremap sk <C-w>k
"nnoremap sl <C-w>l
"nnoremap sh <C-w>h
"nnoremap sJ <C-w>J
"nnoremap sK <C-w>K
"nnoremap sL <C-w>L
"nnoremap sH <C-w>H

" Required:
set runtimepath+=~/vimfiles/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/vimfiles/.vim/dein/')
  call dein#begin('~/vimfiles/.vim/dein/')

  " Let dein manage dein
  call dein#add('~/vimfiles/.vim/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/dein.vim')
  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplcache')
  call dein#add('Shougo/vimproc')  " unite.vimで必要
  call dein#add('Shougo/unite.vim')

  " インサートモード時に有効化
  call dein#add('Shougo/neocomplete.vim', { 'on_i': 1 })
  call dein#add('mattn/emmet-vim', { 'on_i': 1 })

  " Add or remove your plugins here:
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('scrooloose/nerdtree')
  call dein#add('jistr/vim-nerdtree-tabs')
  call dein#add('airblade/vim-gitgutter') " git管理下の場合行番号の横に差分記号を表示
  call dein#add('tomtom/tcomment_vim') " ctrl+-でコメントアウト
  call dein#add('tpope/vim-fugitive') " :Gstatusなどでvimにいながらgitコマンドが打てる
  call dein#add('vim-airline/vim-airline') " ステータスラインを表示
  call dein#add('rking/ag.vim')
  call dein#add('thinca/vim-quickrun') " shファイル等をその場で実行
  call dein#add('terryma/vim-multiple-cursors') " マルチカーソル
  call dein#add('keith/swift.vim')
  call dein#add('vim-jp/vimdoc-ja') " helpを:hで日本語で表示
  call dein#add('tpope/vim-surround') " シングルクオートとダブルクオートの入れ替え等
  call dein#add('junegunn/fzf.vim') "ctrl+Pでファイル検索
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('tacahiroy/ctrlp-funky')
  call dein#add('suy/vim-ctrlp-commandline')
  call dein#add('mechatroner/rainbow_csv')
  call dein#add('Kenta11/QiitaPy') " QiitaにVimで投稿するためのやつ

  " ファイルタイプがPHPのときに有効化
  call dein#add('vim-scripts/PDV--phpDocumentor-for-Vim', { 'on_ft': 'php'})

  " SQLを直接変更するのに用いる
  call dein#add('vim-scripts/dbext.vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })
  if has('job') && has('channel') && has('timers')
    call dein#add('w0rp/ale')
  else
    call dein#add('vim-syntastic/syntastic')
  endif

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

runtime! myautoload/*.vim

" fzfの参照先(brew install fzfした先となる)
set rtp+=/usr/local/opt/fzf

" 全角スペースを可視化
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

packadd! onedark.vim
syntax on
colorscheme onedark

"""""""""""""""""""""""""""""""""
" agとunite.vimを繋げる設定
"""""""""""""""""""""""""""""""""

" insert modeで開始
" let g:unite_enable_start_insert = 1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
highlight Visual guibg=red

" grep検索
" nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,fg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:ctrlp_use_caching = 0 " CtrlPのキャッシュを使わない
  let g:ctrlp_user_command = 'ag %s -i --hidden -g ""' " 「ag」の検索設定
endif

" pasteモード(,iでもペーストモードへ. ノーマルに戻るとインサートに戻す)
" nnoremap ,i :<C-u>set paste<Return>i

" クリップボードからペーストする時だけインデントしないようにする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" quickrunの設定 \rで保存して実行、画面分割を下に出す
let g:quickrun_no_ds = 1
nnoremap \r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap \r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
let g:quickrun_config={'*': {'split': ''}}
set splitbelow

" マウスを有効に。クリックでカーソル移動もOK。
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" syntax on
" autocmd ColorScheme * highlight Comment ctermfg=247 guifg=#008800
" colorscheme lucario

" 自動でインデントを挿入
set autoindent

" タブをスペースに変換
set expandtab

augroup vimrc-filetype
  autocmd!
  " PHP: インデント幅=4
  autocmd BufNewFile,BufRead *.php set filetype=php
  autocmd FileType php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  " Ruby: インデント幅=2
  autocmd BufNewFile,BufRead *.rb set filetype=ruby
  autocmd BufNewFile,BufRead *.erb set filetype=ruby
  autocmd BufNewFile,BufRead *.ruby set filetype=ruby
  autocmd FileType ruby setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  " Python: インデント幅=2
  autocmd BufNewFile,BufRead *.py set filetype=python
  autocmd FileType python setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  " shell: インデント幅=2
  autocmd BufNewFile,BufRead *.sh set filetype=shell
  autocmd FileType shell setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  " html: インデント幅=2 テンプレートファイルもhtmlとみなして考える
  autocmd BufNewFile,BufRead *.html set filetype=html
  autocmd BufNewFile,BufRead *.tpl set filetype=tpl
  autocmd FileType html setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  " javascript: インデント幅=2 ESLINTの規約傾向から2を採用
  autocmd BufNewFile,BufRead *.js set filetype=javascript
  autocmd BufNewFile,BufRead *.ts set filetype=javascript " typescript
  autocmd FileType javascript setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" jsonやmarkdownでダブルクォート、*が消えるのを回避
set conceallevel=0

" 検索語句のハイライト
set hlsearch

" カーソル行をハイライト。これをONにするとvimが重くなるのでコメントアウトした。
" set cursorline

" 行ごとに行ナンバーが表示されるようにする
set number

" 括弧の後に自動でインデントを挿入
set cindent

" 検索時に大文字小文字無視
set ignorecase

" 検索語句を全て英小文字で入力した場合のみ区別を無視
set smartcase

" バックアップを作成しない
set nobackup

" swpファイルを作成しない
set noswapfile

" クリップボード共有(vim --version | grep clipboard で+clipboardとなっていないと使えない。-clipbordになってると無理)
set clipboard=unnamed

" 不可視文字表示
set list

" タブを >--- 半角スペースを . で表示する
set listchars=tab:»-,trail:･

" マルチカーソルの設定
let g:multi_cursor_next_key='<C-g>'
let g:multi_cursor_quit_key='<C-c>'

" 保存時に行末の空白を削除
" これはNEでやるとありすぎて差分がわからなくなるため、コメントアウト
" autocmd BufWritePre * :%s/\s\+$//ge

" vimでバックスペースを有効に
set backspace=indent,eol,start

" 現在のタブを右へ移動
nnoremap <Tab>j :MyTabMoveRight<CR>

" 現在のタブを左へ移動
nnoremap <Tab>k :MyTabMoveLeft<CR>
command! -count=1 MyTabMoveRight call MyTabMove(<count>)
command! -count=1 MyTabMoveLeft  call MyTabMove(-<count>)

function! MyTabMove(c)
  let current = tabpagenr()
  let max = tabpagenr('$')
  let target = a:c > 1       ? current + a:c - line('.') :
             \ a:c == 1      ? current :
             \ a:c == -1     ? current - 2 :
             \ a:c < -1      ? current + a:c + line('.') - 2 : 0
  let target = target >= max ? target % max :
             \ target < 0    ? target + max :
             \ target
  execute ':tabmove ' . target
endfunction

" 折りたたみ機能をOFFにする
set nofoldenable

" markdownを開くときはmolokaiテーマ
" autocmd FileType markdown colorscheme molokai

" PHP: Linterを保存するタイミングで実行する
function! s:PHPLint()
  let s:result = system('php -l ' . bufname(""))
  let s:count = split(s:result, "\n")
  echo s:result
endfunction

augroup php-lint
  autocmd!
  autocmd BufWritePost *.php call <SID>PHPLint()
augroup END


" ctagsは主に調査の時に利用するため、保存時の実行はしない予定。
" ただし、調査時に必要となるため、新しいmasterをpullした時に実行するようにしておく
" ctagsを保存時に実行しておく
"function! s:generateCtags()
"  let s:options = readfile('~/dev-environment/core/.tags') "ctagsの設定ファイルへのパス
"  let s:command = [
"    \'ctags',
"    \'-f',
"    \'~/dev-environment/core/.tags', "tagsファイルへのパス
"  \]
"  let s:command += s:options
"  call job_start(s:command)
"endfunction

" ctagsの作成UniversalCtagsへ移行する
nnoremap <silent> <Leader>gt :<C-u>call <SID>generateCtags()<CR>

" Atom時代の名残のショートカットキー。ここが開きやすいと感じているため、
" これでNERDTREEを開く
nnoremap <silent><C-r> :NERDTreeToggle<CR>

" Ctrl-eでemmetを発火させる。insertモードの時のみの発火とするため、問題なし
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall


""""""""""""""""""""""""""""""""""""""""""
" PHPDocsの設定
""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-@> :call PhpDocSingle()<CR>
vnoremap <C-@> :call PhpDocRange()<CR>

""""""""""""""""""""""""""""""""""""""""""
" fzfの設定
""""""""""""""""""""""""""""""""""""""""""

" <C-f>でタグ検索(ちょっとこれ使うか迷い中)
" nnoremap <silent> <C-f> :call fzf#vim#tags(expand('<cword>'))<CR>
" fzfからファイルにジャンプできるようにする
let g:fzf_buffers_jump = 1
" deniteと合わせて上部に表示
let g:fzf_layout = { 'up': '~40%' }

" ファイルを指定せずにvimを立ち上げた時に，自動的にctrlpを起動する
function CtrlPIfEmpty()
  if @% == ""
    CtrlP ~/
  endif
endfunction

augroup AutoCtrlP
  autocmd!
  autocmd VimEnter * call CtrlPIfEmpty()
augroup END

" # キャッシュを使用して検索を高速化
let g:ctrlp_use_caching = 1
" # vim終了時にキャッシュをクリアしない
let g:ctrlp_clear_cache_on_exit = 0

" fzfを利用したコマンド
" ctagsを読み込みに行くうまくいかないので、田中さんに一度質問する
" nnoremap <silent> <C-f> :call fzf#vim#tags(expand('<cword>'))<CR>

nnoremap <D-S-E>:Unite tab<CR>

"""""""""""""""""""""""""""""""""""""""""
" gtagsの設定
"""""""""""""""""""""""""""""""""""""""""

" gtagsの移動設定
nnoremap <silent> <Space>f :Gtags -f %<CR>
nnoremap <silent> <Space>j :GtagsCursor<CR>
nnoremap <silent> <Space>d :<C-u>exe('Gtags '.expand('<cword>'))<CR>
nnoremap <silent> <Space>r :<C-u>exe('Gtags -r '.expand('<cword>'))<CR>

"""""""""""""""""""""""""""""""""""""""""
" phpunitをquick-runで実行するための設定
"""""""""""""""""""""""""""""""""""""""""

augroup UnitTestSetting
  autocmd!
augroup END
autocmd UnitTestSetting BufNewFile,BufRead *Test.php setlocal ft=php.phpunit
" phpunitを実行するためのquick-run側の設定
let g:quickrun_config['_'] = {
\ 'runner'                                 : 'vimproc',
\ 'runner/vimproc/updatetime'              : 50,
\ 'outputter'                              : 'multi:buffer:quickfix',
\ 'outputter/buffer/split'                 : 'botright 8sp',
\ 'hook/close_quickfix/enable_hook_loaded' : 1,
\ 'hook/close_quickfix/enable_success'     : 1,
\ 'hook/close_buffer/enable_failure'       : 1,
\}
" phpunitを実行するためにquick-runとの連携の設定を行う
" phpunit用shellファイルを介して行うものとする
" 現在だとvagrant側のファイルを使ってコマンドをラップしているので、
" そのコマンドを使用する
let g:quickrun_config['php.phpunit'] = {
\ 'hook/cd/directory'              : '%S:p:h',
\ 'command'                        : 'vagrant ssh -c "php_unit_file"',
\ 'cmdopt'                         : '',
\ 'exec'                           : '%c %o %s',
\ 'outputter/quickfix/errorformat' : '%f:%l,%m in %f on line %l',
\}

" 設定の書き換えもショートカットキーで行えるようにしたい。
" 「vagrant ssh -c write_setting」において現在のファイル名を
" vimsciptで取得し、それをコマンドに渡して現在のファイルの
" ユニットテストを走らせるといったことをやりたい

" Shift-JisのCSVに対応する必要がある。
" CSVの書き換えを行い、保存すると、
" Shift-JISのまま保存する。以下は
" Shift-JISで開き直す時のvimのコマンド
" :e ++enc=sjis
nnoremap <C-e><C-e> :e ++enc=sjis<CR>

""""""""""""""""""""""""""""""""""""""""""
" git 系のコマンドはここにまとめる
""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-S-b> :Gblame<CR>

""""""""""""""""""""""""""""""""""""""""""
" 以下は実験中であったり作成中のコマンド
""""""""""""""""""""""""""""""""""""""""""

" ショートカットの設定の仕方について
" nnoremap tt : [お気に入りのコマンドを入れる]

" ~/vimfiles/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/vimfiles/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif

" MySQLの設定を入れる
let s:mysql_conf = expand('~/vimfiles/.mysql.conf')
if filereadable(s:mysql_conf)
  execute 'source ' . s:mysql_conf
endif

" DBのhistoryを格納する
let  g:dbext_default_history_file = '~/vim_files/.dbext_history'

" DBの切り替えのキー

" [ctrlp.vim から置換できないか実験なう] ========================================
"
nnoremap <C-f> :FZFFileList<CR>
command! FZFFileList call fzf#run({
            \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
            \ 'sink': 'e'})

" 以下は現在作れないか考えているコマンドたち

" 行全体の選択をショートカット
" コメントのToggleを複数行でも短径選択でもショートカットを頼む
" リアルタイムで複数行選択が見れるようにする
" onedarkをカラーテーマに導入する
" コマンド走らせたらテストのスケルトン作成する
" コマンド走らせたら検証シートのスケルトンを作成する→コマンドでGoogleAPIを叩く
" emmetを導入する
