# vim-setup





# Jupyter Setup

This guide sets you up for working in IPython with Jupyter using VIM commands, with a few modifications for personalization.  You can get more info by going to the specific sites, but these are too wordy and cumbersom for a quick setup.

<ol>
<li> Install <a href=https://github.com/ipython-contrib/jupyter_contrib_nbextensions#installation>nbextensions</a> :</li>

```bash  
pip install jupyter_contrib_nbextensions`        
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
```

<li> Install <a href=https://github.com/lambdalisue/jupyter-vim-binding/wiki/Installation>VIM bindings</a> :</li>
  
```bash
# You may need the following to create the directoy
mkdir -p $(jupyter --data-dir)/nbextensions
# Now clone the repository
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
chmod -R go-w vim_binding
```
  
</ol>
