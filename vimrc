""" Auto Installation

  " Install plugins
  if empty(glob("~/.vim/autoload/plug.vim"))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    auto VimEnter * PlugInstall
  endif

  " Install fzf and rg
  if !empty(glob("~/.fzf/bin/fzf"))
    if empty(glob("~/.fzf/bin/rg"))
      silent !curl -fLo /tmp/rg.tar.gz
            \ https://github.com/BurntSushi/ripgrep/releases/download/0.4.0/ripgrep-0.4.0-x86_64-unknown-linux-musl.tar.gz
      silent !tar xzvf /tmp/rg.tar.gz --directory /tmp
      silent !cp /tmp/ripgrep-0.4.0-x86_64-unknown-linux-musl/rg ~/.fzf/bin/rg
    endif
  endif
  
  " Install theme
  if empty(glob("~/.vim/colors/lucius.vim"))
    silent !curl -fLo ~/.vim/colors/lucius.vim --create-dirs
          \ https://raw.githubusercontent.com/bag-man/dotfiles/master/lucius.vim
  endif
  
  " Create undo directory
  if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
  endif

""" Appearance

  " Syntax and lines
  syntax on
  set number relativenumber
  set nowrap

  " Theme
  colorscheme lucius
  LuciusDarkLowContrast

  " Indentation
  set cindent
  set expandtab
  set shiftwidth=2
  set softtabstop=2

  " Status
  set laststatus=2
  set statusline=%F
  set wildmenu
  set showcmd

  " Highlight 100's
  match Delimiter /\d\ze\%(\d\d\%(\d\{3}\)*\)\>/

""" Key modifiers

  " Find word in project
  map <F3> :F <C-r><C-w><Cr>

  " Typescript langauge tools
  map <F5> :echo tsuquyomi#hint()<cr>
  map <F6> :Fixmyjs<CR>
  map <F7> :TsuImport<CR>:w<cr>:Fixmyjs<cr>
  map <F8> :TsuRenameSymbol<CR>

  " Generate UUID 
  imap <C-u> <esc>:exe 'norm a' . system('/usr/bin/newuuid')<cr>
  map <C-u> :exe 'norm a' . system('/usr/bin/newuuid')<cr>

  " Sensible shortcuts for movement
  map <Cr> O<Esc>j
  map Y y$
  map H ^
  map L $
  map £ g_   
  map M J

  " Clear search
  map <BS> :noh<CR>

  " Jump to next error
  nmap <silent> <C-e> <Plug>(ale_next_wrap)
  
  " Paste over quotes and brakets
  map "p vi"p
  map 'p vi'p
  map (p vi(p
  map )p vi)p

  " Fix typo
  map q: :q

  " Center next item
  map n nzz

  " Write as sudo
  cmap w!! w !sudo tee > /dev/null %
  
  " Toggle comment block
  map <C-s> magcii`a

  " View fzf buffers
  map <C-b> :Buffers<cr>

  " Tab navigation
  nnoremap <tab> :tabnext<CR>
  nnoremap <s-tab> :tabprev<CR>
  nnoremap <C-t> :tabnew<CR>
  inoremap <C-t> <Esc>:tabnew<CR>i
  noremap gt <C-w>gf
  noremap gs <C-w>vgf
  noremap gi <C-w>f
  noremap <C-]> <C-w><C-]><C-w>T
  map J :tabprev<CR>
  map K :tabnext<CR>

  " Autocomplete navigation
  inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
  inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
  inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))
  imap <Tab> <C-X><C-F>
  imap <s-Tab> <C-X><C-P>

  " External item maps
  map cp :CopyRelativePath<Cr>
  map gp :Sprunge<cr>
  map go :Google<cr>
  map gl :Gblame<Cr>
  map gb :Gbrowse<Cr>
  map ch :Gread<Cr>

  " Open fold
  nnoremap <Space> za

""" Behaviour modifiers

  set undofile
  set undodir=~/.vim/undodir
  set clipboard=unnamed
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  set foldmethod=marker
  set backspace=indent,eol,start
  set wildmode=longest,list,full
  set completeopt=longest,menuone
  set mouse=
  set lazyredraw

  " Strip whitespace
  autocmd BufWritePre *.ts,*.erb,*.scss,*.rb,*.js,*.c,*.py,*.php :%s/\s\+$//e

  " Auto load vimrc on save
  au BufWritePost ~/.vimrc source %

  " Maintain cwd
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

  " Search settings
  set ignorecase
  set incsearch
  set smartcase
  set scrolloff=10
  set hlsearch!

  " Spelling
  setlocal spell spelllang=en
  nmap ss :set spell!<CR>
  set nospell
  autocmd FileType gitcommit setlocal spell

  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

""" Plugins
    
  " NERDTree
  map <C-n> :NERDTreeTabsToggle<CR>
  map <C-f> :NERDTreeFind<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  let NERDTreeChDirMode=2
  let g:NERDTreeDirArrowExpandable = '├'
  let g:NERDTreeDirArrowCollapsible = '└'
  let g:NERDTreeMapActivateNode = '<tab>'

  " Nuake
  tmap <C-q> <C-w>N
  nnoremap + <C-w>3+
  nnoremap _ <C-w>3-
  nnoremap <C-\> :Nuake<CR>
  inoremap <C-\> <C-\><C-n>:Nuake<CR>
  tnoremap <C-\> <C-\><C-n>:Nuake<CR>
  let g:nuake_position = 2
  let g:nuake_size = 0.2
  let g:nuake_per_tab = 1

  " Ale
  let g:ale_sign_error = ' '
  let g:ale_sign_warning = ' '
  let g:ale_sign_column_always = 1
  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'typescript': ['tsserver', 'tslint'] ,
  \}
  let g:ale_pattern_options = {
  \   '.*\.d.ts$': {'ale_enabled': 0},
  \}
  highlight ALEError ctermbg=none cterm=underline,bold
  highlight ALEWarning ctermbg=none cterm=underline,bold
  let g:ale_type_map = {'tslint': {'ES': 'WS', 'E': 'W'}}
 
  " Typescript completion
  let g:tsuquyomi_completion_detail = 1
  let g:tsuquyomi_disable_quickfix = 1
  let g:tsuquyomi_definition_split = 2

  " argwrap
  nnoremap <silent> <Bslash>a :ArgWrap<CR>
  let g:argwrap_padded_braces = '{'

  " fzf config
  nmap <C-p> :Files<cr>
  imap <c-x><c-l> <plug>(fzf-complete-line)

  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-i': 'split',
    \ 'ctrl-s': 'vsplit' }
  let g:fzf_layout = { 'down': '~20%' }

  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{ts,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst}"
    \ -g "!{.config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist}/*" '

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

  " JS lint fix
  let g:fixmyjs_engine = 'tslint'

  " long-roll
  let g:lognroll_js_console = 'log'
  let g:lognroll_js_actions = [ 'info', 'warn', 'error', 'debug' ]

  " vim-move
  let g:move_key_modifier = 'C'

  " rainbow brackets
  if !empty(glob("~/.vim/plugged/rainbow_parentheses.vim/autoload/rainbow_parentheses.vim"))
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
  endif 

  " Highlight jump points
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""" Plugins 

  call plug#begin('~/.vim/plugged')
  filetype plugin indent on

  " Features
  Plug 'w0rp/ale'                                                      " Async linting
  Plug 'scrooloose/nerdtree'                                           " File tree browser
  Plug 'Xuyuanp/nerdtree-git-plugin'                                   " Git for NerdTree
  Plug 'jistr/vim-nerdtree-tabs'                                       " NerdTree independent of tabs
  Plug 'jreybert/vimagit'                                              " Interactive git staging
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }    " Install fzf for user
  Plug 'junegunn/fzf.vim'                                              " Fzf vim plugin
  Plug 'bag-man/nuake'                                                 " Quake term

  " Small utilities
  Plug 'bag-man/copypath.vim'                                          " copy path of file
  Plug 'can3p/incbool.vim'                                             " Toggle true/false
  Plug 'kopischke/vim-fetch'                                           " Use line numbers in file paths
  Plug 'matze/vim-move'                                                " Move lines up and down
  Plug 'chilicuil/vim-sprunge'                                         " Paste selection to sprunge
  Plug 'FooSoft/vim-argwrap'                                           " Wrap arguments to multi-lines
  Plug 'szw/vim-g'                                                     " Google from Vim
  Plug 'google/vim-searchindex'                                        " Number of search results
  Plug 'glippi/lognroll-vim'                                           " Auto console.log vars

  " Languages
  Plug 'moll/vim-node'                                                 " Syntax for node.js
  Plug 'wavded/vim-stylus'                                             " Stylus for stylus
  Plug 'digitaltoad/vim-pug'                                           " Syntax for pug
  Plug 'josudoey/vim-eslint-fix'                                       " Eslint fixamajig
  Plug 'leafgarland/typescript-vim'                                    " TypeScript Syntax
  Plug 'Quramy/tsuquyomi'                                              " TypeScript autocompletion
  Plug 'ruanyl/vim-fixmyjs'                                            " TSlint runner
  Plug 'jparise/vim-graphql'                                           " Syntax for graphql

  " tpope
  Plug 'tpope/vim-surround'                                            " Operate on surrounding 
  Plug 'tpope/vim-speeddating'                                         " Increment dates
  Plug 'tpope/vim-repeat'                                              " Repeat plugins
  Plug 'tpope/vim-commentary'                                          " Comment out blocks
  Plug 'tpope/vim-fugitive'                                            " Git integration
  Plug 'tpope/vim-abolish'                                             " Flexible search
  Plug 'tpope/vim-jdaddy'                                              " JSON text object
  Plug 'tpope/vim-rhubarb'                                             " Github browse

  " Appearance
  Plug 'mkitt/tabline.vim'                                             " Cleaner tabs
  Plug 'chrisbra/Colorizer'                                            " Show hex codes as colours
  Plug 'kien/rainbow_parentheses.vim'                                  " Colour matched brackets
  Plug 'unblevable/quick-scope'                                        " Highlight jump characters

  " Text objects
  Plug 'wellle/targets.vim'                                            " Additional text objects                   
  Plug 'michaeljsmith/vim-indent-object'                               " Indented text object
  Plug 'kana/vim-textobj-user'                                         " Add additional text objects
  Plug 'jceb/vim-textobj-uri'                                          " URL objects
  Plug 'glts/vim-textobj-comment'                                      " Comment text objects
  Plug 'kana/vim-textobj-function'                                     " Add function based text objects
  Plug 'bag-man/vim-textobj-keyvalue'                                  " Key value object
  Plug 'thinca/vim-textobj-function-javascript'                        " Add JS function object
  Plug 'reedes/vim-textobj-sentence'                                   " Sentence object
  Plug 'coderifous/textobj-word-column.vim'                            " Word columns

  call plug#end()
