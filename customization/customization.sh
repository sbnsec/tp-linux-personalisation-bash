#!/bin/bash

conf_banniere(){
    # Pour exécuter la fonction, il suffit d'appeler:
    echo "Mise à jour /etc/motd avec le message de bienvenue"
    read -p "Veuillez entrer le message souhaite : " MESSAGE
    echo $MESSAGE >> /etc/motd
}

# Fonction pour ajouter des alias au fichier .bashrc
add_alias() {
    local alias_command="$1"
    if ! grep -q "alias $alias_command" "$BASHRC"; then
        echo "alias $alias_command" >> "$BASHRC"
        echo "Ajout de l'alias : $alias_command"
    else
        echo "L'alias $alias_command existe déjà."
    fi
}

alias_conf(){
    # Configuration d'alias de commande sur la machine
    local BASHRC="$HOME/.bashrc"
    while true; do
        read -p "Entrez l'alias de commande que vous souhaitez ajouter (ou 'exit' pour quitter) sous la forme "alias='commande'" : " USER_ALIAS
        if [[ "$USER_ALIAS" == "exit" ]]; then
            break
        fi
        add_alias "$USER_ALIAS"
    done

    # Recharger le fichier .bashrc pour appliquer les changements
    echo "Rechargement de .bashrc..."
    source "$BASHRC"

}