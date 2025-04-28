#!/bin/bash

# Étape 3 : Installation et configuration simple de UFW

# Mise à jour des paquets et installation de UFW
sudo apt update
sudo apt install -y ufw

# Configuration simple du pare-feu
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Autorisation des connexions SSH
sudo ufw allow 22/tcp

# Activation du pare-feu
sudo ufw enable

echo "Pare-feu UFW installé et configuré."