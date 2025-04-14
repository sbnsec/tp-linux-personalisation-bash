#!/bin/bash

update_upgrade(){

    # Mise a  jour des paquets et du systeme avec le paramètre -y pour automatiquement accepter les
    # propositions interactives de l'invite de commande
    echo "Mise a jour du systeme"
    apt-get update -y
    apt-get upgrade -y 

}