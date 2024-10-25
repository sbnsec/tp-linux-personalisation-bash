#!/bin/bash

# Fonction pour installer AIDE
install_aide() {
    if ! dpkg -l | grep -qw aide; then
        echo "Installation de AIDE..."
        apt-get update && apt-get install -y aide
    else
        echo "AIDE est déjà installé."
        exit 1
    fi
}

# Fonction pour initialiser la base de données AIDE
initialize_aide() {
    echo "Initialisation de la base de données AIDE..."
    aide --init -c /etc/aide/aide.conf

    # Déplacer la base de données générée
    mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
    echo "Base de données AIDE initialisée."
}

# Fonction pour configurer AIDE
configure_aide() {
    echo "Configuration de AIDE pour surveiller les fichiers critiques..."

    # Modifier le fichier de configuration si nécessaire

    echo "Configuration de AIDE terminée."
}

schedule_aide_check() {
    echo "Planification d'une vérification automatique quotidienne avec cron..."

    # Créer un fichier cron pour AIDE
    cat <<EOL > /etc/cron.daily/aide_check
#!/bin/bash
# Script de vérification quotidienne d'AIDE

/usr/bin/aide --check | mail -s "Rapport AIDE" root
EOL

    # Donner les droits d'exécution au script cron
    chmod +x /etc/cron.daily/aide_check
    echo "Vérification automatique planifiée."
}

# Appel des fonctions

install_aide
initialize_aide
configure_aide
schedule_aide_check


echo "Configuration de la détection des modifications système avec AIDE terminée."
