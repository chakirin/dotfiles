set runtimepath+=~/.nvim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.nvim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'freeo/vim-kalisi'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

let g:deoplete#enable_at_startup = 1

syntax on

set t_Co=256
set background=dark
