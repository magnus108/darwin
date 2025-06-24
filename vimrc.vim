syntax on


filetype plugin indent on

let mapleader = " "

set cursorline
set autoindent
set autoread
set background=dark
set colorcolumn=80
set backspace=indent,eol,start
"set completeopt=menuone,longest,preview
set completeopt=longest
set confirm
set copyindent
set history=5000
set hlsearch
set ignorecase
set incsearch
set infercase
set laststatus=2
set list
set listchars=tab:>-,trail:-,precedes:<,extends:>
set magic
set nofoldenable
set nolinebreak
set number
set relativenumber
set ruler
set rulerformat=%c\ %L\ %P
set showmatch
set showmode
set showtabline=1
set smartcase
set smarttab
set expandtab
set tabstop=2
set shiftround
set shiftwidth=2
set preserveindent
set spell
set startofline
set swapfile
set backupdir=~/.vim/backupdir
set dir=~/.cache/vim
set title
set undolevels=5000
set undofile
set undodir=~/.vim/undodir
set noerrorbells
set visualbell
set wildmenu
set nowrap
set timeoutlen=500

autocmd CursorMoved * normal zz


let g:tmux_navigator_no_mappings = 1

let g:cursorhold_updatetime = 100

let g:auto_session_pre_save_cmds = ["tabdo NERDTreeClose"]
