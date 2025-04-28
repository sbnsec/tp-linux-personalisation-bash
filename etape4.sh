#!/bin/bash

# Étape 4 : Quelques durcissements simples pour la sécurité

# Installation de mises à jour de sécurité automatiques
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Désactivation des services réseau inutiles
sudo systemctl disable cups
sudo systemctl disable bluetooth

# Installation d'un outil simple pour vérifier les fichiers système (AIDE)
sudo apt install -y aide
sudo aideinit
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Première vérification avec AIDE
sudo aide --check

echo "Durcissements simples terminés."