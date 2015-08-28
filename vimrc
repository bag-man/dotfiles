""" Appearance

" syntax highlighting
syntax on

" line numbers
set number

" turn off text wrapping
set nowrap

" set color theme
colorscheme lucius
LuciusDarkLowContrast
hi StatusLine ctermfg=white
hi StatusLineNC ctermfg=black

" indenting
set cindent
set expandtab
set tabstop=2
set shiftwidth=2

" status line
set laststatus=2
set statusline=%F


""" Make configs

" run python
autocmd BufRead *.py set makeprg=clear;python2.7\ %
autocmd BufRead *.py set autowrite

" run node.js
autocmd BufRead *.js set makeprg=clear;node\ %
autocmd BufRead *.js set autowrite

" compile c code
autocmd FileType c set makeprg=clear;make\ test
autocmd FileType c set autowrite

" compile LaTeX
autocmd BufRead *.tex set makeprg=clear;pdflatex\ %
autocmd BufRead *.tex set autowrite

" run java
autocmd FileType java set makeprg=clear;javac\ \*.java;java\ %<
autocmd FileType java set autowrite


""" Function Keys

" set paste mode
set pastetoggle=<F2>

" insert new line
map <Cr> O<Esc>

" make F5 compile
map <F5> :make!<cr>

" Toggle Syntastic
map <F4> :SyntasticToggleMode<Cr>


""" Behaviour modifiers

" Strip trailing whitespace
autocmd BufWritePre *.js :%s/\s\+$//e

" set read aliases
set shellcmdflag+=i

" enable backspace in insert
set backspace=indent,eol,start

" change buffer
map <C-l> :bn<Cr>
map <C-h> :bp<Cr>

" close buffer
map D :Bclose<Cr>

" search settings
set ignorecase
set incsearch
set smartcase
set scrolloff=10

" spelling
setlocal spell spelllang=en
nmap ss :set spell!<CR>
set nospell


""" Auto runs

augroup vimrcEx
  autocmd!
  
  " Jump to last know position in file
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

augroup END

""" Plugins
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" :source %
" :PlugInstall

call plug#begin('~/.vim/plugged')
filetype plugin indent on

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
set mouse=a

" syntastic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:syntastic_tex_checkers = ['lacheck']

" ctrlp
Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
nnoremap <C-]> :CtrlPTag<cr>
" Speed up ctrlp
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
  \ }

Plug 'moll/vim-node'
Plug 'digitaltoad/vim-jade'
Plug 'rbgrouleff/bclose.vim'
call plug#end()
