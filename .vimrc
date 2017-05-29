" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================
set gfn=Fira\ Mono\ for\ Powerline:h13
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard=unnamed
set backspace=indent,eol,start
set laststatus=2
set background=dark
set relativenumber
set cursorline

" spelling check
set spelllang=en_us
set spell

" split
set splitbelow
set splitright

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" syntax and color theme
colo molokai
syntax on

" search and find files
set path+=**
set wildmenu

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif
au BufNewFile,BufRead *.vundle set filetype=vim

" =============== abbreviations Initialization ===============
if filereadable(expand("~/.vim/abbreviations.vim"))
  source ~/.vim/abbreviations.vim
endif

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set autowrite
set hlsearch
set incsearch
set textwidth=120
set pastetoggle=<f5>                    " To stop indenting when pasting with mouse

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" set wrap
set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ custom key mappings ===========================
let mapleader = ","                         " set highlight line toggle
nnoremap <Leader>cl :set cursorline!<CR>    " 'cl' to toggle highlighted current line

inoremap jk <esc>                     " instead of using Esc key use 'jk' in insert mode
inoremap kj <esc>                     " instead of using Esc key use 'kj' in insert mode
nnoremap ; :                          " ';' remap to ':' normal mode for ease
nnoremap - $                          " '$' remap to '-' normal mode for ease

nnoremap Q :q! <CR>                   " close file without saving 'shift+q'
nnoremap S :up <CR>                   " save file changes 'shift+s'
nnoremap W :wq <CR>                   " save and close file 'shift+q'
nnoremap dl :t. <CR>                  " duplicate line 'dl'

" move line up/down
nnoremap mj :m .+1<CR>==
nnoremap mk :m .-2<CR>==
inoremap mj <Esc>:m .+1<CR>==gi
inoremap mk <Esc>:m .-2<CR>==gi
vnoremap mj :m '>+1<CR>gv=gv
vnoremap mk :m '<-2<CR>gv=gv

" split view navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tabs navigation ctrl+t+arrow
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

map <C-\> :NERDTreeToggle<cr>                   " toggle nerd tree using 'ctrl+\'
