""" Base config 
set clipboard=unnamed
set number relativenumber
set nocompatible " disables revert support for vi
set ignorecase " case unsensitive search
" set mouse=a " enables mouse
set encoding=UTF-8

syntax enable " enables syntax highlight

" Search down into subfolders 
" Provides tab-completion forall file-releted tasks
set path+=**

let mapleader = "\<Space>"

" enable fuzzy search
set rtp+=/usr/local/opt/fzf

" Display allmatching files with autocomplete 
set wildmenu
set iskeyword+=- " treats foo-bar as one word

""" Plugins 
" Polyglot
let g:polyglot_disabled = []

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
" Utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'tomtom/tcomment_vim'
Plug 'zivyangll/git-blame.vim'
Plug 'vim-airline/vim-airline'

Plug 'nicwest/vim-camelsnek' " convert to snake_case, camelCase

" Nerd tree config
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Fzf (grep on files)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Linter
Plug 'dense-analysis/ale'

" Syntax highlighting/colours
Plug 'sheerun/vim-polyglot'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'


" Ruby
Plug 'ngmy/vim-rubocop'
Plug 'jgdavey/vim-blockle'
call plug#end()

""" Colors
" colorscheme nice_diff " color scheme for nicer highlithing in merge confilicts
colorscheme onedark " color scheme for nicer highlithing in merge confilicts

" Plugin config

" vim-camelsnek
map <Leader>cs :Snek <CR>
map <Leader>cc :Camel <CR>

" Ale 
let g:ale_linters = { 'ruby': ['rubocop', 'ruby'], 'javascript': ['eslint'], '*': ['trim_whitespace', 'remove_trailing_lines'] }

let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = { 'ruby': ['rubocop'], 'javascript': ['prettier', 'eslint'] } 
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '

let g:ale_completion_enabled = 1
" Easy motion
let g:EasyMotion_smartcase = 1
nmap w <Plug>(easymotion-w)
nmap s <Plug>(easymotion-s2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Airline
let g:airline_section_d='%{strftime("%c")}'
let g:airline_theme='onedark'

function! Foo()
	" silent !clear

	let file_name = expand('%:p')
	" echo file_name
	" let file_name = %
	 echom system('bundle exec rubocop -a &' )
	 " echom system('echo %' )
	 redraw!
endfunction

""" Commands
" Scripts to run after action
" autocmd BufWritePost *.rb :silent! !bundle exec rubocop -a % | :redraw!
" autocmd BufWritePost *.rb :silent !bundle exec rubocop -a % | execute ':redraw!'
autocmd BufWritePost *.rb :call Foo()

" Delete all Git conflict markers
function! RemoveConflictMarkers() range
  echom a:firstline.'-'.a:lastline
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction

command! -range=% RemoveConflictMarkers <line1>,<line2>call RemoveConflictMarkers() "-range=% default is whole file

" GitBlame
" " Define a function to check if gitblame should run
function! ShouldRunGitBlame()
  " Check if the buffer is a normal, modifiable file
  if &buftype is# "" && &modifiable
    " Check if the buffer is NOT a NERDTree buffer
    if !exists('b:NERDTree')
      " Check if we're in a git repository
      let l:git_dir = system('git rev-parse --git-dir 2>/dev/null')
      if v:shell_error == 0
        return 1
      endif
    endif
  endif
  return 0
endfunction
"
" Show git blame automatically on cursor movement, but only in normal, modifiable file buffers
autocmd CursorMoved * if ShouldRunGitBlame() | call gitblame#echo() | endif
autocmd CursorMovedI * if ShouldRunGitBlame() | call gitblame#echo() | endif

" remap for quick shortcut by gitblame
nnoremap <Leader>g :<C-u>call gitblame#echo()<CR>

" Move text up and down
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-k> :m '<-2<CR>gv

" Yank to local clipboard in visual mode
vnoremap <leader>y "*y

" Yank to local clipboard whole file in normal mode
nnoremap <leader>yy :%y+<CR>

" Set light color scheme
nnoremap <A-S-l> :set background=light<CR>:colorscheme solarized<CR>

" Set dark color scheme
nnoremap <A-S-d> :set background=dark<CR>:colorscheme onedark<CR>

" NerdTree
" Toggle
nnoremap <leader>e :NERDTreeToggle<CR>
" Switch focus to NERDTree with Ctrl+h
nnoremap <C-h> :wincmd h<CR>
" Switch focus to the file buffer with Ctrl+l
nnoremap <C-l> :wincmd l<CR>
" Add file directly in NERDTree with 'a'
" autocmd FileType nerdtree nnoremap <buffer> a :NERDTreeCWDAddFile<CR>

" fzf.vim mappings
" Search text from files in the current dir
nnoremap <leader>f :RG<CR>
" Search files in the current dir
nnoremap <leader>p :Files<CR>

" fix highlighting issue
set re=0

" Automatically setting vim colorscheme based on the system settings
" Function to get the current system's appearance
function! s:GetAppearance()
  if has('mac')
    return s:GetMacAppearance()
  elseif has('win32')
    return s:GetWindowsAppearance()
  elseif has('unix')
    return s:GetLinuxAppearance()
  else
    return "light"
  endif
endfunction

" macOS: Detect Dark Mode
function! s:GetMacAppearance()
  let result = system("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if result =~? "Dark"
    return "dark"
  else
    return "light"
  endif
endfunction

" Windows: Detect Dark Mode
function! s:GetWindowsAppearance()
  let result = system('powershell -command "(Get-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize -Name AppsUseLightTheme).AppsUseLightTheme"')
  if result =~? "0"
    return "dark"
  else
    return "light"
  endif
endfunction

" Linux (GNOME): Detect Dark Mode
function! s:GetLinuxAppearance()
  let result = system('gsettings get org.gnome.desktop.interface gtk-theme')
  if result =~? "dark"
    return "dark"
  else
    return "light"
  endif
endfunction

let s:light_colorscheme = "solarized"
let s:dark_colorscheme  = "onedark"

" Set colorscheme on startup and focus gained
augroup ColorschemeSwitch
  autocmd!
  autocmd VimEnter * call s:SetColorScheme()
  autocmd FocusGained * call s:SetColorScheme()
augroup END

function! s:SetColorScheme()
  let appearance = s:GetAppearance()
  if appearance == "dark"
    execute "set background=dark"
    execute "colorscheme " . s:dark_colorscheme
  else
    execute "set background=light"
    execute "colorscheme " . s:light_colorscheme
  endif
endfunction

