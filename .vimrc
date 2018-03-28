execute pathogen#infect()
set background=dark

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

"Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k


inoremap jk <ESC>
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set nocompatible
set number

"move down one line only, regardless of wrapped around lines
nmap j gj
nmap k gk

set incsearch
set ignorecase "Ignores case
set smartcase "Unless CAPS
set hlsearch
set autowrite


"Lets you back up to previous file with Ctrl-E
"   To get to another file type :e something.py
nmap <C-e> :e#<CR>

"Open up a NERDTree
nmap \e :NERDTreeToggle<CR>



"Syntastic commands
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)








