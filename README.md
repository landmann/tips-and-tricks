# vim-setup

My vimrc is a combination of many things I've read in the iternet that have worked very well for my purposes.  Here's a list of the things I've read that have changed my setup. You can find the vimrc file [here](https://github.com/landmann/vim-setup/blob/master/.vimrc).

### From Ian Langworth's ['Vim After 11 Years'](https://statico.github.io/vim.html)

- He uses backslash '\' quite extensively in his vim mode. For example, `\o` toggles paste mode and `\l` toggles line numbers:

  `nmap \l :setlocal number!<CR>`<br>
  `nmap \o :set paste!<CR>`


- <b>Scrolling through wrapped around text</b>

  `nnoremap j gj`<br>
  `nnoremap k gk`<br>

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




# Jupyter Setup

This guide sets you up for working in IPython with Jupyter using VIM commands, with a few personalized modifications.  You can get more info by going to the specific sites, but these are too wordy and cumbersom for a quick setup.


#### 1. Install <a href=https://github.com/ipython-contrib/jupyter_contrib_nbextensions#installation>nbextensions</a> :

```bash  
pip install jupyter_contrib_nbextensions
pip install jupyter_nbextensions_configurator
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
```

#### 2. Install <a href=https://github.com/lambdalisue/jupyter-vim-binding/wiki/Installation>Vim bindings</a> :
  
```bash
# You may need the following to create the directoy
mkdir -p $(jupyter --data-dir)/nbextensions
# Now clone the repository
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
chmod -R go-w vim_binding
```
[Re]Start your jupyter notebooks and make sure you can see the nbextensions tab at the tree folder's bar (right under Jupyter).  It should say <i>Files -- Running -- Clusters -- Nbextensions</i>

#### 3. Configure <a href=https://github.com/lambdalisue/jupyter-vim-binding#customization>Mappings</a> 
Now we are going to modify jupyter's config file.

`ls ~/.jupyter/custom`

If it exists, then type:

```bash
vim ~/.jupyter/custom/custom.js
```
Else, type
```bash
mkdir ~/.jupyter/custom
vim ~/.jupyter/custom/custom.js
```
Now, in vim, type `:set paste` and paste this
```bash
// Configure CodeMirror Keymap
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Map jk to <Esc>
  CodeMirror.Vim.map("jk", "<Esc>", "insert");
  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
  CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
  CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");
});

// Configure Jupyter Keymap
require([
  'nbextensions/vim_binding/vim_binding',
  'base/js/namespace',
], function(vim_binding, ns) {
  // Add post callback
  vim_binding.on_ready_callbacks.push(function(){
    var km = ns.keyboard_manager;
    
    // Allow Ctrl-1 to change the cell mode into Code in Vim normal mode
    km.edit_shortcuts.add_shortcut('ctrl-1', 'vim-binding:change-cell-to-code', true);
    // Allow Ctrl-2 to change the cell mode into Markdown in Vim normal mode
    km.edit_shortcuts.add_shortcut('ctrl-2', 'vim-binding:change-cell-to-markdown', true);
    // Allow Ctrl-3 to change the cell mode into Raw in Vim normal mode
    km.edit_shortcuts.add_shortcut('ctrl-3', 'vim-binding:change-cell-to-raw', true);
    
    // Update Help
    km.edit_shortcuts.events.trigger('rebuild.QuickHelp');
  });
});
```
In the same folder, type 
```bash
vim ~/.jupyter/custom/custom.css
```

and enter this for prettier colors:
```css
/* Jupyter cell is in normal mode when code mirror */
.edit_mode .cell.selected .CodeMirror-focused.cm-fat-cursor {
  /*background-color: #F5F6EB !important; */
    background-color: #F5F6EB !important;
}
/* Jupyter cell is in insert mode when code mirror */
.edit_mode .cell.selected .CodeMirror-focused:not(.cm-fat-cursor) {
  background-color: #F0F8FF !important;
}
```
