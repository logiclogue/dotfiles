" VUNDLE stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'pangloss/vim-javascript'
Plugin 'sheerun/vim-polyglot'
Plugin 'othree/jsdoc-syntax.vim'
Plugin 'elzr/vim-json'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ternjs/tern_for_vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'flazz/vim-colorschemes'

call vundle#end()            " required


syntax enable
"filetype plugin indent on
filetype plugin on
set background=dark
set shell=/bin/bash
colorscheme base16-monokai

set number
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent

set linespace=7
set guioptions-=m
set guioptions-=T
set guioptions-=e

set guifont=Droid\ Sans\ Mono\ 13

inoremap { {<CR>}<Esc>ko
inoremap ( ()<Esc>i

" NERDTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden = 1

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|\.git'
let g:ctrlp_show_hidden = 1

" instant-markdown-vim
"let g:instant_markdown_slow = 1
