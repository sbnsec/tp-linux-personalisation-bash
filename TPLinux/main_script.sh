#!/bin/bash

# Arrête le script s'il y a une erreur
set -e

source ./config/config.sh || { echo "Erreur : Impossible de charger le fichier de configuration"; exit 1; }
source ./fonction/durcissement.sh || { echo "Erreur : Impossible de sourcer durcissement.sh"; exit 1; }
source ./fonction/ufw.sh || { echo "Erreur : Impossible de sourcer ufw.sh"; exit 1; }
source ./fonction/IP.sh || { echo "Erreur : Impossible de sourcer IP.sh"; exit 1; }
source ./fonction/otp.sh || { echo "Erreur : Impossible de sourcer otp.sh"; exit 1; }
source ./fonction/shell.sh || { echo "Erreur : Impossible de sourcer shell.sh"; exit 1; }
source ./fonction/auto.sh || { echo "Erreur : Impossible de sourcer shell.sh"; exit 1; }

main() {

  echo "Démarrage du processus d'automatisation et de durcissement..."
  
  # Lancer les différents scripts
  
  config || { echo "Erreur : échec de l'exécution de CONFIG_FILE."; exit 1; }
  durcissement || { echo "Erreur : échec de l'exécution de durcissement.sh"; exit 1; }
  IP || { echo "Erreur : échec de l'exécution de IP.sh"; exit 1; }
  ufw || { echo "Erreur : échec de l'exécution de ufw.sh"; exit 1; }
  otp || { echo "Erreur : échec de l'exécution de otp.sh"; exit 1; }
  auto || { echo "Erreur : échec de l'exécution de shell.sh"; exit 1; }
  shell || { echo "Erreur : échec de l'exécution de shell.sh"; exit 1; }

  echo "Processus terminé avec succès."
}

# Appel de la fonction principale
main
