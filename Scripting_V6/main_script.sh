#!/bin/bash
#Definit au systeme quon utilise Bash

#La gestion des erreurs du script se fait ici et pas dans les fonctions pour ameliorer leur portabilite 
trace(){ 
  echo "# $*"
  "$@" 
}
  # Non_de_la_fonction(){ Contenu de la fonction } Les parenthese indique que cest une fonction
  # echo Affiche des chaines de caracteres
  # ; Peut remplacer lindentation pour tout mettre sur une linge
  # # Applique un aspect visuel aux commandes renvoyees dans le shell
  # $* Permer de retourner les argument utilise par les fonctions du script
  # s@ Represente les arguments des fonctions ( ici valeur des variables )
  # Les guillementspPreserve les espace dans les arguments
  # La derniere ligne definit donc le format de renvoi des arguments utilises par la fonction

set -e
  # set Active ou desactive les otpions du shell
  # - Activation ( + desactivation )
  # x Enonciation des commandes avant execution 
  # e Arret du script en cas de code erreur


#Sourcage du fichier des variables
source ./config/CONFIG_FILE.sh || { echo "Erreur : Impossible de sourcer CONFIG_FILE.sh."; exit 1; }
  # source Execute au prealable les fonctions du fichier pour les rendre accessible a posteriorie
  # Chemin relatif et pas absolue
  # Double pie est un oOperateur logique Si lexecution reussi passer a la commande suivante sinon renvoyer le code erreur
  # { ... ; ... } Groupage de commandes qui permet dexecuter plusieurs commandes pour une meme sortie booleenne
  # exit 1 est un code de sortie qui indique une erreur ( en opposition à 0 )

#Sourcage des fichiers de fonctions
source ./fonctions/PERSONNALISATION.sh || { echo "Erreur : Impossible de sourcer PERSONNALISATION.sh "; exit 1; }
source ./fonctions/MAJ.sh || { echo "Erreur : Impossible de sourcer MAJ.sh"; exit 1; }
source ./fonctions/SSH_keys_registration.sh || { echo " Erreur : Impossible de sourcer SSH_keys_registration.sh "; exit 1; }
source ./fonctions/SSH_config_hardenning.sh || { echo " Erreur : Impossible de sourcer SSH_config_hardenning.sh "; exit 1; }
source ./fonctions/UFW_config_hardenning.sh || { echo " Erreur : Impossible de sourcer UFW_config_hardenning.sh "; exit 1; }
source ./fonctions/BONUS.sh || { echo " Erreur : Impossible de sourcer BOnUS.sh "; exit 1; }

#Definition de la fonction dexecution du script
main(){

  echo "Demarrage du script..."

  #Organisation de lexecution des fonctions presentent dans les fichiers sources
  CONFIG_FILE || { echo " Erreur : echec de l'execution de CONFIG_FILE. "; exit 1; }
  PERSONNALISATION || { echo " Erreur : echec de l'execution de PERSONNALISATION. "; exit 1; }
  update_upgrade || { echo " Erreur : echec de l'execution de update_upgrade. "; exit 1; }
  SSH_keys_registration || { echo " Erreur : echec de l'execution de SSH_keys_registration. "; exit 1; }
  SSH_config_hardenning || { echo " Erreur : echec de l'execution de SSH_config_hardenning. "; exit 1; }
  UFW_config_hardenning || { echo " Erreur : echec de l'execution de UFW_config_hardenning. "; exit 1; }
  bonus || { echo " Erreur : echec de l'execution de bonus. "; exit 1; }

  echo "Script termine."
}

#Si il est vraie que lutilisateur na pas les privileges root retourner une erreur
if [ "$(id -u)" -ne 0 ]; then
    echo " Erreur : Vous n'avez pas les privileges necessaire ( Commande debian : su ) pour executer ce script. "
    exit 1
fi
  # if fi Boucle conditionnelle if
  # [ ... ] La condition a tester
  # $( ... ) Execute la commande interne au parenthese puis la remplace par le resultat de cette derniere
  # id -u Retourne lidentifiant de lutilisateur
  # -ne Different de
  # 0 Droit root
  # then Precede les commandes a executer si la condition est vraie

#Execution du script
main
