set nocompatible
filetype off

set splitright
set undofile

" Keep Plugin commands between vundel#begin/end.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree.git'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'Yggdroot/indentLine'
call vundle#end()

execute pathogen#infect()
set background=dark

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

""To abbreviate things: abbr pn penguin

inoremap jk <ESC>
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set nocompatible
set number

""" Managing other people's code with tabs
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \w setlocal wrap!<CR>:setlocal wrap?<CR>

"move down one line only, regardless of wrapped around lines
nnoremap j gj
nnoremap k gk

"Move between windows
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

"Toggle line numbers:
nmap \l :setlocal number!<CR>
"Toggle paste mode:
nmap \o :set paste!<CR>
"Change between files
nmap <C-e> :e#<CR>
"Cycle through files
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>
"Lets you back up to previous file with Ctrl-E
"   To get to another file type :e something.py
nmap <C-e> :e#<CR>

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-tab> <gv

set incsearch
set ignorecase "Ignores case
set smartcase "Unless CAPS
set hlsearch
" Clear highlights
nmap \q :nohlsearch<CR>
set autowrite

""" Incsearch: Search Mappings
""" map /  <Plug>(incsearch-forward)
""" map ?  <Plug>(incsearch-backward)
""" map g/ <Plug>(incsearch-stay)

""" Ctrlp: mappings to quickly switch between files
nmap ; :CtrlPBuffer<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

""" NERDTree: for file naviation
nmap \e :NERDTreeToggle<CR>

""" Jedi: Commands for autofills
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = 'right'

""" Syntastic: the linter.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"indentLine
let g:indentLine_setColors = 0

"Emacs style movement
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Delete>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <M-d> <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g> <C-c>






