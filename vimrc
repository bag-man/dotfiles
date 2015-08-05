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

" indenting
set cindent
set expandtab
set tabstop=2
set shiftwidth=2


""" Make configs

" check perl code
autocmd FileType perl set makeprg=clear;perl\ %
autocmd FileType perl set autowrite

" run python
autocmd BufRead *.py set makeprg=clear;python2.7\ %
autocmd BufRead *.py set autowrite

" run go
autocmd BufRead *.go set makeprg=clear;go\ run\ %
autocmd BufRead *.go set autowrite

" run node.js
autocmd BufRead *.js set makeprg=clear;node\ %
autocmd BufRead *.js set autowrite

" compile c code
autocmd FileType c set makeprg=clear;make\ test
autocmd FileType c set autowrite

" compile rust code
autocmd BufRead *.rs set makeprg=clear;rustc\ %\;./%<
autocmd BufRead *.rs set autowrite

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

" push to git
" map <F6> :w<Cr>:!push<Cr>

" run JUnit tests
" map <F7> :w<Cr>:!junit %<<Cr>

" run mocha tests
map <F6> :w<Cr>:!clear;istanbul<Cr>

map <C-w><C-f> :vertical wincmd f<CR>

""" Behaviour modifiers

" Strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" set read aliases
set shellcmdflag+=i

" disable arrow keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" I've learned now, and it makes it easier to use NERDTree with the enter key

" enable backspace in insert
set backspace=indent,eol,start

" change buffer
map <C-l> :bn<Cr>
map <C-h> :bp<Cr>

" search settings
set ignorecase
set incsearch
set smartcase
set scrolloff=10

" ignore class files
set wildignore=*.class

" spelling
setlocal spell spelllang=en
nmap ss :set spell!<CR>
set nospell


""" Plugins

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
set mouse=a

" syntastic
execute pathogen#infect()
filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:syntastic_tex_checkers = ['lacheck']
