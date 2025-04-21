#!/bin/bash

UFW_config_hardenning(){

	#Si ufw n'est pas installer, l'installer
	if ! command -v ufw > /dev/null; then
        sudo apt install -y ufw;
    fi
		# command Execute la commande.
		# v Vérifie si la commande existe
		
	# Activation du pare feu
	ufw default deny incoming
	ufw default allow outgoing

	ufw allow ssh
	ufw enable

}

