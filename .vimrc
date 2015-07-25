"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          NeoBundle                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN
" -------------------------------------------------------------
filetype off
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" Plugins
" -------------------------------------------------------------
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'kien/ctrlp.vim.git'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-rails'
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet-snippets.git'
NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/vimproc.vim', {
      \   'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \   }
      \ }
" END
" -------------------------------------------------------------
call neobundle#end()
filetype plugin on
filetype indent on
NeoBundleCheck
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           General                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
" -------------------------------------------------------------
set enc=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set shell=zsh
set synmaxcol=300
set lazyredraw
set ttyfast

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
set statusline=%<%f\ %{fugitive#statusline()}%h%m%r%= " at left
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B] " at right
set showcmd
set laststatus=2
set shortmess+=I
set vb t_vb=
set novisualbell
set incsearch
set hlsearch
set number
set matchpairs& matchpairs+=<:>
set showmatch
set matchtime=3
set wrap
set cursorline
set textwidth=0
hi Pmenu ctermbg=2
hi PmenuSel ctermbg=4
hi PmenuSbar ctermbg=2
hi PmenuThumb ctermfg=3
hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg=Red ctermbg=Yellow
hi Title ctermfg=LightBlue ctermbg=Magenta

" Editing
" -------------------------------------------------------------
set autoindent smartindent
set smarttab
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start

" Fold setting
set foldmethod=syntax
" let perl_fold=1
set foldlevel=100

" File
" -------------------------------------------------------------
set wildmode=list,full
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  set undofile
endif
noremap <Space>. :<C-u>edit $MYVIMRC<Enter>
noremap <Space>s. :<C-u>source $MYVIMRC<Enter>

" Auto Exexuted Commands
" -------------------------------------------------------------
augroup Autocmds
  au BufNewFile *.sh call append(0, "#!/bin/sh")             | normal! G
  au BufNewFile *.py call append(0, "#!/usr/bin/env python") | normal! G
  au BufNewFile *.rb call append(0, "#!/usr/bin/env ruby") | normal! G
  au BufNewFile *.pl call append(0, "#!/usr/bin/env perl")   | normal! G
  au BufNewFile *.sed call append(0, "#!/bin/sed -f") | normal! G
  au BufWritePost * silent! %s/\s\+$//e
augroup END

" Other
" -------------------------------------------------------------
set backupdir=/tmp/
noremap tp :set paste!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Plugin Settings                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
" -------------------------------------------------------------
com! Gb Gblame
com! -nargs=+ Gg Git grep <args>

"" CtrlP
" -------------------------------------------------------------
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.jpeg,*.png
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn)$',
  \ }
let g:ctrlp_max_depth = 5

" Completion
" -------------------------------------------------------------
set history=700
set wildmenu

if neobundle#is_installed('neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#min_keyword_length = 3
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'
	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
	endif
	if !exists('g:neocomplete#force_omni_input_patterns')
	  let g:neocomplete#force_omni_input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.php =
	\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
	let g:neocomplete#sources#omni#input_patterns.c =
	\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
	let g:neocomplete#sources#omni#input_patterns.cpp =
	\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
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
  let g:neocomplcache_min_syntax_length = 3
  " Enable heavy omni completion.
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" NeoSnippet
" -------------------------------------------------------------
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" NerdTree
" -------------------------------------------------------------
nnoremap <silent><C-e> :NERDTreeToggle<CR>
