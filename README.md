# Tips and Tricks of the Trade

This guide is an ever growing list of issues or setups I personally encounter frequently enough to document here, but unfrequently enough that I forget them otherwise.  Feel free to browse!

# ZSH Installation

A Power Shell is a huge timesaver.  It'll help you navigate through files a lot faster with nice autocomplete, amongst other features.  

### Quick Install
1. Install zsh from [here](https://www.howtoforge.com/tutorial/how-to-setup-zsh-and-oh-my-zsh-on-linux/)
2. Install the theme [here](https://github.com/romkatv/powerlevel10k#installation)

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
 "argv": [
  "path/to/kernel/python",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "Python 3 (ipykernel)",
 "language": "python",
 "metadata": {
  "debugger": true
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

## Viewing Jupyter Notebooks Locally from a Remote Machine

Jupyter notebook development is becoming the de-facto research environment. To work with Jupyter notebooks remotely, one must tunnel the output of jupyter to view it on a local browser. You can also use a reverse proxy, but I find this more troublesome.

```bash
ssh username@xx.xx.xx.xx -L 1234:localhost:1234
```

In the code above, data outgoing to port `1234` will be forwarded to `localhost:1234` from the remote system. The `L` is used to specify the port to forward data to.

Once you're in the machine, start the jupyter notebook as such:

```bash
jupyter notebook --no-browser --port 1234
```
This will forward the output of the jupyter notebook to the port specified.
