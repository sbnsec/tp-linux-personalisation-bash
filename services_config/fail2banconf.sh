#!/bin/bash

install_fail2ban(){
    # Installation de fail2ban
    echo "Installation de fail2ban"
    apt-get install fail2ban -y
}

cp_jailconf(){
    # Copie du fichier de configuration jail.conf dans jail.local
    echo "Copie du fichier de configuration jail.conf dans jail.local"
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local 
}

conf_jail_local(){
    # Configuration de la jail DEFAUT
    echo "Configuration de la jail DEFAUT"
    bash -c 'cat << EOF >> /etc/fail2ban/jail.local
[DEFAULT]
ignoreip = 127.0.0.1/8
bantime = 1h
findtime = 10m
maxretry = 3
EOF'

    # Configuration de la jail SSH
    echo "Configuration de la jail sshd"
    bash -c 'cat << EOF >> /etc/fail2ban/jail.local
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 2
bantime = 1d
EOF'

    # Configuration de la jail recidive
    echo "Configuration de la jail recidive"
    bash -c 'cat << EOF >> /etc/fail2ban/jail.local
[recidive]
enabled = true
filter = recidive
logpath = /var/log/fail2ban.log
maxretry = 1
bantime = 30d
findtime = 1d
EOF'

}

jail_local_access(){
    # Gestion des acces au fichier jail.local
    echo "Gestion des acces au fichier jail.local"
    chmod 600 /etc/fail2ban/jail.local
}

fail2ban_restart(){
    # Demarrage du service fail2ban
    systemctl start fail2ban 
    systemctl reload fail2ban
}

fail2ban_enable(){
    # Configuration du demarrage automatique du service fail2ban
    systemctl enable fail2ban
}