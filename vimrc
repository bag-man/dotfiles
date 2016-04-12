""" Auto-installation
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

  " status line
  set laststatus=2
  set statusline=%F
  set wildmenu

"}}}

""" Make configs
"{{{

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

  " Hotkey modifiers
  "{{{
  
    " make enter work in normal
    map <Cr> O<Esc>j

    " yank to EOL like it should
    map Y y$

    " paste over easier
    map "p vi"p
    map 'p vi'p
    map \(p vi(p

    " stop the command popup
    map q: :q

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

    " checkout file
    map ch :Gread<Cr>
    
    " Use j / k / tab for autocomplete
    inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
    inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
    inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))

    " auto complete file paths
    imap <Tab> <C-X><C-F>

    " fugitive maps
    map gl :Gblame<Cr>
    map gb :Gbrowse<Cr>

    " close buffer
    map bc :Bclose<Cr>

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

    " spelling
    setlocal spell spelllang=en
    nmap ss :set spell!<CR>
    set nospell
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal wrap
    autocmd FileType gitcommit setlocal spell

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

    Plug 'kien/ctrlp.vim'
    Plug 'scrooloose/syntastic'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
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
    Plug 'jreybert/vimagit'
    Plug 'justinmk/vim-sneak'
    Plug 'mattn/emmet-vim'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'suan/vim-instant-markdown' " sudo npm -g install instant-markdown-d
    Plug 'undofile_warn.vim'
    Plug 'wavded/vim-stylus'
    Plug 'wellle/targets.vim'
    Plug 'tpope/vim-abolish'
    
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

    " Unite
    let g:unite_source_grep_default_opts = '-srnw --binary-files=without-match --exclude-dir={build,vendor,node_modules,.git} --include=*.{vcl,conf,jade,js,styl,php,json,config,html} --exclude={*.min.js,tags}'
    command! -nargs=1 F execute 'Unite grep:.::' .<q-args>. ' -default-action=below'

    " ctrlp
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
    nmap s <Plug>Sneak_s
    nmap S <Plug>Sneak_S
    xmap s <Plug>Sneak_s
    xmap S <Plug>Sneak_S
    omap s <Plug>Sneak_s
    omap S <Plug>Sneak_S
    let g:sneak#s_next = 1
    hi link SneakPluginTarget ErrorMsg

    call plug#end()

  "}}}

"}}}
