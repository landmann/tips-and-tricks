# Jupyter Setup

This guide sets you up for working in IPython with Jupyter using VIM commands, with a few personalized modifications.  You can get more info by going to the specific sites, but these are too wordy and cumbersom for a quick setup.

## TL;DR

If you spin up an instance, this will get you up and running immediately.

```
# Install jupyter nbextensions
python -m pip install jupyter_contrib_nbextensions && \
    python -m pip install jupyter_dashboards && \
    python -m pip install jupyter_nbextensions_configurator && \
    jupyter contrib nbextension install --user &&\
    jupyter nbextensions_configurator enable --user &&\
    jupyter nbextension install --py jupyter_dashboards --sys-prefix

# Install and enable vim extensions
mkdir -p $(jupyter --data-dir)/nbextensions && \
    git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding


chmod -R go-w $(jupyter --data-dir)/nbextensions/vim_binding
jupyter nbextension enable code_prettify/code_prettify && \
    jupyter nbextension enable select_keymap/main && \
    jupyter nbextension enable vim_binding/vim_binding && \
    jupyter nbextension enable ruler/main && \
    jupyter nbextension enable --py jupyter_dashboards --sys-prefix && \
    jupyter nbextension enable --py widgetsnbextension && \
    jupyter nbextension enable execute_time/ExecuteTime

RUN jupyter lab build

# Load up vim customization
mkdir ~/.jupyter/custom
wget -P ~/.jupyter/custom/ https://raw.githubusercontent.com/landmann/tips-and-tricks/master/jupyter-setup/custom/custom.css
wget -P ~/.jupyter/custom/ https://raw.githubusercontent.com/landmann/tips-and-tricks/master/jupyter-setup/custom/custom.js
```


#### 0. Useful code

<b> Notebook Immediate Reload</b>
Use this decorator so that when something changes in the module it is immediately reflected on the notebook.
```python
# These reload the functions - change something on the imported files and 
#  %autoreload 2 will reload all modules (except those excluded by %aimport) 
#  every time before executing the Python code typed.
%load_ext autoreload
%autoreload 2
```
<b> Appending Parent Path </b>



#### 1. Install <a href=https://github.com/ipython-contrib/jupyter_contrib_nbextensions#installation>nbextensions</a> :

```bash  
pip install jupyter_contrib_nbextensions
pip install jupyter_nbextensions_configurator
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
```

The extensions I use are: 

<ul>
<li>Ruler</li>
<li>ExecuteTime</li>
<li>VIM binding (below)</li>
<li>Nbextensions edit menu item</li>
</ul>

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

#### 3. Add a <a href=https://github.com/dunovank/jupyter-themes>jupyter theme</a>

Install the themes with

```bash
pip install jupyterthemes
```
and include the dark style that suits you best. Here's the author's and what I currently use:
```bash
jt -t onedork -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T
```



#### 4. Configure <a href=https://github.com/lambdalisue/jupyter-vim-binding#customization>Mappings</a> 
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
Now, in vim, type `:set paste` and paste this at the end of the file:
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
    // Allow Ctrl-shift-c to interrupt kernel
    km.edit_shortcuts.add_shortcut('ctrl-shift-c', 'jupyter-notebook:interrupt-kernel', true);
    
    // Update Help
    km.edit_shortcuts.events.trigger('rebuild.QuickHelp');
  });
});
```
In the same folder, type 
```bash
vim ~/.jupyter/custom/custom.css
```

and enter this for prettier colors. Add it at the end of the file too, right before `<script>`:

```css
/* Jupyter cell is in normal mode when code mirror */
.edit_mode .cell.selected .CodeMirror-focused.cm-fat-cursor {
/*For white backgrounds, use #F0F8FF: */
  /*background-color: #F5F6EB !important;*/ 
    background-color: #232e3f !important;
}

/* Jupyter cell is in insert mode when code mirror */
.edit_mode .cell.selected .CodeMirror-focused:not(.cm-fat-cursor) {
/*For white backgrounds, use #F0F8FF: */
/*background-color: #F0F8FF !important;*/ 
  background-color: #273345 !important;
}
```
#### 5. Plotting

Last but not least, we should change the way things are plotted. To do this, include the following two lines in `~/.ipython/profile_default/startup/startup.ipy` file to set plotting style automatically whenever you start a notebook:

```python
# import jtplot submodule from jupyterthemes
from jupyterthemes import jtplot

# currently installed theme will be used to
# set plot style if no arguments provided
jtplot.style(theme='onedork', figsize=(18, 10), fscale=1.4, context='talk', ticks=True)
```

Refer to this [manual](https://github.com/dunovank/jupyter-themes#set-plotting-style-from-within-notebook) for more info.
