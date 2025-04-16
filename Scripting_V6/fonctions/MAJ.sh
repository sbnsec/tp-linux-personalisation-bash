#!/bin/bash

update_upgrade(){

	#Mise a jour de lhote
	echo ""
	if [[ "$MAJ_ANS" == "o" ]]; then
		apt update && apt upgrade -y
	fi
		# apt Gestionnaire de paquets de Debian
		# update Met a jour la liste des paquets disponibles a partir des depots existant
		# upgrade Met a jour tous les paquets installes
		# -y Repond automatiquement oui a toutes les invitations interactives de la commande

}
