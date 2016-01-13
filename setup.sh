#!/bin/bash

#シンボリックリンク作成
symbolic_link()
{
#    DOT_FILES=( zshrc vimrc vim tmux.conf gvimrc bashrc bash_profile ctags zlogout gitignore_global)
    DOT_FILES=( vimrc vim)

    for file in ${DOT_FILES[@]}
    do
        rm -rf $HOME/.$file
        ln -fs $HOME/dotfiles/.$file $HOME/.$file
    done
}

#git設定
init_git()
{
    git config --global color.ui "auto"
    git config --global color.diff auto
    git config --global color.status auto
    git config --global color.branch auto
    git config --global user.email $USER@$HOST
    git config --global user.name $USER
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.br branch
}

#サブモジュールロード
load_submodule()
{
    cd $HOME/dotfiles
    #NeoBundleのサブモジュール
    git submodule init -- .vim/bundle/neobundle.vim
    git submodule update -- .vim/bundle/neobundle.vim
}

# NeoBundleInstall
neobundle()
{
    vim -c NeoBundleInstall -c q
}

# ctagsインストール
install_ctags()
{
    mkdir -p $HOME/local/bin
    mkdir -p $HOME/local/src

    cd $HOME/local/src/

    wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
    tar zxf ctags-5.8.tar.gz
    cd ctags-5.8
    ./configure --prefix=$HOME/local
    make
    sudo make install
}

main()
{
    symbolic_link
#    init_git
    load_submodule
    neobundle
#    install_ctags
}

if [ $# -eq 0 ];then
    main
    exit
fi

$1
