#!/bin/bash

# Script de sécurisation pour Debian
# Ce script configure le SSH, installe un pare-feu (UFW), met en place une authentification à deux facteurs (2FA),
# effectue des mises à jour automatiques, désactive les services inutiles et installe AIDE pour la surveillance du système.

# Vérifier si le script est exécuté en tant que root
if [ "$(id -u)" -ne 0 ]; then
  echo "Ce script doit être exécuté avec des privilèges root (sudo)." >&2
  exit 1
fi

# Variables
SSHD_CONFIG="/etc/ssh/sshd_config"
AUTHORIZED_KEYS="/home/$SUDO_USER/.ssh/authorized_keys"
UFW_CONFIG="/etc/default/ufw"
IP_WHITELIST=("192.168.1.0/24" "203.0.113.0/24") # Remplacez par vos IPs autorisées
ALLOWED_USERS=("mon_utilisateur") # Remplacez par les utilisateurs autorisés
PACKAGES="ufw aide"

# Fonction pour installer les paquets nécessaires
install_packages() {
  echo "Mise à jour des paquets..."
  apt update && apt upgrade -y

  echo "Installation des paquets requis : $PACKAGES..."
  apt install -y $PACKAGES
}

# 1. Copie de la clé SSH publique
setup_ssh_keys() {
  echo "Copie de la clé SSH publique dans $AUTHORIZED_KEYS..."
  mkdir -p /home/$SUDO_USER/.ssh
  cp /home/$SUDO_USER/.ssh/id_rsa.pub $AUTHORIZED_KEYS
  chown $SUDO_USER:$SUDO_USER $AUTHORIZED_KEYS
  chmod 600 $AUTHORIZED_KEYS
  echo "Clé SSH copiée et permissions configurées."
}

# 2. Durcissement de SSH
harden_ssh() {
  echo "Configuration de SSH pour renforcer la sécurité..."
  
  # Désactiver l'authentification par mot de passe
  sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' $SSHD_CONFIG
  sed -i 's/^#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' $SSHD_CONFIG
  
  # Limiter l'accès SSH à certains utilisateurs
  echo "AllowUsers ${ALLOWED_USERS[@]}" >> $SSHD_CONFIG

  # Désactiver l'accès root via SSH
  sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' $SSHD_CONFIG
  
  # Configurer la liste blanche des IPs autorisées
  echo "Création d'une liste blanche d'adresses IP pour SSH..."
  for ip in "${IP_WHITELIST[@]}"; do
    echo "AllowUsers *@$ip" >> $SSHD_CONFIG
  done

  systemctl restart sshd
  echo "SSH configuré et durci."
}

# 3. Installation et configuration du Pare-feu (UFW)
setup_firewall() {
  echo "Configuration du pare-feu UFW..."
  
  # Activer UFW
  ufw default deny incoming
  ufw default allow outgoing

  # Autoriser les connexions SSH
  ufw allow 22/tcp
  
  # Autoriser d'autres services si nécessaire
  ufw allow 80/tcp   # HTTP
  ufw allow 443/tcp  # HTTPS

  # Activer UFW
  ufw enable
  echo "Pare-feu UFW configuré et activé."
}

# 4. Propositions de Durcissement Simples
additional_hardening() {
  # Mise en place de l'authentification à deux facteurs (2FA) pour SSH
  echo "Mise en place de l'authentification à deux facteurs (2FA)..."
  apt install -y libpam-google-authenticator
  echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd

  # Mise à jour automatique des paquets de sécurité
  echo "Configuration des mises à jour automatiques des paquets de sécurité..."
  apt install -y unattended-upgrades
  dpkg-reconfigure --priority=low unattended-upgrades

  # Désactiver les services inutiles
  echo "Désactivation des services inutiles..."
  systemctl disable cups
  systemctl disable avahi-daemon
  systemctl disable bluetooth
  systemctl disable rpcbind
  
  # Installation et configuration de AIDE
  echo "Installation et configuration de AIDE pour la détection des modifications..."
  aideinit
  mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

  echo "Vérification initiale avec AIDE..."
  aide --check
}

# Exécution des fonctions
install_packages
setup_ssh_keys
harden_ssh
setup_firewall
additional_hardening

echo "Toutes les étapes de sécurisation sont terminées avec succès."