""" Auto Installation
"{{{

  " Install Vim-Plug & Plugins
  "{{{
    if empty(glob("~/.vim/autoload/plug.vim"))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      auto VimEnter * PlugInstall
    endif
  "}}}

  " Install colorscheme
  "{{{
    if empty(glob("~/.vim/colors/lucius.vim"))
      silent !curl -fLo ~/.vim/colors/lucius.vim --create-dirs
            \ https://raw.githubusercontent.com/bag-man/dotfiles/master/lucius.vim
    endif
  "}}}
  
  " Create undo dir
  "{{{
    if !isdirectory($HOME . "/.vim/undodir")
      call mkdir($HOME . "/.vim/undodir", "p")
    endif
  "}}}

"}}}

""" Appearance
"{{{

  " syntax highlighting
  syntax on

  " line numbers
  set number relativenumber

  " turn off text wrapping
  set nowrap

  " set color theme
  colorscheme lucius
  LuciusDarkLowContrast

  " indenting
  set cindent
  set expandtab
  set shiftwidth=2
  set softtabstop=2

  " status line
  set laststatus=2
  set statusline=%F
  set wildmenu
  set showcmd

  " Highlight third numbers
  match Delimiter /\d\ze\%(\d\d\%(\d\{3}\)*\)\>/

"}}}

""" Behaviour modifiers
"{{{

  " Key modifiers
  "{{{
  
    " set paste mode
    set pastetoggle=<F2>

    " Find word under cusor
    map <F3> :F "<cword>"<cr>

    " make F5 compile
    map <F5> :make!<cr>

    " Toggle highlight
    map <F6> :set hlsearch!<CR>

    " make enter work in normal
    map <Cr> O<Esc>j

    " yank to EOL like it should
    map Y y$

    " H & L to EOL
    map H ^
    map L $

    " navigate tabs like vimium
    nnoremap J :tabprev<CR>
    nnoremap K :tabnext<CR>

    " join a line
    nnoremap M J

    " stamp over a word
    nnoremap S "_diwP

    " paste over easier
    map "p vi"p
    map 'p vi'p
    map (p vi(p
    map )p vi)p

    " stop the command popup
    map q: :q

    " center next
    map n nzz

    " paste without overwriting
    xnoremap p "_dP

    " save as sudo
    cmap w!! w !sudo tee > /dev/null %

    " change buffer
    map <C-l> :bn<Cr>
    map <C-h> :bp<Cr>

    " tab navigation 
    nnoremap <tab> :tabnext<CR>
    nnoremap <s-tab> :tabprev<CR>
    nnoremap <C-t> :tabnew<CR>
    inoremap <C-t> <Esc>:tabnew<CR>i
    "
    " Use j / k / tab for autocomplete
    inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
    inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
    inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))
    
    " auto complete file paths
    imap <Tab> <C-X><C-F>
    imap <s-Tab> <C-X><C-P>

    " copy path
    map cp :CopyRelativePath<Cr>

    " sprunge section or file
    map gp :Sprunge<cr>
    
    " Google section or word
    map go :Google<cr>

    " fugitive maps
    map gl :Gblame<Cr>
    map gb :Gbrowse!<Cr>
    map ch :Gread<Cr>

    " close buffer
    cmap bc :Bclose<Cr>

    " open file in new tab
    noremap gt <C-w>gf

    " open file in new split
    noremap gs <C-w>vgf
    noremap gi <C-w>f

    " open ctag in new tab
    noremap <C-]> <C-w><C-]><C-w>T

    " set space to toggle folds
    nnoremap <Space> za

    " resize splits with Ctrl+←↑→↓
    map Od <C-w>>
    map Oc <C-w><
    map Oa <C-w>+ 
    map Ob <C-w>-

    " go to last non whitespace character
    map £ g_   

  "}}}
  
  " Auto modifiers
  "{{{
  "
    " persist undos
    set undofile
    set undodir=~/.vim/undodir

    " share clipboard with system 
    set clipboard=unnamed

    " ignore files
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  
    " strip trailing whitespace
    autocmd BufWritePre *.erb,*.scss,*.rb,*.js,*.c,*.py,*.php :%s/\s\+$//e

    " enable backspace in insert
    set backspace=indent,eol,start

    " change dir for file completion
    autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
    autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

    " set foldmarker
    set foldmethod=marker

    " search settings
    set ignorecase
    set incsearch
    set smartcase
    set scrolloff=10
    set hlsearch!

    " complete settings
    set wildmode=longest,list,full
    set completeopt=longest,menuone

    " spelling
    setlocal spell spelllang=en
    nmap ss :set spell!<CR>
    set nospell
    autocmd FileType gitcommit setlocal spell

    " word processing
    let g:tex_flavor = 'tex'
    autocmd FileType markdown,tex 
      \ setlocal spell wrap |
      " \ map j gj |
      " \ map k gk |
     
    " Jump to last know position in file
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Map macros across visual selection
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction

  "}}}

"}}}

""" Plugins
"{{{

  " Plugins
  "{{{

    call plug#begin('~/.vim/plugged')
    filetype plugin indent on

    Plug 'w0rp/ale'                                                      " Async linting
    Plug 'scrooloose/nerdtree'                                           " File tree browser
    Plug 'Xuyuanp/nerdtree-git-plugin'                                   " Git for NerdTree
    Plug 'moll/vim-node'                                                 " Syntax for node.js
    Plug 'digitaltoad/vim-jade'                                          " Syntax for jade
    Plug 'rbgrouleff/bclose.vim'                                         " Close current buffer
    Plug 'tpope/vim-surround'                                            " Operate on surrounding 
    Plug 'tpope/vim-speeddating'                                         " Increment dates
    Plug 'tpope/vim-repeat'                                              " Repeat plugins
    Plug 'tpope/vim-commentary'                                          " Comment out blocks
    Plug 'mkitt/tabline.vim'                                             " Cleaner tabs
    Plug 'jistr/vim-nerdtree-tabs'                                       " NerdTree independent of tabs
    Plug 'bag-man/copypath.vim'                                          " copy path of file
    Plug 'tpope/vim-fugitive'                                            " Git integration
    Plug 'can3p/incbool.vim'                                             " Toggle true/false
    Plug 'chrisbra/Colorizer'                                            " Show hex codes as colours
    Plug 'triglav/vim-visual-increment'                                  " Increment over visual selection
    Plug 'kopischke/vim-fetch'                                           " Use line numbers in file paths
    Plug 'matze/vim-move'                                                " Move lines up and down
    Plug 'jreybert/vimagit'                                              " Interactive git staging
    Plug 'justinmk/vim-sneak'                                            " Multiline find
    Plug 'kien/rainbow_parentheses.vim'                                  " Colour matched brackets
    Plug 'suan/vim-instant-markdown'                                     " Markdown preview instant-markdown-d
    Plug 'undofile_warn.vim'                                             " Warn old undo
    Plug 'wavded/vim-stylus'                                             " Stylus for stylus
    Plug 'wellle/targets.vim'                                            " Additional text objects                   
    Plug 'tpope/vim-abolish'                                             " Flexible search
    Plug 'chilicuil/vim-sprunge'                                         " Paste selection to sprunge
    Plug 'lervag/vimtex'                                                 " Build LaTeX files
    Plug 'michaeljsmith/vim-indent-object'                               " Indented text object
    Plug 'kana/vim-textobj-user'                                         " Add additional text objects
    Plug 'kana/vim-textobj-function'                                     " Add function based text objects
    Plug 'thinca/vim-textobj-function-javascript'                        " Add JS function object
    Plug 'FooSoft/vim-argwrap'                                           " Wrap arguments to multi-lines
    Plug 'szw/vim-g'                                                     " Google from Vim
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }    " Install fzf for user
    Plug 'junegunn/fzf.vim'                                              " Fzf vim plugin
    
  "}}}

  " Plugin Configurations
  "{{{

    " NERDTree
    map <C-n> :NERDTreeTabsToggle<CR>
    map <C-f> :NERDTreeFind<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    let NERDTreeChDirMode=2
    let g:NERDTreeDirArrowExpandable = '├'
    let g:NERDTreeDirArrowCollapsible = '└'
    let g:NERDTreeMapActivateNode = '<tab>'
    set mouse=a

    " Ale
    let g:ale_sign_error = ' '
    let g:ale_sign_warning = ' '
    let g:ale_sign_column_always = 1
    let g:ale_linters = {
    \   'javascript': ['eslint'],
    \}

    " argwrap
    nnoremap <silent> <Bslash>a :ArgWrap<CR>
    let g:argwrap_padded_braces = '{'

    " fzf config
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-i': 'split',
      \ 'ctrl-s': 'vsplit' }
    let g:fzf_layout = { 'down': '~20%' }

    function! s:escape(path)
      return substitute(a:path, ' ', '\\ ', 'g')
    endfunction

    function! GrepHandler(line)
      let parts = split(a:line, ':')
      let [fn, lno] = parts[0 : 1]
      execute 'e '. s:escape(fn)
      execute lno
      normal! zz
    endfunction

    command! -nargs=+ F call fzf#run({
      \ 'source': 'grep -srnw --exclude-dir={build,vendor,node_modules,.git} --include=*.{rb,erb,vcl,conf,jade,js,styl,php,json,config,html} --exclude={*.min.js,tags} "<args>"',
      \ 'sink': function('GrepHandler'),
    \ })

    nmap <C-p> :FZF<cr>
    imap <c-x><c-l> <plug>(fzf-complete-line)

    " vim-move
    let g:move_key_modifier = 'C'

    " rainbow brackets
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces

    " sneak
    map s <Plug>Sneak_s
    let g:sneak#s_next = 1
    hi link SneakPluginTarget ErrorMsg

    " vimtex
    let g:vimtex_view_general_viewer = 'zathura'
    " community/zathura
    " community/zathura-pdf-poppler
    
    " instant markdown
    let g:instant_markdown_slow = 1
    " dom.allow_scripts_to_close_windows = true
    " euclio/instant-markdown-d@4fcd47422d
    
    call plug#end()

  "}}}

"}}}
