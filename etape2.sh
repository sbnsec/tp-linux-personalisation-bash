#!/bin/bash

# Étape 2 : Simplification du durcissement de SSH

# Fichier de configuration de SSH
SSHD_CONFIG="/etc/ssh/sshd_config"

# Désactiver l'authentification par mot de passe (simple modification)
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' $SSHD_CONFIG

# Désactiver l'accès root via SSH
sudo sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' $SSHD_CONFIG

# Restreindre l'accès SSH à un utilisateur spécifique
echo "AllowUsers mon_utilisateur" | sudo tee -a $SSHD_CONFIG

# Redémarrer le service SSH pour appliquer les modifications
sudo systemctl restart sshd

echo "SSH durci avec succès."