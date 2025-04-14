#!/bin/bash

installufw(){
    # Installation du Firewall UFW
    echo 'Installation du paquet ufw'
    apt-get install ufw -y
}

ufwconf(){
    # Activer les logs de UFW
    echo 'Mise en place des logs ufw'
    ufw logging on 

    # Refuser le traffic entrant par defaut
    echo 'Refus du traffic entrant par defaut'
    ufw default deny incoming 

    # Autoriser le traffic sortant par defaut
    echo 'Autorise le traffic sortant par defaut'
    ufw default allow outgoing 

    # Autoriser le port SSH en entree
    echo 'IAutorise le port SSH en entree'
    ufw allow in ssh 

    # Autoriser le port HTTPS en entree
    echo 'Autorise le port HTTPS en entree'
    ufw allow in https

    # Autoriser le port HTTP en entree
    echo 'Autorise le port HTTP en entree'
    ufw allow in http 

}

ufwreload(){
    # On reload le service pour pouvoir prendre en compte les modifications
    echo 'Application des modifications ufw'
    ufw reload 
}

ufwenable(){
    # On enable le service pour qu'il demarre au demarrage automatiquement
    echo 'Configuration du demarrage automatique de ufw'
    ufw enable 
}