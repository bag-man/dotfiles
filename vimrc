""" Auto Installation

  if empty(glob("~/.vim/autoload/plug.vim"))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    auto VimEnter * PlugInstall
  endif

  if !empty(glob("~/.fzf/bin/fzf"))
    if empty(glob("~/.fzf/bin/rg"))
      silent !curl -fLo /tmp/rg.tar.gz
            \ https://github.com/BurntSushi/ripgrep/releases/download/0.4.0/ripgrep-0.4.0-x86_64-unknown-linux-musl.tar.gz
      silent !tar xzvf /tmp/rg.tar.gz --directory /tmp
      silent !cp /tmp/ripgrep-0.4.0-x86_64-unknown-linux-musl/rg ~/.fzf/bin/rg
    endif
  endif
  
  if empty(glob("~/.vim/colors/lucius.vim"))
    silent !curl -fLo ~/.vim/colors/lucius.vim --create-dirs
          \ https://raw.githubusercontent.com/bag-man/dotfiles/master/lucius.vim
  endif
  
  if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
  endif

""" Appearance

  syntax on
  set number relativenumber
  set nowrap

  colorscheme lucius
  LuciusDarkLowContrast

  set cindent
  set expandtab
  set shiftwidth=2
  set softtabstop=2

  set laststatus=2
  set statusline=%F
  set wildmenu
  set showcmd
  set lazyredraw

  match Delimiter /\d\ze\%(\d\d\%(\d\{3}\)*\)\>/

""" Key modifiers

  set pastetoggle=<F2>
  map <F3> :F <C-r><C-w><Cr>
  map <F4> :echo tsuquyomi#hint()<cr>
  map <F5> :make!<CR>
  map <F6> :set hlsearch!<CR>
  map <F7> :Fixmyjs<CR>
  map <F8> :TsuImport<CR>:w<cr>:Fixmyjs<cr>
  map <F9> :TsuRenameSymbol<CR>

  imap <C-u> <esc>:exe 'norm a' . system('/usr/bin/newuuid')<cr>
  map <C-u> :exe 'norm a' . system('/usr/bin/newuuid')<cr>
  map <Cr> O<Esc>j

  map Y y$
  map H ^
  map L $
  map £ g_   

  nmap <silent> <C-e> <Plug>(ale_next_wrap)
  
  nnoremap <BS> :noh<CR>

  nnoremap J :tabprev<CR>
  nnoremap K :tabnext<CR>

  nnoremap M J
  nnoremap S "_diwP

  map "p vi"p
  map 'p vi'p
  map (p vi(p
  map )p vi)p

  map q: :q
  map n nzz
  xnoremap p "_dP
  cmap w!! w !sudo tee > /dev/null %
  map <C-s> magcii`a

  nnoremap <C-b> :Buffers<cr>
  cmap bc :Bclose<Cr>

  nnoremap <tab> :tabnext<CR>
  nnoremap <s-tab> :tabprev<CR>
  nnoremap <C-t> :tabnew<CR>
  inoremap <C-t> <Esc>:tabnew<CR>i

  noremap gt <C-w>gf
  noremap gs <C-w>vgf
  noremap gi <C-w>f
  noremap <C-]> <C-w><C-]><C-w>T

  inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
  inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
  inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))
  
  imap <Tab> <C-X><C-F>
  imap <s-Tab> <C-X><C-P>

  map cp :CopyRelativePath<Cr>
  map gp :Sprunge<cr>
  map go :Google<cr>
  map gl :Gblame<Cr>
  map gb :Gbrowse<Cr>
  map ch :Gread<Cr>

  nnoremap <Space> za

""" Behaviour modifiers

  set undofile
  set undodir=~/.vim/undodir
  set clipboard=unnamed
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  set foldmethod=marker
  set backspace=indent,eol,start

  autocmd BufWritePre *.ts,*.erb,*.scss,*.rb,*.js,*.c,*.py,*.php :%s/\s\+$//e
  au BufWritePost ~/.vimrc source %

  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

  set ignorecase
  set incsearch
  set smartcase
  set scrolloff=10
  set hlsearch!

  set wildmode=longest,list,full
  set completeopt=longest,menuone

  setlocal spell spelllang=en
  nmap ss :set spell!<CR>
  set nospell
  autocmd FileType gitcommit setlocal spell

  let g:tex_flavor = 'tex'
  autocmd FileType markdown,tex 
    \ setlocal spell wrap |
    \ nnoremap <expr> k v:count == 0 ? 'gk' : 'k' |
    \ nnoremap <expr> j v:count == 0 ? 'gj' : 'j' |
   
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction

""" Plugins
    
  " NERDTree
  map <C-n> :NERDTreeTabsToggle<CR>
  map <C-f> :NERDTreeFind<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  let NERDTreeChDirMode=2
  let g:NERDTreeDirArrowExpandable = '├'
  let g:NERDTreeDirArrowCollapsible = '└'
  let g:NERDTreeMapActivateNode = '<tab>'
  set mouse=

  " Tiler
  tmap <C-q> <C-w>N
  nnoremap + <C-w>3+
  nnoremap _ <C-w>3-
  nnoremap <C-\> :term<CR><C-w>N:call tiler#reorder()<cr>i
  map <C-@> <plug>TilerNew
  let g:tiler#master#size = 20
  let g:tiler#master#count = 1
  let g:tiler#layout = 'bottom'
  let g:tiler#popup#windows = {
  \    'fzf': { 'position': 'bottom', 'size': 10, 'filetype': 'fzf', 'order': 3 },
  \    'nerdtree': { 'position': 'left', 'size': 10, 'filetype': 'nerdtree', 'order': 2 },
  \    'tagbar': { 'position': 'right', 'size': 10, 'filetype': 'tagbar', 'order': 1 },
  \ }

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
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces

  " Highlight jump points
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  " snippet trigger key
  let g:UltiSnipsExpandTrigger="<C-R><tab>"

  " vimtex
  let g:vimtex_view_general_viewer = 'zathura'

  " instant markdown
  let g:instant_markdown_slow = 1

  " Writing mode
  let g:limelight_paragraph_span = 0  
  let g:limelight_priority = -1

  function! s:goyo_enter() 
    set noshowcmd
    set noshowmode 
    set scrolloff=999
    Limelight
    colo seoul256-light
    set linespace=7
    if exists('$TMUX') 
      silent !tmux set status off
    endif
    let &l:statusline = '%M'
                            
    hi StatusLine
          \ ctermfg=137
          \ guifg=#be9873
          \ cterm=NONE
          \ gui=NONE
    call pencil#init()
  endfunction

  function! s:goyo_leave() 
    set showcmd  
    set showmode  
    set scrolloff=1
    Limelight!      
    LuciusDarkLowContrast
    set linespace=3    
    if exists('$TMUX') 
      silent !tmux set status on
    endif
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()

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
  Plug 'zhamlin/tiler.vim'                                             " Window manager

  " Small utilities
  Plug 'bag-man/copypath.vim'                                          " copy path of file
  Plug 'rbgrouleff/bclose.vim'                                         " Close current buffer
  Plug 'can3p/incbool.vim'                                             " Toggle true/false
  Plug 'kopischke/vim-fetch'                                           " Use line numbers in file paths
  Plug 'matze/vim-move'                                                " Move lines up and down
  Plug 'chilicuil/vim-sprunge'                                         " Paste selection to sprunge
  Plug 'FooSoft/vim-argwrap'                                           " Wrap arguments to multi-lines
  Plug 'szw/vim-g'                                                     " Google from Vim
  Plug 'google/vim-searchindex'                                        " Number of search results

  " Languages
  Plug 'moll/vim-node'                                                 " Syntax for node.js
  Plug 'wavded/vim-stylus'                                             " Stylus for stylus
  Plug 'digitaltoad/vim-pug'                                           " Syntax for pug
  Plug 'lervag/vimtex'                                                 " Build LaTeX files
  Plug 'josudoey/vim-eslint-fix'                                       " Eslint fixamajig
  Plug 'leafgarland/typescript-vim'                                    " TypeScript Syntax
  Plug 'Quramy/tsuquyomi'                                              " TypeScript autocompletion
  Plug 'ruanyl/vim-fixmyjs'                                            " TSlint runner
  Plug 'jparise/vim-graphql'                                           " Syntax for graphql

  " Snippets
  Plug 'SirVer/ultisnips'                                              " Snippet engine
  Plug 'isRuslan/vim-es6'                                              " ES6 snippets
  Plug 'bag-man/snipmate-mocha'                                        " Snippets for Mocha tests
  Plug 'glippi/lognroll-vim'                                           " Auto console.log vars

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
  "Plug 'suan/vim-instant-markdown'                                     " Markdown preview instant-markdown-d
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

  "writing mode
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'reedes/vim-pencil'

  call plug#end()
