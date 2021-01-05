#!/bin/bash
export PROFILE_SCRIPT=$HOME/.bashrc
export PROFILE=$HOME/.profile

# Ensure that have loaded the most recent profile script
. $PROFILE_SCRIPT

# Update sources
sudo apt-get update

# Install xclip and set aliases for `copy` and `paste`
if [[ -z $(which xclip) ]]
then
    sudo apt-get install xclip -y
    echo "alias copy='xclip -selection clipboard'" >> $PROFILE_SCRIPT
    echo "alias paste='xclip -selection clipboard -o'" >> $PROFILE_SCRIPT
fi

# Install docker
if [[ -z $(which docker) ]]
then
    # Remove old versions
    sudo apt-get remove docker docker-engine docker.io
    # Requirements for docker, should have them anyways
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

CHKSUM="pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22"
        echo "PLEASE CHECK THAT THE FOLLOWING MATCH"
        echo $CHKSUM
        sudo apt-key fingerprint 0EBFCD88
        echo "Type anything to continue.."
        read
        # Add the docker repository
        sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
        sudo apt-get update
        sudo apt-get install docker-ce -y
        sudo usermod -aG docker $USER
fi

# Set up bash to ignore commands that start with a space
if [[ -z $HISTCONTROL ]]
then
    echo "Setting up history control to ignore commands that start with a space"
    echo "export HISTCONTROL='ignorespace'" >> $PROFILE_SCRIPT
fi

if [ ! -f ~/.vimrc ]
then
    echo "Making sure that vim-full is installed"
    sudo apt-get install vim
    echo "Setting up the vimrc file"
    cp .vimrc ~/.vimrc
fi

if [ ! -f ~/.ssh/id_rsa.pub ]
then
    ssh-keygen
fi

if [[ -z $(which blz) ]]
then
    curl https://blazingk.in/install_blz_unix.sh | bash
fi

if [[ -z $EDITOR ]]
then
    if [ -n $(which snap) ]
    then
        snap install --classic code
        echo "Setting up editor to be vscode"
        echo "export EDITOR='code --wait'" >> $PROFILE_SCRIPT
    fi
fi

if [[ -z $BROWSER ]]
then
    if [ -n $(which firefox-trunk) ]
    then
    echo "Setting up browser to be firefox-trunk"
    echo "export BROWSER=firefox-trunk" >> $PROFILE_SCRIPT
    echo "export MOZ_WEBRENDER=1" >> $PROFILE
    elif [ -n $(which firefox) ]
    then
    echo "Setting up browser to be firefox"
    echo "export BROWSER=firefox" >> $PROFILE_SCRIPT
    fi
fi


if [[ -z $(grep shutdown $PROFILE_SCRIPT) ]]
then
    echo "Setting up shutdown to not print annoying messages"
    echo 'alias shutdown="shutdown --no-wall"' >> $PROFILE_SCRIPT
fi

. ruby_setup.sh

