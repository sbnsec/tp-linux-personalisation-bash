#!/bin/bash

# Verifying every file needed are not missing, sourcing them if they exists
REQUIRED_FILES=("functions/ssh_config.sh" "functions/ufw.sh" "functions/sec_updates.sh" "functions/hardening.sh" "functions/zsh.sh" "functions/packages.sh" "config/global_vars.sh")

# Echo which file is missing if so
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo -e "${RED}Global - Erreur : Le fichier $file est manquant.${NC}"
        exit 1
    fi
    source "$file"
done

#Installing necessary packges before beginning
install_packages

#menu
echo "=== Veuillez choisir le script à exécuter ==="
echo "1. Durcissement SSH"
echo "2. Configuration UFW"
echo "3. Durcissement système"
echo "4. Paquets de sécurité"
echo "5. ZSH"
echo "6. TOUT"
echo "7. Quitter"
echo "============================================="

read -p "Choisissez une option : " choice

case $choice in

	1)
		echo "Exécution du Durcissement SSH..."
		setup_ssh_config
		;;
	2)
		echo "Exécution de la Configuration UFW..."
		config_ufw
		;;
	3)
		echo "Exécution du Durcissement système..."
		hardening
		;;
        
    4)
		echo "Exécution des paquets de sécurité"
		sec_updates
		;;
    5)
		echo "Exécution de l'installation de zsh"
		zsh
		;;
    6)
		echo "Exécution de l'entièreté du script"
		setup_ssh_config
        config_ufw
        hardening
        2fa
        sec_updates
        zsh
		;;
	7)
		echo "Sortie du programme"
		exit 0
		;;
	*)
		echo "Option invalide, veuillez indiquer une option valable"
		;;
esac
