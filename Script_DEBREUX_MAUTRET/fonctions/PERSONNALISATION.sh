#!/bin/bash

set -e

PERSONNALISATION() {



    # Alias pour la mise à jour
    if ! grep -q "alias upd=" ~/.bashrc; then
        echo "Création de l'alias 'upd' "
        echo "alias upd='sudo apt update && sudo apt upgrade -y'" >> ~/.bashrc
    else
        echo "L'alias 'upd' existe déjà. "
    fi

    # Personnalisation du prompt
    PROMPT='PS1="\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\] \$(if [ \$? -eq 0 ]; then echo -e \":)\"; else echo -e \":(\"; fi) \[\033[0m\]\$ "'

    # Verifie si elle existe deja
    if grep -Fxq "$PROMPT" ~/.bashrc; then
        echo "Le prompt est déjà personnalisé de la sorte."
    else
        echo "$PROMPT" >> ~/.bashrc
        echo "Le prompt personnalisé a été ajouté dans ~/.bashrc"
    fi

    # Appliquer les changements
    source ~/.bashrc



}