
#Installation de unattended-upgrades
if ! dpkg -l | grep -qw unattended-upgrades; then

    echo "Installation de unattended-upgrades <------------"

    apt-get update && apt-get install -y unattended-upgrades

else
    echo "unattended-upgrades est déjà installé."
    exit 1
fi

# Configurer la mise à jour automatique des paquets de sécurité

echo "Configuration de unattended-upgrades pour les mises à jour de sécurité uniquement..."

cat << EOL > /etc/apt/apt.conf.d/50unattended-upgrades
// Unattended-Upgrade::Origins-Pattern spécifie les mises à jour à installer
Unattended-Upgrade::Origins-Pattern {
        "o=Debian,a=stable";
        "o=Debian,a=stable-updates";
        "o=Debian,a=proposed-updates";
        "o=Debian,a=stable-backports";
        "o=Debian-Security";
};

// Envoie un mail si des erreurs surviennent
Unattended-Upgrade::Mail "root";
Unattended-Upgrade::MailOnlyOnError "true";

// Autoriser les redémarrages automatiques si nécessaire
Unattended-Upgrade::Automatic-Reboot "true";
EOL

# Activer les mises à jour automatiques dans APT

echo "Activation des mises à jour automatiques dans APT..."

cat << EOL > /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOL

# Redémarrer le service pour appliquer les modifications

echo "Redémarrage du service unattended-upgrades..."
systemctl restart unattended-upgrades

echo "Configuration des mises à jour de sécurité automatiques terminée."