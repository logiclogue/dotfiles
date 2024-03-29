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
Plugin 'shumphrey/fugitive-gitlab.vim'
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'sheerun/vim-polyglot'
Plugin 'othree/jsdoc-syntax.vim'
Plugin 'elzr/vim-json'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'raimondi/delimitmate'
Plugin 'vim-scripts/loremipsum'
" TypeScript syntax checking to be used with Syntastic
Plugin 'Quramy/tsuquyomi'

{{#if mobile}}
{{else}}
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ternjs/tern_for_vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'rust-lang/rust.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'reasonml-editor/vim-reason-plus'
" HTML/CSS helper
Plugin 'mattn/emmet-vim'
" Snippets
Plugin 'logiclogue/vim-snippets'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'derekelkins/agda-vim'
Plugin 'ledger/vim-ledger'
{{/if}}

call vundle#end()


syntax enable
filetype plugin on
set background=dark
{{#if mobile}}
set shell=bash
{{else}}
set shell=/bin/bash
{{/if}}
colorscheme molokai

set number
set relativenumber
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent
" Stop markdown files from folding underneath every header
set nofoldenable

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
let g:syntastic_rust_checkers = ['rustc']

let g:syntastic_ocaml_camlp4r = 1

let g:syntastic_typescript_checkers = ['tsuquyomi']

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files'],
		\ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
	\ 'fallback': 'find %s -type f'
	\ }
let g:ctrlp_extensions = ['line']

" Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.md setlocal spell

" Ledger
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

" Snippets
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" Custom
" Task done
map <C-J>d $V?- dGpG:put = strftime('%c')^v$hS)kJ$V?- gqgg:nohl

" tsuquyomi (TypeScript)
nmap <Space><C-]> <Plug>(TsuquyomiReferences)

let g:tsuquyomi_disable_quickfix = 1

" Fugitive
let g:fugitive_gitlab_domains = ['https://gitlab.com']
