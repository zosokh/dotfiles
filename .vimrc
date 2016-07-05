" neo bundle読込
source ~/dotfiles/vimrc.bundle


"シンタックスをONにする(重い？)
" :syntax on
"vim互換にしない
set nocompatible
"GUI版のvimを使う時にアンチエイリアスされたフォントが使われる
"set antialias
" オートインデント
set autoindent
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
"列を強調表示(重い？)
" set cursorcolumn
"行を強調表示(重い？)
" set cursorline
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
"検索結果をハイライトする
set hlsearch
" markdown
au BufRead,BufNewFile *.md set filetype=markdown

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



" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1



" Highlight Settings
syntax enable
set background=dark
colorscheme hybrid
set t_Co=256


" if_luaが有効ならneocompleteを使う

if neobundle#is_installed('neocomplete')
    " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ ='\h\w*'
elseif neobundle#is_installed('neocomplcache')
    " neocomplcache用設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" autoclose Settings
let g:AutoClosePairs_add = "<> \"\" '"

" コメントアウト キーバインド
nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)

" ctags
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-t> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
