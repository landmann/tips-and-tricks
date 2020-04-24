

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


