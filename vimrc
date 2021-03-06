" Gasol Wu <gasol.wu@gmail.com>
" https://github.com/gasol/vimrc

set nocompatible

set t_Co=256
set history=50
set number
set ruler

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,gb2312,sjis

set modeline
set background=dark
set backspace=indent,eol,start
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set incsearch
set hlsearch

set tabstop=4
set expandtab
set shiftwidth=4
set ignorecase

syntax on
filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

set laststatus=2

Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-surround'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-fugitive'
Plugin 'sukima/xmledit'
Plugin 'Gasol/vim-scripts'
Plugin 'Gasol/vim-php'
set wildignore+=*/vim-php/doc/*
Plugin 'fs111/pydoc.vim'
Plugin 'Efficient-python-folding'
Plugin 'tpope/vim-markdown'
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1
Plugin 'Lokaltog/vim-easymotion'
Plugin 'flazz/vim-colorschemes'

" vim-snipmate dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'bling/vim-airline'

" Tagbar
Plugin 'majutsushi/tagbar'
nmap <F10> :TagbarToggle<CR>

" C++ Autocomplete
Plugin 'valloric/YouCompleteMe'
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_auto_trigger = 1
let g:ycm_error_symbol = '!>'
let g:ycm_warning_symbol = '#>'
let g:ycm_complete_in_comments = 1
let g:ycm_add_preview_to_completeopt = 1 "try but maybe set to 0 again
let g:ycm_confirm_extra_conf = 0

filetype plugin indent on

" python syntax highlight
let python_highlight_all = 1
let python_sync_slow = 1

" autocomplete
autocmd FileType py setl omnifunc=pythoncomplete
autocmd FileType python syntax keyword pythonDecorator True None False self
autocmd FileType python setl sw=4 ts=4 sts=4 tw=120 sta et nosi
autocmd FileType css setl omnifunc=csscomplete
autocmd FileType perl setl sw=4 ts=4 et
autocmd FileType c setl sw=4 ts=4 et
autocmd BufNewFile,BufRead *.go setl filetype=go sw=4 ts=4
autocmd BufNewFile,BufRead *.mako setl filetype=mako
autocmd BufNewFile,BufRead *.gradle setl filetype=groovy sw=4 ts=4 et
autocmd BufNewFile,BufRead *.thrift if &ft == 'conf' | setl filetype=thrift
autocmd BufNewFile,BufRead *.json setl ft=javascript sw=4 ts=4 et
autocmd BufNewFile,BufRead *.md setl filetype=markdown

map th :tabprev<CR>
map tl :tabnext<CR>
nnoremap <silent> <F12> :TlistToggle<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" vim-indent-guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

" NerdTree
let NERDTreeIgnore=['\~$', '\.lo$', '\.la$', '\.pyc']
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Toggle nerdtree with F10
map <F8> :NERDTreeToggle<CR>

" Current file in nerdtree
map <F9> :NERDTreeFind<CR>

" Auto Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

let Tlist_Use_Right_Window = 1
let os = substitute(system('uname'), "\n", "", "")
if os == "FreeBSD"
	let Tlist_Ctags_Cmd = "/usr/local/bin/exctags"
endif

let g:vundle_default_git_proto = 'git'

" Gitgutter
let g:gitgutter_enabled = 1
highlight clear SignColumn

if filereadable($HOME.'/.vimrc_local')
	source $HOME/.vimrc_local
endif

"key to insert mode with paste using F2 key
map <F2> :set paste<CR>i
" Leave paste mode on exit
au InsertLeave * set nopaste

comm! W exec 'w !sudo tee % > /dev/null' | e!
