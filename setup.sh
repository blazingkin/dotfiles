#!/bin/bash
PROFILE_SCRIPT=$HOME/.bashrc

# Install xclip and set aliases for `copy` and `paste`
if [[ -z $(which xclip) ]]
then
    sudo apt-get install xclip -y
    echo "alias copy='xclip -selection clipboard'" >> $PROFILE_SCRIPT
    echo "alias paste='xclip -selection clipboard -o'" >> $PROFILE_SCRIPT
fi
