#!/bin/bash

# Installation de UFW

configure_ufw() {

    if ! command -v ufw &> /dev/null; then

        echo "Installation de UFW"

        apt-get update && apt-get install -y ufw

    else
        echo "UFW est déja installé"
        exit 1
    fi

    echo "Activation de UFW"

    ufw enable

    # Config des régles par défaut

    echo "Configuration des règles par défaut"

    ufw default deny incoming    # Bloquer les connexions entrantes
    ufw default allow outgoing   # Autoriser les connexions sortantes

    # Autoriser les connexions SSH
    echo "Autorisation des connexions SSH..."
    ufw allow ssh

    # Autoriser les connexions HTTP (port 80)
    echo "Autorisation des connexions HTTP..."
    ufw allow http

    # Autoriser les connexions HTTPS (port 443)
    echo "Autorisation des connexions HTTPS..."
    ufw allow https

    # Vérification du statut du pare-feu
    echo "Statut de UFW"
    ufw status verbose

    echo "Installation et configuration de UFW terminées."
}

configure_ufw