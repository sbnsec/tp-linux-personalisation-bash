#!/bin/bash

# Étape 1 : Copie simple de la clé SSH publique dans ~/.ssh/authorized_keys

# Vérification si le fichier existe, sinon il le crée
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  echo "La clé SSH publique n'existe pas. Veuillez générer une clé SSH avec 'ssh-keygen'."
  exit 1
fi

# Copie de la clé publique dans authorized_keys
mkdir -p ~/.ssh
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Configuration des permissions (simple et nécessaire)
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

echo "Clé SSH copiée avec succès et permissions configurées."