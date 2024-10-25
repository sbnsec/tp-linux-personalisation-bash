#!/bin/bash

disable_useless_package(){
    # Desactivation des services inutiles et non securises
    echo "Desactivation des services inutiles et non securises"
    apt purge telnet sendmail nis talk iptables-persistent -y
    apt autoremove -y
}

install_gpg(){
    # Installation du paquet gpg pour le chiffrement des donnees sensibles
    echo "Installation du paquet gpg pour le chiffrement des donnees sensibles"
    apt-get install gpg -y
    gpg --full-generate-key
}

install_unattended-upgrades(){
    # Installation du paquet Unattended-upgrades pour les mises à jour automatique (par defaut 3h du matin)
    echo "Installation du paquet Unattended-upgrades pour les mises à jour automatique (par defaut 3h du matin)"
    apt-get install unattended-upgrades apt-listchanges -y
    dpkg-reconfigure unattended-upgrades
}

install_lynis(){
    # Installation du paquet lynis pour pouvoir ulterieurement auditer le systeme
    echo "Installation du paquet lynis pour pouvoir ulterieurement auditer le systeme"
    apt-get install lynis -y
}