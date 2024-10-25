#!/bin/bash
#2. Durcissement de SSH

    SSH_CONFIG="/etc/ssh/sshd_config" #La localisation du fichier

    cp $SSH_CONFIG "${SSH_CONFIG}.bak" #Création d'une copie du fichier

    echo "Sauvegarde du fichier de configuration SSH effectuée : ${SSH_CONFIG}.bak" 

    #La désactivation de l'authentification par mot de passe pour forcer l'utilisation des clés SSH.

        if grep -q "^PasswordAuthentication" $SSH_CONFIG; then
            sed -i 's/^PasswordAuthentication .*/PasswordAuthentication no/' $SSH_CONFIG
        else
            echo "PasswordAuthentication no" >> $SSH_CONFIG
        fi

    #La limiter d'accès SSH à certains utilisateurs ou groupes.

        if grep -q "^AllowUsers" $SSH_CONFIG; then
            sed -i 's/^AllowUsers .*/AllowUsers toto1 toto2/' $SSH_CONFIG
        else
            echo "AllowUsers toto1 toto2" >> $SSH_CONFIG
        fi

    #La désactivation d'accès root via SSH pour éviter des tentatives d'intrusion sur ce compte sensible.

        if grep -q "^#PermitRootLogin" $SSH_CONFIG || grep -q "^PermitRootLogin" $SSH_CONFIG; then
            sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/' $SSH_CONFIG
            sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' $SSH_CONFIG
        else
            echo "PermitRootLogin no" >> $SSH_CONFIG
        fi

    #L'utilisation d’une Liste Blanche d’Adresses IP pour SSH Pour une sécurité renforcée, autorisez uniquement des plages d'adresses IP spécifiques à se connecter via SSH. Cette liste blanche limite l'accès à des sources fiables.

        cp /etc/hosts.allow  /etc/hosts.allow.bak

        if ! grep -q "sshd : 192.168.1.1-192.168.1.10" /etc/hosts.allow; then
            echo "sshd : 192.168.1.1-192.168.1.10" >> /etc/hosts.allow
        fi

        cp /etc/hosts.deny /etc/hosts.deny

        if ! grep -q "sshd : ALL" /etc/hosts.deny; then
            echo "sshd : ALL" >> /etc/hosts.deny
        fi

    systemctl restart sshd