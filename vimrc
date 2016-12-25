" ==========================
" 1. oh_my_zsh
" ==========================

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-scripts repos
Plugin 'taglist.vim'
Plugin 'winmanager'
Plugin 'minibufexpl.vim'
Plugin 'a.vim'
Plugin 'The-NERD-Commenter'

" original repos on github
Plugin 'scrooloose/nerdtree'
Plugin 'mhinz/vim-startify'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'acusp/AuthorInfo'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ==========================
" 2. formate control
" ==========================

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nu
set backup
set backupext=.bak
set backupdir=~/backup
set scrolloff=3
syntax on

" themes
colo desert

" file encoding
"set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1

" font
if has("gui_gtk2")
set guifont=DejaVu\ Sans\ Mono\ 12
elseif has("gui_macvim")
set guifont=DejaVu_Sans_Mono:h12
elseif has("gui_win32")
set guifont=DejaVu_Sans_Mono:h12
end

" ==========================
" 3. authorinfo
" ==========================

let g:vimrc_author='acusp'
let g:vimrc_email='acusp.xu@gmail.com'
let g:vimrc_homepage='acusp.info'

nmap <F4> :AuthorInfoDetect<cr>

" ==========================
" 4. plugin config
" ==========================

" ctags
set tags=tags;
set autochdir

" cscope
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set csverb
    set cspc=3
    "add any database in current dir
    if filereadable("cscope.out")
        cs add cscope.out
    "else search cscope.out elsewhere
    else
        let cscope_file=findfile("cscope.out",".;")
        let cscope_pre=matchstr(cscope_file,".*/")
        if !empty(cscope_file) && filereadable(cscope_file)
            exe "cs add" cscope_file cscope_pre
        endif
    endif
endif

" TagList
nnoremap <silent> <F8> :TlistToggle<CR>

" NERDTree
map <F9> :NERDTreeToggle<CR>

" A
nnoremap <silent> <F12> :A<CR>
