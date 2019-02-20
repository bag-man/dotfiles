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
      if system('uname')=~'Darwin'
        silent !curl -fLo /tmp/rg.tar.gz
              \ https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-apple-darwin.tar.gz
        silent !tar xzvf /tmp/rg.tar.gz --directory /tmp
        silent !cp /tmp/ripgrep-0.10.0-x86_64-apple-darwin/rg ~/.fzf/bin/rg
      else
        silent !curl -fLo /tmp/rg.tar.gz
              \ https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-unknown-linux-musl.tar.gz
        silent !tar xzvf /tmp/rg.tar.gz --directory /tmp
        silent !cp /tmp/ripgrep-0.10.0-x86_64-unknown-linux-musl/rg ~/.fzf/bin/rg
      endif
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
  set autoindent
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
  nnoremap <F3> :F <C-r><C-w><Cr>
 
  " Replace word in buffers
  nnoremap <F4> :R <C-r><C-w>

  " Typescript language tools
  nnoremap <F5> :echo tsuquyomi#hint()<cr>
  nnoremap <F6> :TsuRenameSymbol<CR>
  nnoremap <F7> :w<cr>:Fixmyjs<CR>:w<cr>
  nnoremap <F8> :TsuImport<CR>

  " Generate UUID 
  inoremap <C-u> <esc>:exe 'norm a' . system('/usr/bin/newuuid')<cr>
  nnoremap <C-u> :exe 'norm a' . system('/usr/bin/newuuid')<cr>

  " Shortcuts for movement and manipulation
  nnoremap <Cr> O<Esc>j
  nnoremap Y y$
  map H ^
  map L $
  map £ g_   
  nnoremap M J

  " Clear search
  nnoremap <BS> :noh<CR>

  " Jump to next error
  nmap <silent> <C-e> <Plug>(ale_next_wrap)
  
  " Paste over quotes and brackets (Hacky)
  nnoremap "p vi"p
  nnoremap 'p vi'p
  nnoremap (p vi(p
  nnoremap )p vi)p

  " Fix typo
  nnoremap q: :q

  " Center next item
  nnoremap n nzz

  " Write as sudo
  cnoremap w!! w !sudo tee > /dev/null %
  
  " View fzf buffers
  nnoremap <C-b> :Buffers<cr>

  " Tab navigation
  nnoremap <C-t> :tabnew<CR>
  inoremap <C-t> <Esc>:tabnew<CR>i
  nnoremap J :tabprev<CR>
  nnoremap K :tabnext<CR>

  " Open file from link
  nnoremap gt <C-w>gf
  nnoremap gs <C-w>vgf
  nnoremap gi <C-w>f

  " Autocomplete navigation
  inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
  inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
  inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))
  inoremap <Tab> <C-x><C-o>
  inoremap <s-Tab> <C-X><C-P>


  " External item maps
  nnoremap cp :CopyRelativePath<Cr>

  vnoremap gp :Sprunge<cr>
  nnoremap gp :Sprunge<cr>

  vnoremap go :Google<cr>
  nnoremap go :Google<cr>

  vnoremap gl :Gblame<Cr>
  nnoremap gl :Gblame<Cr>

  vnoremap gb :Gbrowse<Cr>
  nnoremap gb :Gbrowse<Cr>

  nnoremap ch :Gread<Cr>

  " Open fold
  nnoremap <Space> za

""" Behaviour modifiers

  set undofile
  set undodir=~/.vim/undodir
  set clipboard^=unnamed
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  set foldmethod=marker
  set backspace=indent,eol,start
  set wildmode=longest,list,full
  set completeopt=longest,menuone
  set mouse=
  set lazyredraw
  
  " Search settings
  set ignorecase
  set incsearch
  set smartcase
  set scrolloff=10
  set hlsearch

  " Spelling
  setlocal spell spelllang=en
  nnoremap ss :set spell!<CR>
  set nospell

  " Autocommands
  augroup AutoCommands
    autocmd! 
    
    " Strip whitespace
    autocmd BufWritePre *.ts,*.erb,*.scss,*.rb,*.js,*.c,*.py,*.php :%s/\s\+$//e

    " Auto load vimrc on save
    autocmd BufWritePost ~/.vimrc source %

    " Maintain cwd
    autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
    autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

    " Set spell on commits
    autocmd FileType gitcommit setlocal spell
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Nerdtree config
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    
    " rainbow brackets
    if !empty(glob("~/.vim/plugged/rainbow_parentheses.vim/autoload/rainbow_parentheses.vim"))
      autocmd VimEnter * RainbowParenthesesToggle
      autocmd Syntax * RainbowParenthesesLoadRound
      autocmd Syntax * RainbowParenthesesLoadSquare
      autocmd Syntax * RainbowParenthesesLoadBraces
    endif 
  augroup END

  " operate on word in all buffers
  function! OperateBuffers(find, ...)
      let operation=join(a:000, ' ')
      execute 'bufdo g/' . a:find . '/exe "norm /' . a:find . '\<cr>\' . operation . '" | update'
  endfunction
  command! -bang -nargs=* OB call OperateBuffers(<f-args>)
  
  " operate on word in all buffers
  function! Operate(find, ...)
      let operation=join(a:000, ' ')
      execute 'g/' . a:find . '/exe "norm /' . a:find . '\<cr>\' . operation . '" | update'
  endfunction
  command! -bang -nargs=* O call Operate(<f-args>)

  " Find and replace in all buffers
  function! Replace(find, replace)
      execute 'bufdo %s/'. a:find . '/'. a:replace . '/gc | update'
  endfunction
  command! -bang -nargs=* R call Replace(<f-args>)

""" Plugins
    
  " NERDTree
  nnoremap <C-n> :NERDTreeTabsToggle<CR>
  nnoremap <C-f> :NERDTreeFind<CR>
  let NERDTreeChDirMode=2
  let g:NERDTreeDirArrowExpandable = '├'
  let g:NERDTreeDirArrowCollapsible = '└'
  let g:NERDTreeMapActivateNode = '<tab>'

  " Nuake
  tnoremap <C-q> <C-w>N
  tnoremap <C-\> <C-\><C-n>:Nuake<CR>
  nnoremap + <C-w>3+
  nnoremap _ <C-w>3-
  nnoremap <C-\> :Nuake<CR>
  inoremap <C-\> <C-\><C-n>:Nuake<CR>
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

  augroup AleHighlights
    autocmd!
    autocmd ColorScheme * highlight ALEError ctermbg=none cterm=underline,bold
                      \ | highlight ALEWarning ctermbg=none cterm=underline,bold
  augroup END

  let g:ale_type_map = { 'tslint': { 'ES': 'WS', 'E': 'W' } }
 
  " Typescript completion
  let g:tsuquyomi_completion_detail = 1
  let g:tsuquyomi_disable_quickfix = 1
  let g:tsuquyomi_definition_split = 2
  let g:tsuquyomi_single_quote_import = 1

  " argwrap
  nnoremap <silent> <Bslash>a :ArgWrap<CR>
  let g:argwrap_padded_braces = '{'

  " fzf config
  nnoremap <C-p> :Files<cr>

  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-i': 'split',
    \ 'ctrl-s': 'vsplit' }
  let g:fzf_layout = { 'down': '~20%' }

  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{ts,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,graphql,gql,sql}"
    \ -g "!{.config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,build,dist}/*" '

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

  " JS lint fix
  let g:fixmyjs_engine = 'tslint'

  " long-roll
  let g:lognroll_js_console = 'log'
  let g:lognroll_js_actions = [ 'info', 'warn', 'error', 'debug' ]

  " vim-move
  let g:move_key_modifier = 'C'

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
  if v:version >= 801
    Plug 'bag-man/nuake'                                                 " Quake term
  endif

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
  Plug 'sickill/vim-pasta'                                             " Paste format

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
  Plug 'bag-man/vim-textobj-function-javascript'                        " Add JS function object
  Plug 'reedes/vim-textobj-sentence'                                   " Sentence object

  call plug#end()
