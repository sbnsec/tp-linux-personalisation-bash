#!/bin/bash

bonus(){

    # Si fail2ban est deja installe, sinon ...
    if dpkg -l | grep -qw fail2ban; then
        echo "Fail2ban est déjà installé."
    else
        echo "Installation de Fail2ban..."
        apt install -y fail2ban
    fi
        # dpkg Gere les paquets du systeme
        # -l Cherche tous les paquets du systeme
        # q Mode Silencieux
        # w Fait correspondre le mot entier



    # Création de son répertoire de configuration sil nexiste pas
    #if [ ! -d /etc/fail2ban/jail.d ]; then
    #    mkdir -p /etc/fail2ban/jail.d
    #fi
    #
    #echo "" > /etc/fail2ban/jail.d/ssh.conf
            
            # Se renseigner sur les parametres




}