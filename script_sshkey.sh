#!/bin/bash
# 1. Copie de la Clé SSH (clé_script.pub)

set -e # Arrête le script en cas d'erreur

# Installation de openssh-server
apt-get install -y openssh-server
echo "Installation de openssh-server réussie."

# Vérification si la clé existe
if [ -f /root/.ssh/clé_script ]; then
    echo "La clé existe déjà. Veuillez la sauvegarder ou la supprimer avant de continuer."
    exit 1
fi

# Demande d'un mot de passe pour la clé
while true; do
    echo "Entrez un mot de passe pour la clé SSH (ne laissez pas vide) :"
    read -s mot_de_passe
    if [ -z "$mot_de_passe" ]; then
        echo "Erreur : le mot de passe ne peut pas être vide. Veuillez réessayer."
    else
        break
    fi
done

# Génération de la clé
if ssh-keygen -t Ed25519 -f /root/.ssh/clé_script -N "$mot_de_passe"; then
    echo "Clé SSH générée avec succès."
else
    echo "Échec de la génération de la clé SSH."
    exit 1
fi

# Création du fichier authorized_keys
mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
echo "Fichier authorized_keys créé avec succès."

# Mise en place de la clé dans le document authorized_keys
cat /root/.ssh/clé_script.pub >> /root/.ssh/authorized_keys
echo "Clé publique ajoutée à authorized_keys."

# Gestion des permissions
chmod 600 /root/.ssh/authorized_keys
chmod 600 /root/.ssh/clé_script.pub
chmod 700 /root/.ssh
echo "Permissions mises à jour avec succès."

echo "Configuration de la clé SSH terminée."