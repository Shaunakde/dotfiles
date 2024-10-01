" Baseline {{{
        set encoding=utf-8
        scriptencoding utf-8
" }}}

" Helpers {{{
        let s:running_windows=has('win16') || has('win32') || has('win64')
        let s:colorful_term=(&term=~?'xterm') || (&term=~?'screen')
" }}}

" Disable vi compatibility, if for some reason it's on {{{
if &compatible
  set nocompatible
endif
" }}}

" Make the escape key more responsive by decreasing the wait time for an
" escape sequence (e.g., arrow keys).
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set nrformats-=octal

" Disable completing keywords in included files (e.g., #include in C).  When
" configured properly, this can result in the slow, recursive scanning of
" hundreds of files of dubious relevance.
set complete-=i

" Search Settings
set incsearch
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>


" Basic Settings {{{
        set backspace=indent,eol,start " make backspace a more flexible
        set backupdir=~/.vim/backup/ " where to put backup files
        set backup " make backup files
        set belloff=all " no noises!
        set breakindent " this is just awesome (best patch in a long time)
        set cmdheight=2 " Gets rid of all the press enter to continue
        set completeopt=menu,menuone,noselect,noinsert
        set complete=.,w,b,u,U,i,t " complete options
        set conceallevel=0 " Don't hide from me!
        set diffopt=vertical,filler,iwhite " filler and whitespace
        set directory=~/.vim/temp/ " directory to place swap files in
        set expandtab " no real tabs please!
        set exrc " source .vimrc _vimrc .exrc _exrc files in local tree (deepest found rules all)
        set fileencoding=utf-8 " UTF-8
        set fileformats=unix,dos,mac " support all three, in this order
        set foldclose=all " Open folds if you leave them in any way
        set foldcolumn=0 " I can see fold fine thank you
        set foldenable " Turn on folding by default
        set foldlevel=10 " Autofold nothing by default
        set foldmethod=syntax " Fold on the syntax
        set foldnestmax=1 " I only like to fold outer functions
        set foldopen=all " Open folds if you touch them in any way
        set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s* " and bullets, too
        set hidden " load files in background
        set history=9999 " big old history
        set hlsearch " do highlight searched for phrases
        set ignorecase " case insensitive by default
        set incsearch " BUT do highlight as you type you search phrase
        set infercase " case inferred by default
        set laststatus=2 " always show the status line
        set lazyredraw " do not redraw while running macros
        set linebreak " break on words not mid-word
        set linespace=0 " don't insert any extra pixel lines betweens rows
        set list " show listchars
        set listchars=tab:\ \ ,extends:›,precedes:‹,nbsp:‡,trail:•
        set modeline " I have started using modelines (risky business!)
        set modelines=5 " Search for 5 lines for modelines
        set noautoread " nope
        set noautowrite " nope
        set noautowriteall " nope
        set nocursorcolumn " no cursor column
        set pastetoggle=<F12> " maybe I can remember F12
        set nocursorline " no cursor line highlight
        set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
        set nomore " Scroll away, no pausing
        set nonumber " no line numbers
        set norelativenumber " no relative line numbers
        set nospell " nope nope nope
        set notimeout " better timeout handling
        set novisualbell " don't be noisy
        set numberwidth=5 " We are good up to 99999 lines
        set omnifunc=syntaxcomplete#Complete
        set path=.,** " Default path is local dir, make better with autocommands per language
        set report=0 " tell us when anything is changed via :
        set ruler " Always show current positions along the bottom
        set scrolljump=5 " If you hit bottom or top, jump 5
        set scrolloff=5 " Keep focus on middle of screen when possible
        set secure " but lets not go crazy
        set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
        set shiftwidth=4 " auto-indent amount when using cindent, >>, << and stuff like that, also does softtabstop when negative
        set smartindent "Helpful for python and other indent based languages
        set showbreak=›››\  " this is how we show breaks (this comment is broken in vim, dafaq)
        set showcmd " Show the commands
        set showmatch " do show matching things
        set showmode " default but just in case
        set sidescroll=5 " If you hit edge, jump 5
        set sidescrolloff=5 " Keep 5 lines at the size
        set smartcase " Smart case enabled
        set softtabstop=4 " Prefered tab stop for python code
        set splitbelow " split below
        set splitright " split right
        set startofline " do reset to start of line on events
        set switchbuf=useopen " when working with quickfix use new splits
        set synmaxcol=2500 " Don't try to highlight lines longer than X characters, made larger for long strings (consistent background highlight)
        set tabstop=4 " real tabs should be 8, and they will show with set list on
        set tags=./tags;,tags; " interesting!
        set textwidth=0 " No autowrapping
        set title " mess with the title
        set titlestring= " no title string
        set ttimeoutlen=10 " 10ms timeout
        set ttimeout " time out on key codes
        set ttyfast " Assume a fast terminal
        set t_vb= " seriously, shhhh, don't be noisy
        set undodir=~/.vim/undo/,~/vimfiles/undo/ " where to put undo files
        set undofile " persistent undo (between saves)
        set undolevels=1000 " persistent undo
        set undoreload=10000 " to undo forced reload with :e!
        set virtualedit=block " block mode, yey (onemore is evil)
        set wrap " wrap forever!
" }}}

" Line Numbering {{{
       set rnu
       set nu
" }}}

" {{{
        set foldmethod=indent
        set foldlevel=99
"}}}

" Wildmenu {{{
        set wildmenu " turn on command line completion wild style
        set wildignore=*.a,*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
        set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
        set wildignore+=*.DS_Store " OSX bullshit
        set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
        set wildignore+=*.luac " Lua byte code
        set wildignore+=migrations " Django migrations
        set wildignore+=*.orig " Merge resolution file
        set wildignore+=*.pdf,*.zip,*.so " binaries
        set wildignore+=*.pyc,*.pyo " Python byte code
        set wildignore+=*.spl " compiled spelling word lists
        set wildignore+=*.swp,*.bak " ignore these
        set wildignore+=*.sw? " Vim swap files
        set wildignore+=**/vendor " Ignore vendor directory
        if s:running_windows
                set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*,*\\bin\\*,*\\pkg\\*,*\\vendor\\*
        else
                set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/bin/*,*/pkg/*,*/vendor/*
        endif
        set wildmode=list:longest " turn on wild mode full match only
" }}}

" VimInfo {{{
        set viminfo=!,h,'500 " include uppercase registers, disable hlsearch while loading viminfo, remember marks for last 500 files
        set viminfo+=<10000 " remember up to 10000 lines in each register
        set viminfo+=s1000 " remember up to 1MB in each register
        set viminfo+=/1000 " remember last 1000 search patterns
        set viminfo+=:1000 " remember last 1000 commands
" }}}

" FormatOptions {{{
        set formatoptions=q " allow gq to work on comment
        set formatoptions+=r " enter extends comments
        set formatoptions+=n " format numbered lists using 'formatlistpat'
        set formatoptions+=1 " don't break after one letter word
        set formatoptions+=j " remove comment when joining lines
" }}}

" WhichWrap {{{
        set whichwrap=b " <bs> normal and visual
        set whichwrap+=s " <space> normal and visual
        set whichwrap+=h " normal and visual (not recommended)
        set whichwrap+=l " normal and visual (not recommended)
        set whichwrap+=< " <left> normal and visual
        set whichwrap+=> " <right> normal and visual
        set whichwrap+=~ " normal
        set whichwrap+=[ " insert and replace
        set whichwrap+=] " insert and replace
" }}}

" Mousing {{{
        if has('mouse')
                set mouse=a " use mouse everywhere
                set nomousehide " don't hide the mouse
                if !has('nvim')
                        set ttymouse=xterm2
                endif
                " allows clicking after the 223rd column
                if has('mouse_sgr')
                        set ttymouse=sgr
                endif
        endif
" }}}

" Theme and Colors {{{
        colorscheme desert
        syntax on
        set background=dark
" }}}

" vim: foldmethod=marker:sw=8:
