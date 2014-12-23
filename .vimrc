" NeoBundle
" -------------------------------------------------------------
filetype off
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/Bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/Bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" Plugins
" -------------------------------------------------------------
NeoBundle 'tpope/vim-rails/'
NeoBundle 'https://github.com/kien/ctrlp.vim.git'
NeoBundle 'https://github.com/kchmck/vim-coffee-script.git'
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet-snippets.git'
NeoBundle 'https://github.com/Shougo/neosnippet.git'
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/tpope/vim-surround'
" General
" -------------------------------------------------------------
call neobundle#end()
filetype plugin on
filetype indent on
NeoBundleCheck
set enc=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set shell=zsh
" For Mac
" -------------------------------------------------------------
if has('gui_macvim')
  set guioptions=egmrt
  set guioptions-=r
  set guifont=Osaka-Mono:h16
  set fullscreen
  set transparency=15
endif
" Display
" -------------------------------------------------------------
syntax on
set background=dark
set ruler
set ruf=%45(%12f%=\ %m%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B]%)
set showcmd
set cmdheight=1
set laststatus=2
set shortmess+=I
set vb t_vb=
set hlsearch
set number
set cursorline
" Spell check
set spell spelllang=en_us
setlocal spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline
" Editing
" -------------------------------------------------------------
set autoindent smartindent
set smarttab
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start

" Fold setting
set foldmethod=syntax
"let perl_fold=1
set foldlevel=100
" File
" -------------------------------------------------------------
set wildmode=list:longest
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  set undofile
endif
noremap <Space>. :<C-u>edit $MYVIMRC<Enter>
noremap <Space>s. :<C-u>source $MYVIMRC<Enter>
" Fugitive
" -------------------------------------------------------------
com! Gb Gblame
com! -nargs=+ Gg Git grep <args>
" Auto Exexuted Commands
" -------------------------------------------------------------
augroup Autocmds
  au BufNewFile *.sh call append(0, "#!/bin/sh")             | normal! G
  au BufNewFile *.py call append(0, "#!/usr/bin/env python") | normal! G
  au BufNewFile *.rb call append(0, "#!/usr/bin/env ruby") | normal! G
  au BufNewFile *.pl call append(0, "#!/usr/bin/env perl")   | normal! G
  au BufWritePost * silent! %s/\s\+$//e
augroup END

" Other
" -------------------------------------------------------------
set backupdir=/tmp/
noremap tp :set paste!<CR>
"" CtrlP
" -------------------------------------------------------------
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'
" PHP highlighting
" -------------------------------------------------------------
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.view set filetype=php
    autocmd BufRead,BufNewFile *.view set filetype=haml
  augroup END
  autocmd FileType php setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType python setlocal expandtab shiftwidth=2 softtabstop=2
endif

" Completion
" -------------------------------------------------------------
set history=700
set wildmenu

" NeoSnippet
if neobundle#is_installed('neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete_min_syntax_length = 4
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
elseif neobundle#is_installed('neocomplcache')
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
inoremap <expr><TAB> pumvisible()? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

let s:my_snippet = '~/.vim/mysnippet/'
let g:neosnippet#snippets_directory = s:my_snippet

"" Scouter
" -------------------------------------------------------------
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
      \        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
      \        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)
