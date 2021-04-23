" ------------------------------------------------------------
" 1. Vundle
" ------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" ------------------------------------------------------------
" 2. General
" ------------------------------------------------------------

syntax on
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
set laststatus=2
set hls
set incsearch
set ignorecase
set smartcase
set magic
set showmatch
set autoread
set backspace=2
"0 same as “:set backspace=” (Vi compatible)
"1 same as “:set backspace=indent,eol”
"2 same as “:set backspace=indent,eol,start”


" customize shortcuts
"
let mapleader=";"
map <Leader>a ggVG
nmap <leader>ct <esc>:retab<cr>
nnoremap <F2> :set list! list?<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>c :cclose<bar>lclose<cr>
nnoremap <leader>hh :%!xxd<CR>
nnoremap <leader>hr :%!xxd<CR>
nnoremap <leader>sp :StripWhitespace<CR>


" customize commands
"
command Todo Ack! 'TODO|FIXME|XXX'


" customize autocmd
"
autocmd BufWrite *.sh :set ff=unix


" customize functions
"
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'go'
        exec "!time go run %"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

" auto upload skeleton.c file when create a new .c file
augroup Skeleton
    au BufNewFile *.py 0r ~/.vim/skeleton/basic.py
    au BufNewFile *.c 0r ~/.vim/skeleton/basic.c
    au BufNewFile *.cpp 0r ~/.vim/skeleton/basic.cpp
augroup end


" themes
"
colo desert


" file encoding
"
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set fileencoding=utf-8


" gui font
"
if has("unix")
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
elseif has("win32") || has("win64")
    set guifont=DejaVu_Sans_Mono:h12
elseif has("gui_macvim")
    set guifont=DejaVu_Sans_Mono_for_Powerline:h12
end


" clipboard
"
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Allow saving of files as sudo when I forgot to start vim using sudo.
"
cmap w!! w !sudo tee > /dev/null %
