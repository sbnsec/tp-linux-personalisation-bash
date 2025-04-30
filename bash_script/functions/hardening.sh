#!/bin/bash

hardening () {
    figlet "HARDENING"

    #1. dowload and conf
    google-authenticator -t -d -f -r 3 -R 30 -w 3
    echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd

    sed -i "s/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/" /etc/ssh/sshd_config

    sed -i "s/^#UsePAM yes/UsePAM yes/" /etc/ssh/sshd_config

    sudo systemctl restart sshd
    
    # Désactiver les services qui sont exited
    for service in $(systemctl disable --type=service --state=exited --no-legend | awk '{print $1}'); do
        systemctl disable "$service"
    done

    #Surveillande des fichiers critiques
    echo '#Surveillance des fichiers critiques' >> /etc/aide/aide.conf
    echo '/etc	R' >> /etc/aide/aide.conf
    echo '/bin	R' >> /etc/aide/aide.conf
    echo '/sbin	R' >> /etc/aide/aide.conf
    echo '/usr/sbin	R' >> /etc/aide/aide.conf
    echo '/usr/bin	R' >> /etc/aide/aide.conf

    #vérifie les fichiers de conf du système
    echo '#Vérifie les fichiers de conf du système' >> /etc/aide/aide.conf
    echo '/etc/ssh/sshd_config	R' >> /etc/aide/aide.conf
    echo '/etc/passwd	R' >> /etc/aide/aide.conf
    echo '/etc/shadow	R' >> /etc/aide/aide.conf
    echo '/etc/group	R' >> /etc/aide/aide.conf

    #R vérifie le contenu des fichiers

    #initialisation
    aide --init --config=/etc/aide/aide.conf --database-file=/var/lib/aide/aide.db.new

    #déplacement
    mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

}