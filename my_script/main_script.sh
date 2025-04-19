#!/bin/bash

# Ce script s'arrêtera si une commande échoue.
set -e

# Permet de voir les commandes exécutées avant qu'elles ne s'exécutent
trace() {
    echo "# $*"
    "$@"
}

# Vérifier si l'utilisateur a les droits root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "_______________________________________________"
    echo -e "| Erreur : Ce script nécessite les droits root. |"
    echo -e "_______________________________________________"
    exit 1
fi

    echo -e "_______________________________________________"
    echo -e "| Démarrage de l'installation des packages |"
    echo -e "_______________________________________________"
apt update

apt install  -y vim curl wget openssh-server nano fail2ban ufw
    echo "Opération terminée."
    echo -e "________________________________________"
    echo -e "| Appuyez sur Entrée pour continuer... |"
    echo -e "________________________________________"
    read


# Chargement des fonctions depuis les fichiers sourcés
source ./functions/secure_ssh.sh || { echo "Erreur : Impossible de sourcer secure_ssh.sh"; exit 1; }
source ./functions/firewall_setup.sh || { echo "Erreur : Impossible de sourcer firewall_setup.sh"; exit 1; }
source ./functions/fail2ban_setup.sh || { echo "Erreur : Impossible de sourcer fail2ban_setup.sh"; exit 1; }
source ./functions/log_management.sh || { echo "Erreur : Impossible de sourcer log_management.sh"; exit 1; }
source ./config/config_file.sh || { echo "Erreur : Impossible de charger le fichier de configuration"; exit 1; }


# Appeler les fonctions
main(){
    echo -e "_________________________________________________________________"
    echo -e "| Démarrage du processus d'automatisation et de durcissement     |"
    echo -e "_________________________________________________________________"
    echo -e "____________________________________________________"
    echo -e "| Appuyez sur Entrée pour configuer le service SSH |"
    echo -e "____________________________________________________"
    read
    secure_ssh_config
    echo -e "____________________________________________________"
    echo -e "| Appuyez sur Entrée pour configuer le firewall UFW |"
    echo -e "____________________________________________________"
    read
    setup_ufw
    echo -e "_____________________________________________"
    echo -e "| Appuyez sur Entrée pour installer fail2ban |"
    echo -e "_____________________________________________"
    read
    setup_fail2ban
    echo -e "________________________________________________________________"
    echo -e "| Appuyez sur Entrée pour configuer la double authentification |"
    echo -e "________________________________________________________________"
    read
    setup_authenticator
    echo -e "______________________________________________________________"
    echo -e "| Appuyez sur Entrée pour configuer le service d'auto-update |"
    echo -e "______________________________________________________________"
    read
    setup_auto_updates

    echo -e "__________________________"
    echo -e "| Configuration terminée |"
    echo -e "__________________________"

}

# Appel de la fonction principale
main
