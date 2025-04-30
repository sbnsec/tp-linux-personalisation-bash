#!/bin/bash

config_ufw () {

    figlet "UFW"
    #UFW download
    apt install ufw
    systemctl enable ufw 
    systemctl start ufw

    #UFW rules
    ufw default deny incoming
    ufw default allow outgoing
    ufw logging on
    ufw allow 80/tcp #http
    ufw allow 443/tcp #https
    ufw allow 22/tcp #ssh
    ufw enable
    ufw allow smtp
    ufw allow out pop3s
    ufw limit 22/tcp #limiter le nombre de connexions ssh avec une seul ip (limite de 6 par défaut)

    #Activer les logs plus précis
    ufw logging high

    ufw reload

    # Desactiver autorisation ipv6
    sed -i "s/IPV6=yes/IPV6=no/" /etc/default/ufw

}