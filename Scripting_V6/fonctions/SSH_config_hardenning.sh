#!/bin/bash

SSH_config_hardenning(){

    #Desactivation de lauthentification par MDP
    #Si PasswordAuthentication existe dans $SSH_CONFIG la modifier par PasswordAuthentication no
    echo ""
    if grep -q "^PasswordAuthentication" $SSH_CONFIG; then
        sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' $SSH_CONFIG
    fi
    echo "L'authentification par mot de passe a ete desactivee."
        # Grep Cherche une chaine de caractere dans la variable
        # -q Retourne un code 0 si la chaine de caractere est trouvee sinon code erreur 1
        # ^ Pour chercher une ligne qui commence par PasswordAuthentication
        # sed Permet a la boucle de modifier le contenu du fichier automatiquement
        # -i Modification dans le fichier existant
        # S/.../... Remplace les premiers ... par les deuxiemes ... dans la variable designee
        # .* Quelques soit la suite
       
    #Definition des utilisateurs autorises
    #Si ^AllowUsers.* existe dans $SSH_CONFIG la modifier par AllowUsers suivi du contenu de $ALLOWED_USERS
    #Sinon ajouter une ligne AllowUsers $ALLOWED_USERS dans $SSH_CONFIG
    echo ""
    if grep -q "^AllowUsers" $SSH_CONFIG; then
        sed -i "s/^AllowUsers.*/AllowUsers $ALLOWED_USERS/" $SSH_CONFIG
    else
        echo "AllowUsers $ALLOWED_USERS" >> $SSH_CONFIG
    fi
    echo "L'acces en ssh a ete accorde aux utilisateurs : $ALLOWED_USERS. Profitez bien ;)"
        # AllowUsers $ALLOWED_USERS Ajoute le contenu de $ALLOWED_USERS après AllowUsers le tout dans la varibale designee
        # else Permet lajout de reponses au test de la condition a la boucle
        # >> Ajout de caractere dans la variable en concervant ceux deja existant

    #Desactivation de lauthentification SSH root
    #Si ^PermitRootLogin.* existe dans $SSH_CONFIG la modifier par PermitRootLogin no
    #Sinon ajouter une ligne PermitRootLogin no dans $SSH_CONFIG
    echo ""
    if grep -q "^PermitRootLogin" $SSH_CONFIG; then
        sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' $SSH_CONFIG
    else
        echo "PermitRootLogin no" >> $SSH_CONFIG
    fi
    echo "L'acces de l'utilisateur root en ssh a ete desactive"

    #Definition des IP autorisees
    #Pour toute les IP dans ALLOWED_IPS les ajouter dans $SSH_CONFIG
    echo ""
    for ip in "${ALLOWED_IPS[@]}"; do
        echo "Match Address $ip" >> $SSH_CONFIG
    done
        # for done Boucle d'itération for
        # ip Variable allant stocker les valeur de ALLOWED_IPS
        # in Literation aura lieu dans ALLOWED_IPS
        # [@] Donne lacces aux valeurs de ALLOWED_IPS
        # do Precede les commandes a executer apres avoir parcouru les valeurs

    #Redemarrer le service SSH afin dappliquer les changements effectues
    echo ""
    systemctl restart sshd
    systemctl restart ssh
    echo "Liste blanche des IP et utilisateur configuree avec succes."
    echo "Service SSH redemarre avec succes."
        # systemctl Etilisé pour démarrer arrêter redémarrer vérifier le statut ou activer et désactiver les services système
        # restart Defini sur redémarrer
        # sshd & ssh Pour des soucis de compatibilite entre les differentes distributions linux

}
