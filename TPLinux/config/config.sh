#!/bin/bash

config(){

    sudo apt-get update > /dev/null 2>&1
    sudo apt-get install openssh-server ufw libpam-google-authenticator unattended-upgrades -y > /dev/null 2>&1

# Création du répertoire .ssh s'il n'existe pas
        if [ ! -d "$HOME/.ssh" ]; then
            echo "Création du répertoire ~/.ssh..."
            mkdir -p "$HOME/.ssh"
            chmod 700 "$HOME/.ssh"
        fi

}
