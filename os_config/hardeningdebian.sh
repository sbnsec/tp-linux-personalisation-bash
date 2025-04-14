#!/bin/bash

auditd_conf(){
    # Ajout de regles d'audit de base sur les fichiers critiques 
    echo "# Surveille les modifications sur les fichiers critiques
    -w /etc/passwd -p wa -k passwd_changes
    -w /etc/shadow -p wa -k shadow_changes
    -w /etc/group -p wa -k group_changes

    # Surveille les connexions SSH
    -w /var/log/secure -p wa -k ssh_logins

    # Surveille les tentatives de connexion echouees
    -w /var/log/faillog -p wa -k failed_logins

    # Surveille les modifications dans le repertoire /etc
    -w /etc/ -p wa -k etc_changes" >> /etc/audit/rules.d/audit.rules

}


auditd_restart(){
    # Redemarrer auditd pour appliquer les nouvelles regles
    echo "Redemarrage de auditd pour appliquer les nouvelles regles"
    systemctl restart auditd
}

auditd_check(){
    # Verifie les regles d'audit
    echo "Regles d'audit appliquees :"
    auditctl -l
}

auditd_enable(){
    # Active le demarrage automatique du service auditd
    systemctl enable auditd
}

auditd_access(){
    # Gestion des acces aux fichiers sensibles
    chmod 400 /etc/passwd  # Le fichier /etc/passwd contient les informations des utilisateurs, il est securise pour eviter tout acces non autorise
    chmod 400 /etc/shadow  # Le fichier /etc/shadow contient les mots de passe haches des utilisateurs, il doit etre tres protege
}

lynis_audit_system(){
    # Lancement d'un audit du systeme avec lynis pour terminer le durcissement Debian
    echo "Lancement d'un audit du systeme avec lynis pour terminer le durcissement Debian"
    lynis audit system
}