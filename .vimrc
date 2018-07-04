if &compatible
  set nocompatible
endif
set t_ti=""
set t_ks=""
set t_ke=""
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplcache')
call dein#add('scrooloose/nerdtree')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('vim-scripts/PDV--phpDocumentor-for-Vim')
call dein#add('airblade/vim-gitgutter') " git管理下の場合行番号の横に差分記号を表示
call dein#add('tomtom/tcomment_vim') " ctrl+-でコメントアウト
call dein#add('tpope/vim-fugitive') " :Gstatusなどでvimにいながらgitコマンドが打てる
call dein#add('vim-airline/vim-airline') " ステータスラインを表示
call dein#add('rking/ag.vim')
call dein#add('Shougo/vimproc')  " unite.vimで必要
call dein#add('thinca/vim-quickrun') " shファイル等をその場で実行
call dein#add('terryma/vim-multiple-cursors') " マルチカーソル
call dein#add('keith/swift.vim')
call dein#add('vim-jp/vimdoc-ja') " helpを:hで日本語で表示
call dein#add('tpope/vim-surround') " シングルクオートとダブルクオートの入れ替え等
call dein#add('junegunn/fzf.vim') "ctrl+Pでファイル検索
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('tacahiroy/ctrlp-funky')
call dein#add('suy/vim-ctrlp-commandline')
call dein#add('scrooloose/nerdtree')

call dein#end()

runtime! myautoload/*.vim
" fzfの参照先(brew install fzfした先となる)
set rtp+=/usr/local/bin/fzf

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
" agとuniteを繋げる設定
" insert modeで開始
let g:unite_enable_start_insert = 1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:ctrlp_use_caching=0 " CtrlPのキャッシュを使わない
  let g:ctrlp_user_command='ag %s -i --hidden -g ""' " 「ag」の検索設定
endif
" cmd+vでペーストしても勝手にインデントしない
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
" シンタックスハイライト
syntax on
set t_Co=256
autocmd ColorScheme * highlight Comment ctermfg=247 guifg=#008800
colorscheme lucario
" 自動でインデントを挿入
set autoindent
" タブをスペースに変換
set expandtab
" set tabstop=4
" set shiftwidth=4

augroup vimrc-filetype
  autocmd!
  " PHPだったらインデント幅が４で
  autocmd BufNewFile,BufRead *.php set filetype=php
  autocmd FileType php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

  " Rubyだったらインデント幅は2にしたい
  autocmd BufNewFile,BufRead *.rb set filetype=ruby
  autocmd BufNewFile,BufRead *.ruby set filetype=ruby
  autocmd FileType ruby setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" jsonやmarkdownでダブルクォート、*が消えるのを回避
set conceallevel=0
" 検索語句のハイライト
set hlsearch
" カーソル行をハイライト。これをONにするとvimが重くなるのでコメントアウトした。
set cursorline
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
" タブを >--- 半スペを . で表示する
set listchars=tab:»-,trail:･
" マルチカーソルの設定
let g:multi_cursor_next_key='<C-g>'
let g:multi_cursor_quit_key='<C-c>'
" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge
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
autocmd FileType markdown colorscheme molokai

" Linterを保存するタイミングで実行する
function! s:PHPLint()
  let s:result = system('php -l ' . bufname(""))
  let s:count = split(s:result, "\n")
  echo s:result
endfunction

augroup php-lint
  autocmd!
  autocmd BufWritePost *.php call <SID>PHPLint()
augroup END

" ctagsを読み込みに行く
nnoremap <silent> <C-f> :call fzf#vim#tags(expand('<cword>'))<CR>

" ctagsを保存時に実行しておく
function! s:generateCtags()
  let s:options = readfile('/Users/oki.suguru/dev-environment/core/.tags') "ctagsの設定ファイルへのパス
  let s:command = [
    \'ctags',
    \'-f',
    \'/Users/oki.suguru/dev-environment/core/.tags', "tagsファイルへのパス
  \]
  let s:command += s:options
  call job_start(s:command)
endfunction
nnoremap <silent> <Leader>gt :<C-u>call <SID>generateCtags()<CR>
nnoremap <silent><C-r> :NERDTreeToggle<CR>
" <C-f>でタグ検索
nnoremap <silent> <C-f> :call fzf#vim#tags(expand('<cword>'))<CR>
" <C->
nnoremap <silent> <C-f> :call fzf#vim#tags(expand('<cword>'))<CR>

" fzfからファイルにジャンプできるようにする
let g:fzf_buffers_jump = 1
" deniteと合わせて上部に表示
let g:fzf_layout = { 'up': '~40%' }
