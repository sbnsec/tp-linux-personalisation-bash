#!/bin/bash

set -e # Le script s'arrête en cas d'erreur

# Vérifier si l'utilisateur a les droits root
if [ "$(id -u)" -ne 0 ]; then
    echo "Erreur : Ce script nécessite les droits root. Veuillez exécuter avec 'sudo' ou en tant que root."
    exit 1
fi

# 1. Copie de la Clé SSH (clé_script.pub)
if [ -f ./Script1.sh ]; then
    source ./Script1.sh || { echo "Échec lors de l'exécution de Script1.sh"; exit 1; }
else
    echo "Erreur : Script1.sh est manquant."
    exit 1
fi

# 2. Durcissement de SSH
if [ -f ./Script2.sh ]; then
    source ./Script2.sh && echo "Script2.sh exécuté avec succès." || { echo "Échec lors de l'exécution de Script2.sh"; exit 1; }
else
    echo "Erreur : Script2.sh est manquant."
    exit 1
fi

# 3. Installation et Configuration d’un Pare-feu (UFW)
if [ -f ./Script3.sh ]; then
    source ./Script3.sh && echo "Script3.sh exécuté avec succès." || { echo "Échec lors de l'exécution de Script3.sh"; exit 1; }
else
    echo "Erreur : Script3.sh est manquant."
    exit 1
fi

# 4. Propositions de Durcissement Simples
if [ -f ./Script4.sh ]; then
    source ./Script4.sh && echo "Script4.sh exécuté avec succès." || { echo "Échec lors de l'exécution de Script4.sh"; exit 1; }
else
    echo "Erreur : Script4.sh est manquant."
    exit 1
fi

# 5. Personnalisation et Suggestions de Fonctionnalités
if [ -f ./Script5.sh ]; then
    source ./Script5.sh && echo "Script5.sh exécuté avec succès." || { echo "Échec lors de l'exécution de Script5.sh"; exit 1; }
else
    echo "Erreur : Script5.sh est manquant."
    exit 1
fi

echo "Tous les scripts ont été exécutés avec succès."