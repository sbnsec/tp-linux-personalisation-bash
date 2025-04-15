#!/bin/bash

auto(){
    # Modification du fichier 50unattended-upgrades pour mettre à jour uniquement les paquets de sécurité
    echo "Configuration des mises à jour automatiques de sécurité..."

    # Ajoute les nouvelles lignes de configuration pour la mise à jour quotidienne

    sudo touch /etc/apt/apt.conf.d/20auto-upgrades

    sudo chmod 777 /etc/apt/apt.conf.d/20auto-upgrades
    echo "APT::Periodic::Update-Package-Lists "1";" >> /etc/apt/apt.conf.d/20auto-upgrades
    echo "APT::Periodic::Unattended-Upgrade "1";" >> /etc/apt/apt.conf.d/20auto-upgrades
    sudo chmod 644 /etc/apt/apt.conf.d/20auto-upgrades

    # Redémarrage des services pour appliquer les changements
    echo "Activation et démarrage du service unattended-upgrades..."
    sudo systemctl enable unattended-upgrades
    sudo systemctl restart unattended-upgrades

    # Confirmation
    echo "La configuration pour les mises à jour automatiques de sécurité est terminée."

    sudo systemctl restart ssh
}
