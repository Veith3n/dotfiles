""" Base config 
set clipboard=unnamed
set number relativenumber
set nocompatible " disables revert support for vi
set ignorecase " case unsensitive search
" set mouse=a " enables mouse

syntax enable " enables syntax highlight

" Search down into subfolders 
" Provides tab-completion forall file-releted tasks
set path+=**

let mapleader = "\<Space>"

" enable fuzzy search
set rtp+=/usr/local/opt/fzf

" Display allmatching files with autocomplete 
set wildmenu


""" Plugins 
filetype plugin on
runtime macros/matchit.vim " enables block matching for different languages

""" Vim plug instalation if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
""" Vim plug instalation if not present

call plug#begin('~/.vim/plugged')
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'zivyangll/git-blame.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tomtom/tcomment_vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
call plug#end()

""" Colors
colorscheme nice_diff " color scheme for nicer highlithing in merge confilicts
colorscheme onedark " color scheme for nicer highlithing in merge confilicts

" Plugin config

" Easy motion
let g:EasyMotion_smartcase = 1
nmap w <Plug>(easymotion-w)
nmap s <Plug>(easymotion-s2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

""" Commands
" Delete all Git conflict markers
function! RemoveConflictMarkers() range
  echom a:firstline.'-'.a:lastline
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction

command! -range=% RemoveConflictMarkers <line1>,<line2>call RemoveConflictMarkers() "-range=% default is whole file

" remap for quick shortcut by gitblame
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>
