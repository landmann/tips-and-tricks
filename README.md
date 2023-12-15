# Tips and Tricks of the Trade

This guide is an ever growing list of issues or setups I personally encounter frequently enough to document here, but unfrequently enough that I forget them otherwise.  Feel free to browse!

# ZSH Installation

A Power Shell is a huge timesaver.  It'll help you navigate through files a lot faster with nice autocomplete, amongst other features.  

### Quick Install
1. Install zsh from [here](https://www.howtoforge.com/tutorial/how-to-setup-zsh-and-oh-my-zsh-on-linux/)
2. Install the theme [here](https://github.com/romkatv/powerlevel10k#installation)

# Brand new ec2 instance for ML research!

In order to do ML research, choose a `g5.large` with at least 50 GB of storage (just installing diffusers and pytorch is half of that). It'll be quite expensive, so remember to stop the machine 

I prefer to start with an ubuntu machine as the aws instance comes with CentOS I believe. The aws instance has performance improvements, but for jupyter notebook work it shouldn't matter.

Once you're set up, `ssh` into the machine and let's get started!

0. First things first, if you're gonna use a notebook, this will save you a lot of trouble:

```
echo "alias start='source myenv/bin/activate" >> ~/.bashrc
echo "alias jupyter='jupyter notebook --no-browser --port 1234'" >> ~/.bashrc
source ~/.bashrc
```

1. Get your machine up to date on the latest packages:

```
sudo apt update
sudo apt upgrade -y
sudo apt install git 
sudo apt install gh
gh auth login
```
It'll ask you to reboot the machine. Go do it.

2. Install Python. This should install the latest distribution.

```
sudo apt install python3 python3-pip build-essential libssl-dev libffi-dev python3-dev pkg-config
```
3. Install a virtual environment (you can see below for more details)

Note that `pip3` and `pip` are the same :) 
```
sudo apt install python3.10-venv
pip3 install virtualenv
python3 -m venv myenv
source myenv/bin/activate

```
And voila - you should be in the env. Now come the packages...

4. Install all the pip menagerie

```
pip install numpy pandas scipy matplotlib scikit-learn tensorflow jupyter awscli jupyterlab-vim boto3 python-dotenv tqdm openai opencv-python Pillow diffusers transformers accelerate safetensors pytz boto3 rsa python-dotenv omegaconf mediapipe opencv-python-headless
aws configure
python -m ipykernel install --user --name=myenv --display-name="MyProject"
```

5. And lastly, some cuda stuffs! First, check if you have GPUs with `lspci`. If you do have an NVIDIA GPU (mine shows like this: 00:1e.0 3D controller: NVIDIA Corporation GA102GL [A10G] (rev a1)), do the below, which I got from [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-nvidia-driver.html)
```
sudo apt install nvidia-cuda-toolkit
sudo apt-get upgrade -y linux-aws
sudo apt-get install -y gcc make linux-headers-$(uname -r)
cat << EOF | sudo tee --append /etc/modprobe.d/blacklist.conf
GRUB_CMDLINE_LINUX="rdblacklist=nouveau"
sudo update-grub
aws s3 cp --recursive s3://ec2-linux-nvidia-drivers/latest/ .
chmod +x NVIDIA-Linux-x86_64*.run
sudo /bin/sh ./NVIDIA-Linux-x86_64*.run
sudo touch /etc/modprobe.d/nvidia.conf
echo "options nvidia NVreg_EnableGpuFirmware=0" | sudo tee --append /etc/modprobe.d/nvidia.conf

nvidia-smi -q | head
```
And that's it! Now go ahead and fully reboot the instance...

```
sudo reboot
```


# Virtual Environments

If you want to work with a virtual env (which you absolutely should if you're not using a containerized solution), run these commands:

```bash
NEWENVNAME=tryiton
NEWENV_PYTHON_VERSION=python3.11

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
