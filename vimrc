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

  " Build Plugins (On second launch)
  "{{{
    if empty(glob("~/.vim/plugged/vimproc.vim/lib/vimproc_linux64.so"))
      silent !cd ~/.vim/plugged/vimproc.vim/; make; cd -
    endif 

    if empty(glob("~/.vim/plugged/ctrlp-cmatcher/autoload/fuzzycomt.so"))
      silent !cd ~/.vim/plugged/ctrlp-cmatcher; sh install.sh; cd -
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

""" Function Keys
"{{{

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

"}}}

""" Behaviour modifiers
"{{{

  " Key modifiers
  "{{{
  
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

    " delete surrounding function
    map dsf f(ds(db

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
    inoremap <C-t> <Esc>:tabnew<CR>

    " copy path
    map cp :CopyRelativePath<Cr>

    " sprunge section or file
    map gp :Sprunge<cr>
    
    " Google section or word
    map go :Google<cr>
    
    " Use j / k / tab for autocomplete
    inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
    inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
    inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))

    " auto complete file paths
    imap <Tab> <C-X><C-F>
    imap <s-Tab> <C-X><C-P>

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
  
    " strip trailing whitespace
    autocmd BufWritePre *.js,*.c,*.py,*.php :%s/\s\+$//e

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

    Plug 'kien/ctrlp.vim'                                 " File searching
    Plug 'scrooloose/syntastic'                           " Syntax checking
    Plug 'scrooloose/nerdtree'                            " File tree browser
    Plug 'Xuyuanp/nerdtree-git-plugin'                    " Git for NerdTree
    Plug 'moll/vim-node'                                  " Syntax for node.js
    Plug 'digitaltoad/vim-jade'                           " Syntax for jade
    Plug 'rbgrouleff/bclose.vim'                          " Close current buffer
    Plug 'tpope/vim-surround'                             " Operate on surrounding 
    Plug 'tpope/vim-speeddating'                          " Increment dates
    Plug 'tpope/vim-repeat'                               " Repeat plugins
    Plug 'tpope/vim-commentary'                           " Comment out blocks
    Plug 'mkitt/tabline.vim'                              " Cleaner tabs
    Plug 'jistr/vim-nerdtree-tabs'                        " NerdTree independent of tabs
    Plug 'bag-man/copypath.vim'                           " copy path of file
    Plug 'tpope/vim-fugitive'                             " Git integration
    Plug 'can3p/incbool.vim'                              " Toggle true/false
    Plug 'chrisbra/Colorizer'                             " Show hex codes as colours
    Plug 'triglav/vim-visual-increment'                   " Increment over visual selection
    Plug 'kopischke/vim-fetch'                            " Use line numbers in file paths
    Plug 'Shougo/unite.vim'                               " Used for grep in project
    Plug 'Shougo/vimproc.vim'                             " Speed up unite and ctrlp
    Plug 'matze/vim-move'                                 " Move lines up and down
    Plug 'JazzCore/ctrlp-cmatcher'                        " Improve ctrlp
    Plug 'jreybert/vimagit'                               " Interactive git staging
    Plug 'justinmk/vim-sneak'                             " Multiline find
    Plug 'mattn/emmet-vim'                                " Template HTML
    Plug 'kien/rainbow_parentheses.vim'                   " Colour matched brackets
    Plug 'suan/vim-instant-markdown'                      " Markdown preview instant-markdown-d
    Plug 'undofile_warn.vim'                              " Warn old undo
    Plug 'wavded/vim-stylus'                              " Stylus for stylus
    Plug 'wellle/targets.vim'                             " Additional text objects                   
    Plug 'tpope/vim-abolish'                              " Flexible search
    Plug 'chilicuil/vim-sprunge'                          " Paste selection to sprunge
    Plug 'lervag/vimtex'                                  " Build LaTeX files
    Plug 'michaeljsmith/vim-indent-object'                " Indented text object
    Plug 'kana/vim-textobj-user'                          " Add additional text objects
    Plug 'kana/vim-textobj-function'                      " Add function based text objects
    Plug 'thinca/vim-textobj-function-javascript'         " Add JS function object
    Plug 'prendradjaja/vim-vertigo'                       " Use asdfghjkl; as numbers
    Plug 'FooSoft/vim-argwrap'                            " Wrap arguments to multi-lines
    Plug 'szw/vim-g'                                      " Google from Vim
    Plug 'kshenoy/vim-signature'                          " Show marks
    Plug 'arkwright/vim-whiteboard'                       " Whiteboard
    
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

    " syntastic
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

    " vertigo
    nnoremap <silent> <Bslash>j :<C-U>VertigoDown n<CR>
    vnoremap <silent> <Bslash>j :<C-U>VertigoDown v<CR>
    onoremap <silent> <Bslash>j :<C-U>VertigoDown o<CR>
    nnoremap <silent> <Bslash>k :<C-U>VertigoUp n<CR>
    vnoremap <silent> <Bslash>k :<C-U>VertigoUp v<CR>
    onoremap <silent> <Bslash>k :<C-U>VertigoUp o<CR>

    " argwrap
    nnoremap <silent> <Bslash>a :ArgWrap<CR>
    let g:argwrap_padded_braces = '{'

    " Unite
    let g:unite_source_grep_default_opts = '-srnw --binary-files=without-match --exclude-dir={build,vendor,node_modules,.git} --include=*.{vcl,conf,jade,js,styl,php,json,config,html} --exclude={*.min.js,tags}'
    command! -nargs=1 F execute 'Unite grep:.::' .<q-args>. ' -default-action=below'

    " ctrlp
    map <C-y> :CtrlPTag<cr>
    let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
    let g:ctrlp_use_caching = 0
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<C-i>'],
      \ 'AcceptSelection("v")': ['<C-s>'],
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip

    " Ggrep
    autocmd QuickFixCmdPost *grep* cwindow

    " vim-move
    let g:move_key_modifier = 'C'

    " rainbow brackets
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
   
    " instant markdown
    let g:instant_markdown_slow = 1
    " dom.allow_scripts_to_close_windows = true
    " euclio/instant-markdown-d@4fcd47422d

    " sneak
    map s <Plug>Sneak_s
    let g:sneak#s_next = 1
    hi link SneakPluginTarget ErrorMsg

    " vimtex
    let g:vimtex_view_general_viewer = 'zathura'
    " community/zathura
    " community/zathura-pdf-poppler
    
    " whiteboard
    let g:whiteboard_temp_directory = '/tmp/'
    let g:whiteboard_default_interpreter = 'javascript'

    call plug#end()

  "}}}

"}}}
