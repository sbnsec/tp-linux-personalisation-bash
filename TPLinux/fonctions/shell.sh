#!/bin/bash

shell() {
    sed -i '$ a \
\
if [ $(id -u) -eq 0 ]; then\n\
    PS1='\''\\[\\033[01;31m\\]\\u@\\h\\[\\033[01;34m\\] \\w \\$\\[\\033[00m\\] '\''\n\
else\n\
    PS1='\''\\[\\033[01;35m\\]\\u@\\h\\[\\033[01;34m\\] \\w \\$\\[\\033[00m\\] '\''\n\
fi\n\
' $HOME/.bashrc

    sudo sed -i '$ a alias update="sudo apt update"' ~/.bashrc
    sudo sed -i '$ a alias upgrade="sudo apt update && sudo apt upgrade -y"' ~/.bashrc
    sudo sed -i '$ a alias gs="git status"' ~/.bashrc # Affiche le statut du dépôt Git (fichiers modifiés, non suivis, etc.)
    sudo sed -i '$ a alias ga="git add"' ~/.bashrc # Ajoute les fichiers au suivi pour le prochain commit
    sudo sed -i '$ a alias gc="git commit -m"' ~/.bashrc # Effectue un commit avec un message (à spécifier après -m)
    sudo sed -i '$ a alias gp="git push"' ~/.bashrc # Envoie les commits locaux vers le dépôt distant (push)
    sudo sed -i '$ a alias gl="git log --oneline --graph --decorate --all"' ~/.bashrc # Affiche un journal compact des commits avec un graphe et des décorations
    sudo sed -i '$ a alias gco="git checkout"' ~/.bashrc # Change de branche ou de commit (checkout d'une branche ou d'un commit spécifique)
    sudo sed -i '$ a alias gd="git diff"' ~/.bashrc # Affiche les différences entre les fichiers modifiés et leur état dans le dernier commit

    exec bash
}
