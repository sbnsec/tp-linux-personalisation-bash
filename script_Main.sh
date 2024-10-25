#!/bin/bash

# Afficher le menu
echo "Sélectionnez une fonctionnalité à activer :"
echo "1) Génération de clés SSH sécurisées"
echo "2) Durcissement de la configuration SSH"
echo "3) Mise à jour automatique des paquets de sécurité"
echo "4) Détection des modifications des fichiers système"
echo "5) Configuration du pare-feu UFW"
echo "6) Activer toutes les fonctionnalités"
echo "7) Quitter"
echo -n "Entrez votre choix [1-7] : "
read -r choix

# Exécuter les scripts en fonction du choix
case $choix in
    1)
        echo "Génération de clés SSH sécurisées..."
        ./script_sshkey.sh
        ;;
    2)
        echo "Durcissement de la configuration SSH..."
        ./script_durcissementssh.sh
        ;;
    3)
        echo "Activation de la mise à jour automatique des paquets de sécurité..."
        ./script_autoMAJ.sh
        ;;
    4)
        echo "Activation de la détection des modifications des fichiers système..."
        ./script_Detection.sh
        ;;
    5)
        echo "Configuration du pare-feu UFW..."
        ./script_UFW.sh
        ;;
    6)
        echo "Activation de toutes les fonctionnalités..."
        ./script_sshkey.sh
        ./script_durcissementssh.sh
        ./script_autoMAJ.sh
        ./script_Detection.sh
        ./script_UFW.sh
        ;;
    7)
        echo "Quitter"
        exit 0
        ;;
    *)
        echo "Choix invalide. Veuillez réessayer."
        ;;
esac
