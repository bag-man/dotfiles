""" Auto Installation

  " Install plugins
  if empty(glob("~/.config/nvim/autoload/plug.vim"))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
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
  if empty(glob("~/.config/nvim/colors/lucius.vim"))
    silent !curl -fLo ~/.config/nvim/colors/lucius.vim --create-dirs
          \ https://raw.githubusercontent.com/bag-man/dotfiles/master/lucius.vim
  endif
  
  " Install coc-settings
  if empty(glob("~/.config/nvim/coc-settings.json"))
    silent !curl -fLo ~/.config/nvim/coc-settings.json --create-dirs
          \ https://raw.githubusercontent.com/bag-man/dotfiles/master/coc-settings.json
  endif
  
  " Create undo directory
  if !isdirectory($HOME . "/.config/nvim/undodir")
    call mkdir($HOME . "/.config/nvim/undodir", "p")
  endif
  
  " Create backup directory
  if !isdirectory($HOME . "/.config/nvim/backup")
    call mkdir($HOME . "/.config/nvim/backup", "p")
  endif

""" Appearance

  " Syntax and lines
  syntax on
  set number relativenumber
  set nowrap
  set signcolumn=yes

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

  " debugger keys
  " nnoremap <F1> :call vimspector#ToggleBreakpoint()<CR>
  " nnoremap <F2> :call vimspector#Continue()<CR>
  " nnoremap <F3> :call vimspector#Restart()<CR>
  " nnoremap <F4> :call vimspector#Reset()<CR>
  
  " terminal navigation
  tnoremap <C-w><C-h> <C-\><C-n><C-w>h
  tnoremap <C-w><C-j> <C-\><C-n><C-w>j
  tnoremap <C-w><C-k> <C-\><C-n><C-w>k
  tnoremap <C-w><C-l> <C-\><C-n><C-w>l
  
  " coc bindings
  nnoremap <F5> :call CocActionAsync('doHover')<cr>
  nnoremap <S-F5> :call CocActionAsync('showSignatureHelp')<cr>
  nnoremap <F6> :call CocActionAsync('rename')<cr>
  nnoremap <F7> :call CocAction('jumpReferences')<cr>
  nnoremap <F8> <Plug>(coc-codeaction-selected)w
  
  " View git history for file
  nnoremap <F9> :AgitFile <Cr>
  
  " Find word in project
  nnoremap <F10> :F <C-r><C-w><Cr>

  nnoremap <C-e> :call CocActionAsync('diagnosticNext', 'error')<cr>
  nnoremap <C-]> :call CocActionAsync('jumpDefinition')<cr>
 
  " Generate UUID 
  inoremap <C-u> <esc>:exe 'norm a' . system('/usr/bin/newuuid')<cr>a
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
  nnoremap gs :vertical wincmd f<CR>
  nnoremap gi <C-w>f

  " Autocomplete navigation
  inoremap <silent><expr> J coc#pum#visible() ? coc#pum#next(0) : "J"
  inoremap <silent><expr> K coc#pum#visible() ? coc#pum#prev(0) : "K"
  inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

  " External item maps
  nnoremap cp :CopyRelativePath<Cr>

  vnoremap gp :Sprunge<cr>
  nnoremap gp :Sprunge<cr>

  vnoremap go :Google<cr>
  nnoremap go :Google<cr>

  vnoremap gl :Git blame<Cr>
  nnoremap gl :Git blame<Cr>

  vnoremap gb :GBrowse!<Cr>
  nnoremap gb :GBrowse!<Cr>

  nnoremap ch :Gread<Cr>

  " Open fold
  nnoremap <Space> za

""" Behaviour modifiers

  set undofile
  set undodir=~/.config/nvim/undodir
  set backup
  set backupdir=~/.config/nvim/backup/
  set writebackup
  set backupcopy=yes
  set clipboard^=unnamed
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  set foldmethod=marker
  set backspace=indent,eol,start
  set wildmode=longest,list,full
  set completeopt=longest,menuone
  set mouse=
  set lazyredraw

  " js/ts filejumps
  set path=.,..,src,node_modules
  set suffixesadd=.js,.jsx,.ts,.tsx
  
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
    autocmd BufWritePost ~/.config/nvimrc source %

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
    
    " Rainbow brackets
    if !empty(glob("~/.config/nvim/plugged/rainbow_parentheses.vim/autoload/rainbow_parentheses.vim"))
      autocmd VimEnter * RainbowParenthesesToggle
      autocmd Syntax * RainbowParenthesesLoadRound
      autocmd Syntax * RainbowParenthesesLoadSquare
      autocmd Syntax * RainbowParenthesesLoadBraces
      syntax on
    endif 

    autocmd FileType agit nmap <silent><buffer> J :tabprev<cr>
    autocmd FileType agit nmap <silent><buffer> K :tabnext<cr>

    " Coc errors
    highlight CocErrorHighlight ctermfg=Red guifg=#ff0000

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

  augroup END

""" Plugins
    
  " NERDTree
  nnoremap <C-n> :NERDTreeTabsToggle<CR>
  nnoremap <C-f> :NERDTreeFind<CR>
  let NERDTreeChDirMode=2
  let g:NERDTreeDirArrowExpandable = '├'
  let g:NERDTreeDirArrowCollapsible = '└'
  let g:NERDTreeMapActivateNode = '<tab>'

  " Nuake
  tnoremap <C-q> <C-\><C-n>
  tnoremap <C-\> <C-\><C-n>:Nuake<CR>
  nnoremap + <C-w>3+
  nnoremap _ <C-w>3-
  nnoremap <C-\> :Nuake<CR>
  inoremap <C-\> <C-\><C-n>:Nuake<CR>
  let g:nuake_position = 'top'
  let g:nuake_size = 0.2
  let g:nuake_per_tab = 1
 
  " argwrap
  nnoremap <silent> <Bslash>a :ArgWrap<CR>
  let g:argwrap_padded_braces = '{'

  " fzf config
  nnoremap <C-p> :Files<cr>
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-i': 'split',
    \ 'ctrl-s': 'vsplit' }
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{tf,yml,yaml,vim,viml,tsx,ts,js,jsx,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,graphql,gql,sql,proto}"
    \ -g "!{.config,.git,node_modules,vendor,yarn.lock,*.sty,*.bst,build,dist,output}/*" '

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command . shellescape(<q-args>), 1, <bang>0)
  command! -bang -nargs=* FU call fzf#vim#grep(g:rg_command . '-m1 ' . shellescape(<q-args>), 1, <bang>0)

  " vim-move
  let g:move_key_modifier = 'C'

  " Highlight jump points
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  " Agit
  let g:agit_enable_auto_refresh = 1

  " coc extensions
  let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-pyright', 'coc-rls', 'coc-sql']

""" Plugins 

  call plug#begin('~/.config/nvim/plugged')
  filetype plugin indent on

  " Features
  Plug 'scrooloose/nerdtree'                                           " File tree browser
  Plug 'Xuyuanp/nerdtree-git-plugin'                                   " Git for NerdTree
  Plug 'jistr/vim-nerdtree-tabs'                                       " NerdTree independent of tabs
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }    " Install fzf for user
  Plug 'junegunn/fzf.vim'                                              " Fzf vim plugin
  Plug 'neoclide/coc.nvim', {'branch': 'release'}                      " Language server
  Plug 'bag-man/nuake'                                                 " Quake term
  " Plug 'puremourning/vimspector'                                     " Debugger
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Small utilities
  Plug 'bag-man/copypath.vim'                                          " copy path of file
  Plug 'can3p/incbool.vim'                                             " Toggle true/false
  Plug 'kopischke/vim-fetch'                                           " Use line numbers in file paths
  Plug 'matze/vim-move'                                                " Move lines up and down
  Plug 'chilicuil/vim-sprunge'                                         " Paste selection to sprunge
  Plug 'FooSoft/vim-argwrap'                                           " Wrap arguments to multi-lines
  Plug 'szw/vim-g'                                                     " Google from Vim
  Plug 'google/vim-searchindex'                                        " Number of search results
  Plug 'sickill/vim-pasta'                                             " Paste format
  Plug 'cohama/agit.vim'                                               " Git log
  Plug 'kamykn/spelunker.vim'                                          " Clever spell check

  " Languages
  " Plug 'leafgarland/typescript-vim'                                    " TypeScript Syntax
  " Plug 'jparise/vim-graphql'                                           " Syntax for graphql

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
  Plug 'drzel/vim-in-proportion'                                       " Maintain splits when windows gets resized
  Plug 'breuckelen/vim-resize'                                         " Use Ctrl+arrows to resize splits 

  " Text objects
  Plug 'wellle/targets.vim'                                            " Additional text objects                   
  Plug 'michaeljsmith/vim-indent-object'                               " Indented text object
  Plug 'kana/vim-textobj-user'                                         " Add additional text objects
  Plug 'jceb/vim-textobj-uri'                                          " URL objects
  Plug 'glts/vim-textobj-comment'                                      " Comment text objects
  Plug 'kana/vim-textobj-function'                                     " Add function based text objects
  Plug 'bag-man/vim-textobj-function-javascript'                       " Add JS function object
  Plug 'reedes/vim-textobj-sentence'                                   " Sentence object
  
  call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = maintained, 
  sync_install = false, 
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
EOF

