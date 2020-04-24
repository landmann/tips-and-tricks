# My Vim Setup

My vimrc is a combination of many things I've read in the iternet that have worked very well for my purposes.  Here's a list of the things I've read that have changed my setup. You may add the contents of this repo into the home directory, `~/.` and follow the instructions on [Quick Install](https://github.com/landmann/vim-setup#quick-install) to install vim on terminal. I have not provided a file for jupyter in this directory, but you can find the code in the Jupyter section below.

### Quick Install

- Type `locate .vimrc` and clone the contents of this repo into said directory. If it doesn't exist, you can just download it in the home directory, `~/.`.
- Install Pathogen, as described [here](https://github.com/tpope/vim-pathogen).<br>
  -TL;DR:
  ```
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  ```
- Install Vundle as described [here](https://github.com/VundleVim/Vundle.vim).<br>
  -TD;DR:
  ```
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  ```
    - Launch vim and run `:PluginInstall`
    - To install from command line: `vim +PluginInstall +qall`

- Type `source ~/.bashrc` if you're having any issues with these installations to make sure your bash has been updated after these were processed.
- This one is used quite a bit too: https://github.com/xolox/vim-notes

### From Ian Langworth's ['Vim After 11 Years'](https://statico.github.io/vim.html)

- He uses backslash '\' quite extensively in his vim mode. For example, `\o` toggles paste mode and `\l` toggles line numbers:

```
  nmap \l :setlocal number!<CR>
  nmap \o :set paste!<CR>
```

- <b>Scrolling through wrapped around text</b>

```
nnoremap j gj
nnoremap k gk
```

- If you like Emacs-style movements, he proposes some. I don't use them.

- To <b>search</b> for text, he uses the following defaults

  `set incsearch "Option highlights as you type an expression`<br>
  `set ignorecase "Ignores cases`<br>
  `set smartcase "Makes search case sensitive (mostly when search includes caps)`<br>
  `set hlsearch "highlights current search`<br>
  `nmap \q :nohlsearch<CR> "Gets rid of the colored highlighting`<br>

- <b>Changing Between Files</b> after you've already opened some using `:e other_file.py`

   `nmap <C-e> :e#<CR> "changes to the file in the buffer`<br>
   `nmap <C-n> :bnext<CR> "cycles to the next file`<br>
   `nmap <C-p> :bprev<CR> "cycles to previous file`<br>

- A linter will highlights errors for you at compile time. Use [Syntastic](https://github.com/vim-syntastic/syntastic) to handle these.

- Change files quickly with [Ctrl-P](http://kien.github.io/ctrlp.vim/)

   `nmap ; :CtrlPBuffer<CR>"Launch the Ctrl-P with ;`<br>
   `let g:ctrlp_map = '<Leader>t'`<br>
   `let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10 "Will put the buffer at the bottom of the window`<br>
   `let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'`<br>
   `let g:ctrlp_working_path_mode = 0`<br>
   `let g:ctrlp_dotfiles = 0`<br>
   `let g:ctrlp_switch_buffer = 0`<br>

- Use the [NERD Tree](http://www.vim.org/scripts/script.php?script_id=1658)

   `nmap \e :NERDTreeToggle<CR>"Will show you the NERDTree :D`<br>

- I use iTerm, so I believe you need this for nice colors:

```
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
   set t_Co=256
endif
```

- I use [Powerline](https://github.com/powerline/powerline) for pretty colors.

- Changing tabs to a uniform command

   `nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>`<br>
   `nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>`<br>
   `nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>`<br>
   `nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>`<br>
   `nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>`<br>

