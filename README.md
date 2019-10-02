# Tips and Tricks of the Trade

This guide is an ever growing list of issues or setups I personally encounter frequently enough to document here, but unfrequently enough that I forget them otherwise. 

# Terminal Vim

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




# Jupyter Setup

This guide sets you up for working in IPython with Jupyter using VIM commands, with a few personalized modifications.  You can get more info by going to the specific sites, but these are too wordy and cumbersom for a quick setup.


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

# Virtual Environments

If you want to work with a virtual env (which you absolutely should if you're not using a containerized solution), run these commands:

```bash
NEWENVNAME=envname
NEWENV_PYTHON_VERSION=python3.6

pip3 install virtualenv
virtualenv --python=$NEWENV_PYTHON_VERSION $NEWENVNAME
source $NEWENVNAME/bin/activate
...
python3 -m pip install ipykernel
python -m ipykernel install --user --name $NEWENVNAME --display-name "$NEWENVNAME"
...
deactivate
```


#### Jupyter and Virtual Envs

Sometimes the jupyter notebook kernel doesn't start where it should be (`sys.executable` returns the wrong python kernel). This is because our kernel list isn't updated properly. To do so, go to `~/.local/share/jupyter/kernels/{envname}/kernel.json` and change the first parameter in the `argv` list to the python path in your specific kernel.

```python
  {
   argv: [
    {/path/to/kernel/environment/folder}/bin/python,
    -m,
    ipykernel_launcher,
    -f,
    {connection_file}
   ],
   display_name: env-proprog,
   language: python
 }
```

# SSH Keys
[Guide for this.](https://coderwall.com/p/7smjkq/multiple-ssh-keys-for-different-accounts-on-github-or-gitlab)

Generate the SSH key you want to use with the following command:

```bash
$ ssh-keygen -t rsa -C "your_name@email_domain.com"
```
Make sure the key is cached by typing:
```bash
$ ssh-add -l
```
If no keys appear, then add the key by typing:
```bash
$ ssh-add ~/.ssh/id_rsa
```

To have all connections linked to the same id_rsa key, add this line of code to `~/.ssh/config`:

```config
Host *
    AddKeysToAgent yes
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa
```

Lastly, check that the connections work:

```bash
$ ssh -T git@github.com
Hi {user}! You've successfully authenticated, but GiHub does not provide shell access.
$ ssh -T git@gitlab.work.io
Welcome to GitLab, @{user}!
```


# Docker

## Installing Docker
If you wish to install docker, run the following commands:
* `wget get.docker.com -O get_docker.sh`
* `sh get_docker.sh`
* Config @ bottom to log in.

## Managing Docker Images

Every time the docker image is {re}built, run this from the main directory (the one with `Dockerfile`):
```
$docker build -t {new_image_name} .
```

And then run this command where the `docker-compose.yml` file is:
```
$docker-compose up
```

If you're pulling from an aws image to build the docker image at hand, make sure you've already set up aws on your machine, and type 
```
$(aws ecr get-login --no-include-email)
```
Lastly, make sure to visit `docker/.env` folder and set your environment variables right!

If you're using **PyCharm**, go to Settings -> Project -> Project Interpreter -> Docker -> Image Name: {YOUR IMAGE}

### Some more helpful Docker commands

* Use `docker ps` to get the name of the existing containers.
* Use the command `docker exec -it <container name> /bin/bash` to get a bash shell in the container

# ZSH Installation

A Power Shell is a huge timesaver.  It'll help you navigate through files a lot faster with nice autocomplete, amongst other features.  

### Quick Install
1. Install zsh from [here](https://www.howtoforge.com/tutorial/how-to-setup-zsh-and-oh-my-zsh-on-linux/)




# AWS Instance

First things first, to tunnel into your aws instance, type this:

```bash
ssh -i "PEM.pem" -L {YOUR_PORT_NUMBER}:localhost:{EC2_PORT_NUMBER} ubuntu@ec2-YOUR-EC2-ROUTE-.amazonaws.com
```

If you'd like to mount an efs on your aws:
1. install awscli: `pip install awscli --upgrade --user`
2. Change the config file with `awscli configure`.
3. Change the security group of your ec2 instance to add the efs following the instructions in the efs page.


### Working with Keys

Set environment variables in the `~/.bash_profile` by typing `export {variable}='{definition}'` and then do `source ~/.bash_profile` to update the source.

### Boto3 and S3 Readings
Refer to the `s3manager.py` file for a simple way to read and write to s3.

#### To write a file:
You first need to establish your credentials in `~/.aws/credentials`:

```bash
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

and in `~/.aws/config` add:

```bash
[default]
region = YOUR_PREFERRED_REGION
```

where you can find the regions [here](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region).


If you want to add the credentials to your local notebook, add

```python
s3 = boto3.client('s3', 
                  aws_access_key_id= "YOUR_ACCESS_KEY_ID",
                  aws_secret_access_key = "YOUR_SECRET_ACCESS_KEY")
```


Finally, to upload, type:
```python

bucketName = "Your S3 BucketName"
Key = "Original Name and type of the file you want to upload into s3"
outPutname = "Output file name(The name you want to give to the file after we upload to s3)"

import pickle
pickle.dump(data, open("tmp.pckl", 'wb'))

s3 = boto3.client('s3')
s3.upload_file("tmp.pckl", bucketName, outPutname)

!rm tmp.pckl
```



#### To load a file:

```python
import boto3
BUCKET_NAME='{BUCKETNAME}'

client = boto3.client('s3') #low-level functional API
resource = boto3.resource('s3') #high-level object-oriented API
bucket = resource.Bucket(BUCKET_NAME) #subsitute this for your s3 bucket name. 

for x in bucket.objects.filter(Prefix='{DATAPATH_OF_FILE}').all():
    files.append(x)
    
file = [x.key for x in files if x.key.endswith('.csv')][0] ## Read the csv file only.
obj = client.get_object(Bucket=BUCKET_NAME, Key=file)
df_raw = pd.read_csv(obj['Body'])
```
Or to download a file:
```python
BUCKET_NAME='{BUCKETNAME}'


s3_resource.Object(BUCKET_NAME, first_file_name).download_file(
    f'/tmp/{first_file_name}') # Python 3.6+
```


# Distribution Wheels

This is a guide to create a wheel and install it locally. For PyPI distributions, see [here](https://packaging.python.org/tutorials/packaging-projects/).

Make sure the appropriate folders to be included to the distribution wheel all contain an `__init__.py` file, which can be empty.

To do this, you'll need to install the `setuptools wheel` package from `pip`:

```bash
python3 -m pip install --user --upgrade setuptools wheel
```

### setup.py file

First, add a `setup.py` file in the root folder, which should look something like this:

```python
import setuptools

setuptools.setup(
    name="example-pkg-your-username",
    version="0.0.1",
    author="Example Author",
    author_email="author@example.com",
    description="A small example package",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/pypa/sampleproject",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
)
```

### Generating the wheel

Run this command:
```bash
python3 setup.py sdist bdist_wheel
```

and make sure that the dist folder looks as follows:
```bash
dist/
  example_pkg_your_username-0.0.1-py3-none-any.whl
  example_pkg_your_username-0.0.1.tar.gz
```

Now install the package to your local env.
```bash
# If already installed, make sure to uninstall so package can be updated.
pip uninstall dist/example_pkg_your_username-0.0.1-py3.none.any.whl
pip install dist/example_pkg_your_username-0.0.1-py3.none.any.whl
```


# Arch Linux

I've started to use ArchLinux at work and it's perfect for it. It has all you need, and nothing more.

## Mapping CapsLock to Ctrl
First thing I do when using a new ArchLinux computer is to map the `CapsLock` key to `Ctrl`. To do this, add the following to `~/.Xmodmap`

```bash
clear lock
clear control
keycode 66 = Control_L
add control = Control_L Control_R
```
and execute it typing `xmodmap ~/.Xmodmap`.


## Baloo File Extractor

Sometimes, the computer will start to lag for no apparent reason. Upon inspecting the computer processes, one may find that the `baloo_file_extractor` is taking up a substantial amount of CPU power. The `baloo_file_extractor` indexes the files on the computer for easy searching, but the process is so slow it makes the computer extremely painful to use. So, there are two things you must do. If you run into this problem, first type `balooctl disable,` then you'll have to restart the computer (Sorry!), and finally enable it again on startup with `balooctl enable`.  Some blogs say to disable balooctl altogether writing `Indexing-Enabled=false` in  `~/.kde4/share/config/baloofilerc`.

## Disk Full

My disk often gets full without downloading any large files. Although I haven't found a method to systematically stop this from happening, I often run these diagnostic tools in order to fix the issue.

1. Type `df -h` to get a report of the Filesystem's usage.

```bash
Filesystem      Size  Used Avail Use% Mounted on
dev              16G     0   16G   0% /dev
run              16G  9.4M   16G   1% /run
/dev/sda6       283G  141G  128G  53% /
tmpfs            16G  576M   16G   4% /dev/shm
tmpfs            16G     0   16G   0% /sys/fs/cgroup
tmpfs            16G  6.7M   16G   1% /tmp
tmpfs           3.2G   32K  3.2G   1% /run/user/1000
```

The plcae that was hogging most of my disk space was in `logs`, so check there first:

```
du -h /var/log
```
If so, then type
```
sudo rm -vfr /var/log && sudo mkdir /var/log
```






