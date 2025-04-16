#!/bin/bash

SSH_keys_registration(){


 # PEUT ETRE SUPPR EVAL ET &>/dev/null

    #Verifier lexistance de lutilisateur sinon le creer generee sa clee et ses repertoir associe si necessaire
    #Parcourir les valeurs de $ALLOWED_USERS et les mettre dans la variable temporaire de boucle user
    for user in $ALLOWED_USERS; do
 
        #Si lutilisateur dans $user existe id renvera son identifiant sinon rien
        echo ""
        if ! id "$user" &>/dev/null; then
            echo "Si l'utilisateur $user n'existe pas, pensez à le créer et déplacer les clées généré ultérieurement. Elles sont à la racine du script."
                # &>/dev/null Desencombre le shell en mettant les sortie dans le fichier /dev/null
        fi
            #Definion du repertoire home de lutilisateur
            USER_HOME=$(eval echo ~$user)
                # eval Obtient dabord le contenu de la commande avant de lexecuter
                # ~$user Renvoi le repertoir de lutilisateur
                # On genere ou nouvelle variable interne a cet boucle

            #Definion du repertoire SSH de lutilisateur
            SSH_DIR="$USER_HOME/.ssh"
                # /.ssh Ajouter ce repertoire dans le home
            
            #Si le repertoire .ssh nexiste pas le creer
            echo ""
            if [ ! -d "$SSH_DIR" ]; then
                echo "Creation du repertoire SSH de $user"
                mkdir -p "$SSH_DIR"
                chown $user:$user "$SSH_DIR"
                chmod 700 "$SSH_DIR"
            fi
                # -d Vraie si le repertoir existe
                # chmod Gere les permission repertoir et fichier
                # 7 Tous pour le proprietaire du repertoire
                # 0 Rien pour les membres du groupe de lutilisaeur
                # 0 Rien pour les autres utilisateurs

            #Definition du repertoir des clee RSA
            KEY_FILE="$SSH_DIR/id_rsa"

            #Generer une paire de cles SSH ( privee et public )
            echo ""
            echo "Generation des clee rsa de $user"
            ssh-keygen -t rsa -b 2048 -f "$KEY_FILE" -q -N ""
                # ssh-keygen Outil de generation de clee SSH
                # -t Choisir le type de clee genere ici type rsa
                # -b Specifie la taille de la clee ici 2048 bits
                # -f Specifi le chemin et nom du fichier ici dans la variable KEY_PATH
                # -N Specifie une phrase de pass qui protege la clee privee ( ici null car pas de valeur apres N )

            #Deplacer la cle publique dans authorized_keys
            echo ""
            echo "Ajout de la cle publique dans authorized_keys pour $user"
            cat "$KEY_FILE.pub" >> "$SSH_DIR/authorized_keys"
            chown $user:$user "$SSH_DIR/authorized_keys"
            chmod 600 "$SSH_DIR/authorized_keys"
                # cat Renvoi le contenu dun fichier
                # chown Gere lappartenance des repertoire et fichier
                # $user:$user Utilisateur:Groupe:Autres
                # 6 Lecture et ecriture

            #Gestion privileges sur les clees rsa
            chown $user:$user "$KEY_FILE"
            chmod 600 "$KEY_FILE"
                # Les utilisateurs ne sont pas admin pas besoin des plein droits sur les clees

            echo "Clees RSA generee pour $user"
        
    done

    echo "Gestion des clees RSA pour lacces SSH termine ."




}
