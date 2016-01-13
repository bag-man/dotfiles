" Install Vim-Plug & Plugins
if empty(glob("~/.vim/autoload/plug.vim"))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  auto VimEnter * PlugInstall
  silent !cd .vim/plugged/ctrlp-cmatcher; sh install.sh; cd -
  silent !cd .vim/plugged/vimproc.vim/; make; cd -
endif

" Install colorscheme
if empty(glob("~/.vim/colors/lucius.vim"))
  silent !curl -fLo ~/.vim/colors/lucius.vim --create-dirs
        \ https://raw.githubusercontent.com/bag-man/dotfiles/master/lucius.vim
endif

""" Appearance

" syntax highlighting
syntax on

" line numbers
set number

" turn off text wrapping
set nowrap

" set color theme
" https://github.com/bag-man/xDotfiles/blob/master/lucius.vim
colorscheme lucius
LuciusDarkLowContrast

" " indenting
set cindent
set expandtab
set tabstop=2
set shiftwidth=2

" status line
set laststatus=2
set statusline=%F
set wildmenu


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


""" Function Keys

" set paste mode
set pastetoggle=<F2>

" Find word under cusor
map <F3> :<C-u>execute 'Unite grep:.::' .expand("<cword>"). ' -default-action=below'<Cr>

" Toggle Syntastic
map <F4> :SyntasticToggleMode<Cr>

" make F5 compile
map <F5> :make!<cr>

" Toggle highlight
map <F6> :set hlsearch!<CR>


""" Behaviour modifiers

" make enter work in normal
map <Cr> O<Esc>

" stop the command popup
map q: :q

" Share clipboard with system
set clipboard=unnamed

" Strip trailing whitespace
autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.php :%s/\s\+$//e

" enable backspace in insert
set backspace=indent,eol,start

" save as sudo
cmap w!! w !sudo tee > /dev/null %

" change buffer
map <C-l> :bn<Cr>
map <C-h> :bp<Cr>

" tab navigation 
nnoremap <tab> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" copy path
map cp :CopyRelativePath<Cr>

" change dir for file completion
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" Use j / k / tab for autocomplete
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))

" auto complete file paths
imap <Tab> <C-X><C-F>

" fugitive maps
map gl :Gblame<Cr>
map gb :Gbrowse!<Cr>

" close buffer
cmap bc :Bclose<Cr>

" open file in new tab
noremap gt <C-w>gf

" open ctag in new tab
noremap <C-]> <C-w><C-]><C-w>T

" set space to toggle folds
nnoremap <Space> za

" set foldmarker
set foldmethod=marker

" search settings
set ignorecase
set incsearch
set smartcase
set scrolloff=10
set hlsearch!

" spelling
setlocal spell spelllang=en
nmap ss :set spell!<CR>
set nospell
autocmd FileType markdown setlocal spell

" Jump to last know position in file
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END


""" Plugins
"
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
map <C-n> :NERDTreeTabsToggle<CR>
map <C-f> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '├'
let g:NERDTreeDirArrowCollapsible = '└'
let g:NERDTreeMapActivateNode = '<tab>'
set mouse=a

" syntastic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%{fugitive#statusline()}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=5
if filereadable(".eslintrc")
  let g:syntastic_javascript_checkers = ['eslint']
elseif filereadable(".jshintrc") || filereadable(".jscsrc")
  let g:syntastic_javascript_checkers = ['jshint', 'jscs']
endif
let g:syntastic_tex_checkers = ['lacheck']
let g:syntastic_jade_checkers = ['jade_lint']
let g:colorizer_auto_filetype='css,html,stylus,jade,js,php'
let g:colorizer_colornames = 0

" Unite
let g:unite_source_grep_default_opts = '-srnw --binary-files=without-match --exclude-dir={build,vendor,node_modules,.git} --include=*.{jade,js,styl,php,json,config,html} --exclude={*.min.js,tags}'
command! -nargs=1 F execute 'Unite grep:.::' .<q-args>. ' -default-action=below'

" ctrlp
Plug 'kien/ctrlp.vim'
map <C-o> :CtrlPTag<Cr>
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" vim-move
let g:move_key_modifier = 'C'

Plug 'moll/vim-node'
Plug 'digitaltoad/vim-jade'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'mkitt/tabline.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'justinmk/vim-gtfo'
Plug 'bag-man/copypath.vim'
Plug 'tpope/vim-fugitive'
Plug 'can3p/incbool.vim'
Plug 'chrisbra/Colorizer'
Plug 'triglav/vim-visual-increment'
Plug 'kopischke/vim-fetch'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim' " make 
Plug 'matze/vim-move'
Plug 'JazzCore/ctrlp-cmatcher' " install.sh
Plug 'tpope/vim-sleuth'
Plug 'jreybert/vimagit'
call plug#end()
