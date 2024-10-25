#!/bin/bash

# Script pour durcir Debian en trois etapes :
# 1. Script de configuration et durcissement SSH
# 2. Script de configuration firewall
# 3. Script de gestion des paquets
# 4. Script de configuration de fail2ban
# 5. Script de durcissement Debian

set -e # Exit le script immediatement si l'une des commandes retourne un code qui n'est pas zero

# Gestion des erreurs externes aux fonctions pour ameliorer la portabilite des fonctions
trace(){ echo "# $*";"$@"; }

echo "Lancement du script de durcissement de Debian."  # Indique le debut du processus de durcissement

#Sourcage des fichiers de configuration des services
source ./services_config/sshconf.sh || { echo "Erreur : Impossible de sourcer sshconf.sh "; exit 1; }
source ./services_config/ufwconf.sh || { echo "Erreur : Impossible de sourcer ufwconf.sh "; exit 1; }
source ./services_config/fail2banconf.sh || { echo "Erreur : Impossible de sourcer fail2banconf.sh "; exit 1; }

#Sourcage des fichiers de configuration de l'OS
source ./os_config/update_upgrade.sh || { echo "Erreur : Impossible de sourcer managepackage.sh "; exit 1; }
source ./os_config/managepackage.sh || { echo "Erreur : Impossible de sourcer managepackage.sh "; exit 1; }
source ./os_config/hardeningdebian.sh || { echo "Erreur : Impossible de sourcer hardeningdebian.sh "; exit 1; }

#Sourcage des fichiers de customisation de l'OS
source ./customization/customization.sh || { echo "Erreur : Impossible de sourcer customization.sh "; exit 1; }

main(){
    # Exécution des fonctions présentes dans les différents fichiers sources

    # Mise a jour du systeme
    update_upgrade || { echo " Erreur : echec de l'execution de update_upgrade "; exit 1; }

    # SSH
    sshkeyconf || { echo " Erreur : echec de l'execution de sshkeyconf "; exit 1; }
    sshdconf || { echo " Erreur : echec de l'execution de sshdconf "; exit 1; }
    sshaccess || { echo " Erreur : echec de l'execution de sshaccess "; exit 1; }
    sshrestart || { echo " Erreur : echec de l'execution de sshrestart "; exit 1; }

    # Package
    disable_useless_package || { echo " Erreur : echec de l'execution de disable_useless_package "; exit 1; }
    install_gpg || { echo " Erreur : echec de l'execution de install_gpg "; exit 1; }
    install_unattended-upgrades || { echo " Erreur : echec de l'execution de install_unattended-upgrades "; exit 1; }
    install_lynis || { echo " Erreur : echec de l'execution de install_lynis "; exit 1; }

    # Fail2ban
    install_fail2ban || { echo " Erreur : echec de l'execution de install_fail2ban "; exit 1; }
    cp_jailconf || { echo " Erreur : echec de l'execution de cp_jailconf "; exit 1; }
    conf_jail_local || { echo " Erreur : echec de l'execution de conf_jail_local "; exit 1; }
    jail_local_access || { echo " Erreur : echec de l'execution de jail_local_access "; exit 1; }
    fail2ban_restart || { echo " Erreur : echec de l'execution de fail2ban_restart "; exit 1; }
    fail2ban_enable || { echo " Erreur : echec de l'execution de fail2ban_enable "; exit 1; }

    # OS Hardening
    auditd_conf || { echo " Erreur : echec de l'execution de auditd_conf "; exit 1; }
    auditd_restart || { echo " Erreur : echec de l'execution de auditd_restart "; exit 1; }
    auditd_check || { echo " Erreur : echec de l'execution de auditd_check "; exit 1; }
    auditd_enable || { echo " Erreur : echec de l'execution de auditd_enable "; exit 1; }
    auditd_access || { echo " Erreur : echec de l'execution de auditd_access "; exit 1; }
    lynis_audit_system || { echo " Erreur : echec de l'execution de lynis_audit_system "; exit 1; }

    # Customization
    conf_banniere
    alias_conf

    # UFW
    installufw || { echo " Erreur : echec de l'execution de installufw "; exit 1; }
    ufwconf || { echo " Erreur : echec de l'execution de ufwconf "; exit 1; }
    ufwreload || { echo " Erreur : echec de l'execution de ufwreload "; exit 1; }
    ufwenable || { echo " Erreur : echec de l'execution de ufwenable "; exit 1; }

    echo "Durcissement termine avec succes."  # Affiche un message de succes si toutes les etapes se sont bien deroulees
}

# Verifie si l'utilisateur est root pour pouvoir executer le script
if [ "$(id -u)" -ne 0 ]; then
    echo " Erreur : Vous n'avez pas les privileges necessaire ( Commande debian : su ) pour executer ce script. "
    exit 1
fi

#Execution du script
main


