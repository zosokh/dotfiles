"シンタックスをONにする
:syntax on
"vim互換にしない
set nocompatible
"GUI版のvimを使う時にアンチエイリアスされたフォントが使われる
"set antialias
"set autoindent
"backspaceを使えるようにする
set backspace=indent,eol,start
"バックアップファイルを作る際の拡張子
set backupext=.vimbak
"OSのクリップボードを使用する
set clipboard=unnamed
"コマンドラインの高さ
set cmdheight=2
"確認ダイヤログ（保存されていない時のvim終了など）
set confirm
"列を強調表示
set cursorcolumn
"行を強調表示
set cursorline
"UTF8
set encoding=utf-8
"入力モードでTabキー押下時、タブ文字ではなく半角スペースが挿入
set expandtab
"ファイル保存時の文字コード変換
set fileencoding=utf-8
"スクロールバー非表示
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
"検索時、大文字小文字を無視
set ignorecase
"インクリメンタルな検索（入力しながら検索）
set incsearch
"常にステータスを表示
set laststatus=2
"TAB,EOFなどの空白を可視化する
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%,eol:↲
"%でペア同士に移動
set matchpairs+=<:>,":",':'
"マウスを使えるようにする
"set mouse=a
"set mousemodel=extend
"行番号表示
set number
"行番号隣の余白
set numberwidth=5
"使用するシェルを指定？
"set shell=zsh
"インデントをshiftwidthの倍数で
set shiftround
"自動インデントの空白の数
set shiftwidth=4
"右下にまだ実行していない入力中のコマンド表示
set showcmd
"対応する括弧やbraceを表示
set showmatch
"現在のモードを表示
set noshowmode
"大文字検索時は大文字を無視しないようにする
set smartcase
"改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
"TABを押した時の何文字のインデントにするか
set softtabstop=4
"ステータスライン表示
set statusline=%(%r%t%m%)%<%=%h%w[ch=%B][%l:%c%V][%p%%]
"ファイルを開いた時TABスペースを変換
set tabstop=4
"タイトル表示
set title
"マウス設定
"set ttymouse=xterm2
"ビープ音を全てビジュアルへ置き換え
set visualbell
"ファイル名補完？
set wildmenu wildmode=list:full
"ウィンドウの幅より長い行は折り返され、次の行に続けて表示される。
set wrap

scriptencoding utf-8
set timeout timeoutlen=50



function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
            " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
        autocmd ColorScheme       * call ZenkakuSpace()
        " 全角スペースのハイライト指定
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif




"プラグイン
"//////////////////////////////////////////////////////
if has('vim_starting')
    " 初回起動時のみruntimepathにneobundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするプラグインをここに記述
" ファイルオープンを便利に
"NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'
" モード状態をカラフル表示
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'cocopon/lightline-hybrid.vim'
" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
" カラー
NeoBundle 'w0ng/vim-hybrid'
" コメントアウト
NeoBundle 'tomtom/tcomment_vim'

call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on
NeoBundleCheck




" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1


" lightline Settings
"let g:lightline = {
"        \'colorscheme': 'hybrid',
"        \ 'mode_map': {'c': 'NORMAL'},
"        \ 'active': {
"        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename'] ],
"        \   'right': [ [ 'syntastic', 'lineinfo' ],
"        \              [ 'percent' ],
"        \              [ 'filetype', 'fileencoding', 'pyenv' ] ]
"        \ },
"        \ 'component_expand':{
"        \   'syntastic': 'SyntasticStatuslineFlag'
"        \ },
"        \ 'component_type':{
"        \   'syntastic': 'error'
"        \ },
"        \ 'component_function': {
"        \   'modified': 'MyModified',
"        \   'readonly': 'MyReadonly',
"        \   'fugitive': 'MyFugitive',
"        \   'filename': 'MyFilename',
"        \   'fileformat': 'MyFileformat',
"        \   'filetype': 'MyFiletype',
"        \   'fileencoding': 'MyFileencoding',
"        \   'mode': 'MyMode',
"        \   'pyenv': 'pyenv#statusline#component'
"        \ }
"        \}


" Highlight Settings
syntax enable
set background=dark
colorscheme hybrid
set t_Co=256
