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
" see neobundle-options-autoload
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'https://github.com/kien/ctrlp.vim.git'
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet-snippets.git'
NeoBundle 'https://github.com/Shougo/neosnippet.git'
NeoBundle 'Shougo/vimproc.vim', {
      \   'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \   }
      \ }
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/tpope/vim-surround'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'vim-scripts/syntaxhaskell.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['haskell']
      \ }
      \ }
NeoBundle 'https://github.com/kchmck/vim-coffee-script.git'
NeoBundleLazy 'slimv.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['lisp']
      \ }
      \ }
NeoBundleLazy 'aharisu/vim_goshrepl', {
      \ 'autoload' : {
      \   'commands' : ['GoshREPL', 'GoshREPLWithBuf'],
      \   'filetypes' : ['scheme']
      \ },
      \ 'depends' : 'Shougo/vimproc.vim'
      \ }
NeoBundleLazy 'aharisu/vim-gdev', {
      \ 'autoload' : {
      \   'commands' : ['GoshREPL', 'GoshREPLWithBuf'],
      \   'filetypes' : ['scheme']
      \ },
      \ 'depends' : 'Shougo/vimproc.vim'
      \ }
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
set textwidth=0
hi Pmenu ctermbg=2
hi PmenuSel ctermbg=4
hi PmenuSbar ctermbg=2
hi PmenuThumb ctermfg=3
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
set wildmode=longest,full
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
  au BufNewFile *.sed call append(0, "#!/bin/sed -f") | normal! G
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

if neobundle#is_installed('neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete_min_syntax_length = 3
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'
  let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
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
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  " Enable heavy omni completion.
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif
inoremap <expr><TAB> pumvisible()? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" NeoSnippet
" -------------------------------------------------------------
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

let s:my_snippet = '~/.vim/mysnippet/'
let g:neosnippet#snippets_directory = s:my_snippet

" for rails
augroup railsdetect
  autocmd! BufEnter * if exists("b:rails_root") | call s:RailsSnippet() | endif
augroup END

function! s:RailsSnippet()
  let s:current_dir = expand("%:p:h")
  if (s:current_dir !~ "app/")
    return
  elseif (s:current_dir =~ "app/models")
    NeoSnippetSource ~/.vim/mysnippet/model.rails.snip
  elseif (s:current_dir =~ "app/controllers")
    NeoSnippetSource ~/.vim/mysnippet/controller.rails.snip
  elseif (s:current_dir =~ "app/views") || (expand("%:e") == "haml")
    NeoSnippetSource ~/.vim/mysnippet/view.rails.haml.snip
  elseif (s:current_dir =~ "app/views") || (expand("%:e") == "erb")
    NeoSnippetSource ~/.vim/mysnippet/view.rails.erb.snip
  elseif (s:current_dir =~ "app/helpers")
    NeoSnippetSource ~/.vim/mysnippet/helper.rails.snip
  elseif (s:current_dir =~ "app/assets")
    NeoSnippetSource ~/.vim/mysnippet/asset.rails.snip
  endif
endfunction

" NeoSnippet
" -------------------------------------------------------------
let g:quickrun_config = {}

let g:quickrun_config = {
      \   "_" : {
      \       "runner" : "vimproc",
      \       "runner/vimproc/updatetime" : 60
      \   },
      \}
let g:quickrun_config['tex'] = {
            \   'command' : 'latexmk',
            \   'outputter' : 'error',
            \   'outputter/error/error' : 'quickfix',
            \   'cmdopt': '-pdfdvi',
            \   'exec': ['%c %o %s']
            \ }

"" Latex setting
" -------------------------------------------------------------

"" Gosh
" -------------------------------------------------------------
vmap <CR> <Plug>(gosh_repl_send_block)
let s:hooks = neobundle#get_hooks('vim_goshrepl')
function! s:hooks.on_source(bundle)
  let g:gosh_buffer_direction = 'v'
  let g:gosh_buffer_width = 50
endfunction

"" Slimv for common lisp
" -------------------------------------------------------------
let g:paredit_mode = 1
let g:paredit_electric_return = 0
let g:slimv_disable_scheme = 1
let g:slimv_repl_split = 4
let g:slimv_repl_name = 'REPL'
let g:slimv_repl_simple_eval = 0
let g:slimv_lisp = '/usr/local/bin/clisp'
let g:slimv_impl = 'clisp'
let g:slimv_preferred = 'clisp'
let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"clisp $HOME/.vim/Bundle/slimv.vim/slime/start-swank.lisp\""'
let g:lisp_rainbow = 1
autocmd BufNewFile, BufRead *.asd set filetype=lisp

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

