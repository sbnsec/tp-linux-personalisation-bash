#!/bin/bash

durcissement() {

    # Définition des variables 
    SSH_DIR="$HOME/.ssh"
    AUTH_KEYS="$SSH_DIR/authorized_keys"

    # Générer la clé SSH
    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -q
    if [ $? -ne 0 ]; then
        echo "Erreur lors de la génération de la clé SSH."
        return 1  # Retourne un code d'erreur
    fi

    # Accès clé privée réservé à l'utilisateur
    sudo chmod 600 $SSH_DIR/id_rsa

    # Création du groupe
    sudo groupadd ssh_login

    # Met l'utilisateur dans le groupe autorisé à faire du SSH
    sudo usermod -aG ssh_login $USER

    # Vérifier si la clé publique a bien été générée
    if [ -f "$SSH_DIR/id_rsa.pub" ]; then
        echo "Clé SSH générée avec succès."
    else
        echo "Erreur : la clé SSH n'a pas été générée."
        return 1  # Retourne un code d'erreur
    fi

    # Configuration SSH
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
    sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo sed -i '$ a AllowGroups ssh_login' /etc/ssh/sshd_config
}
