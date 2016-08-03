"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            dein                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.config/nvim/dein'))
call dein#add('Shougo/dein.vim')
" User Plugins
" -------------------------------------------------------------
call dein#add('Shougo/deoplete.nvim')
call dein#add('tpope/vim-fugitive.git')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('fatih/vim-go')
" -------------------------------------------------------------
call dein#end()
filetype plugin indent on
if dein#check_install()
  call dein#install()
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           General                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
" -------------------------------------------------------------
set fencs=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set synmaxcol=300
set lazyredraw
" Display
" -------------------------------------------------------------
set ruler
if dein#is_sourced('vim-fugitive')
  set statusline=%<%f\ %{fugitive#statusline()}%h%m%r%= " at left
elseif
  set statusline=%<%f\ %h%m%r%= " at left
endif
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B] " at right
set number
" Editing
" -------------------------------------------------------------
set autoindent smartindent
set smarttab
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start
" Language Type Settings
" -------------------------------------------------------------
augroup AutoShebang
  au BufNewFile *.sh call append(0, "#!/bin/sh")             | normal! G
  au BufNewFile *.py call append(0, "#!/usr/bin/env python") | normal! G
  au BufNewFile *.rb call append(0, "#!/usr/bin/env ruby") | normal! G
  au BufNewFile *.pl call append(0, "#!/usr/bin/env perl")   | normal! G
  au BufNewFile *.sed call append(0, "#!/bin/sed -f") | normal! G
  au BufWritePost * silent! %s/\s\+$//e
augroup END

augroup Indent
  au FileType go setlocal sw=4 ts=4 sts=4 noet
augroup END

augroup AutoExecutedCommands
  au BufWritePost *.go GoFmt
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Plugin Settings                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" NeoSnippet
" -------------------------------------------------------------
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
