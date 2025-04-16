#!/bin/bash

CONFIG_FILE(){




    #Variables de SSH_config_hardenning

    #Tant que le format IP est faux renvoyer une demande de saisie
    echo ""
    read -p " Entrez les adresses IPs autorisee pour la connection SSH ( xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx ... ) : " ALLOWED_IPS
    while [[ ! "$ALLOWED_IPS" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; do
        echo " Erreur : Adresse IP non valide "
        read -p " Veuillez entrer une adresse IP valide : " ALLOWED_IPS
    done
    echo " Les IP en White List : $ALLOWED_IPS "
        # while done Boucle conditionnelle itérative Tant que
        # [[ ... ]] Permet les operateur logique interne et les espaces et metacaractere
        # ! Invers la condition
        # =~ Faire correspondre a une chaine de caractere
        # ^ Debut de la chaine
        # [0-9] Un chiffre entre 0 et 9
        # + Lindiquation precedente peut se repeter plusieur fois
        # $ Fin de la chaine
        # \. Represente un point litteral
        # do Precede les commandes a executer si la condition est fausse



    #Variables de SSH_keys_registration

    #Choix du chemin du fichier de configuration SSH
    echo ""
    read -p " Entrez le chemin du fichier de configuration SSH ( par defaut /etc/ssh/sshd_config ) :" SSH_CONFIG
    SSH_CONFIG=${SSH_CONFIG:-/etc/ssh/sshd_config}
    echo " Le chemin configure du fichier de configuration SSH : $SSH_CONFIG "
        # Chemin absolu et non pas relatif

    #Choix des utilisateurs autorises
    echo ""
    read -p " Entrez les utilisateur autorise ( "user1" "user2" ...) : " ALLOWED_USERS
    ALLOWED_USERS=${ALLOWED_USERS:-User1}
    echo " Les utlisateurs autorises : $ALLOWED_USERS "



    #Variables de MAJ.sh

    #Demander la mise a jour ou non de lhote
    echo ""
    while [[ "$MAJ_ANS" != "o" && "$MAJ_ANS" != "n" ]]; do
        read -p " Souhaitez-vous mettre à jour la machine Debian ? ( Par defaut o ; Sinon : o/n) : " MAJ_ANS
        MAJ_ANS=${MAJ_ANS:-o}
    done
    echo " Etat de la demande de mise a jour de lhote : $MAJ_ANS "
        # != Different de
        # && Opérateur ET logique les deux conditions doivent etre vraie




}
