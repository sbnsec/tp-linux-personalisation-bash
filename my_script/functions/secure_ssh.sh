#!/bin/bash

# my_script/functions/secure_ssh.sh

secure_ssh_config() {

##############################--SSH_KEYS--##########################################

    # Demande à l'utilisateur quel est son nom d'utilisateur
    read -p "Entrez le nom d'utilisateur : " username

    # Définir le chemin du répertoire .ssh et du fichier authorized_keys pour l'utilisateur spécifié
    ssh_dir="/home/$username/.ssh"
    auth_keys_file="$ssh_dir/authorized_keys"

    # Vérifie si le répertoire ~/.ssh existe
    if [ ! -d "$ssh_dir" ]; then
        # Crée le répertoire ~/.ssh s'il n'existe pas
        mkdir -p "$ssh_dir"
        echo -e "______________________________________"
        echo -e "| Le répertoire $ssh_dir a été créé. |"
        echo -e "______________________________________"

    else
        echo -e "______________________________________"
        echo -e "| Le répertoire $ssh_dir existe déjà. |"
        echo -e "______________________________________"
    fi

    # Vérifie si le fichier authorized_keys existe
    if [ ! -f "$auth_keys_file" ]; then
        # Crée le fichier authorized_keys
        touch "$auth_keys_file"
        echo -e "__________________________________________"
        echo -e "| Le fichier $auth_keys_file a été créé. |"
        echo -e "_________________________________________"
    else
        echo -e "___________________________________________"
        echo -e "| Le fichier $auth_keys_file existe déjà. |"
        echo -e "___________________________________________"
    fi

    # Copie de la clé ssh
    echo "$SSH_KEY_PUB" >> "$auth_keys_file"

    # Vérifier si la clé a été ajoutée avec succès
    if grep -q "$SSH_KEY_PUB" "$auth_keys_file"; then
        echo -e "_____________________________"
        echo -e "| La clé a été ajoutée avec succès. |"
        echo -e "_____________________________"
    else
        echo -e "_____________________________"
        echo -e "| Échec de l'ajout de la clé. |"
        echo -e "_____________________________"
    fi

    # Ajuste les permissions
    chmod 700 "$ssh_dir"
    chmod 600 "$auth_keys_file"
    chown "$username:$username" "$ssh_dir"
    chown "$username:$username" "$auth_keys_file"

    echo -e "_____________________________"
    echo -e "| Les permissions ont été ajustées. |"
    echo -e "_____________________________"

##############################--Configuration--##########################################

    # Configuration de SSH
    sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" "$SSH_CONFIG_FILE"
    sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/" "$SSH_CONFIG_FILE"
    sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin no/" "$SSH_CONFIG_FILE"

    # Limiter l'accès
    # Demander à l'utilisateur d'entrer un/des groupe/s
    read -p "Veuillez entrer les groupes autorisés à se connecter : " authorized_group

    # Vérifier si l'utilisateur a saisi un groupe
    if [ -z "$authorized_group" ]; then
        echo -e "_____________________________"
        echo -e "| Aucun groupe saisi. Le script va maintenant quitter. |"
        echo -e "_____________________________"
        exit 1
    fi

    # Ajouter AllowGroups au fichier de configuration SSH
    echo "AllowGroups $authorized_group" | tee -a "$SSH_CONFIG_FILE" > /dev/null

    # Vérifier si la ligne a été ajoutée avec succès
    if grep -q "AllowGroups $authorized_group" "$SSH_CONFIG_FILE"; then
        echo -e "_____________________________"
        echo -e "| Les groupes autorisés ont été appliqués. |"
        echo -e "| Le service SSH a été redémarré. |"
        echo -e "_____________________________"
    else
        echo -e "_____________________________"
        echo -e "| Une erreur est survenue lors de l'ajout des groupes. |"
        echo -e "_____________________________"
    fi

#############################--Fichier hosts.allow--##########################################
    HOSTS_ALLOW="/etc/hosts.allow"

    # Demander à l'utilisateur quelle adresse ajouter
    read -p "Veuillez entrer l'adresse IP ou le sous-réseau autorisés à se connecter (ex: 192.168.0.8 ou 192.168.0.0/24) :" ADDR

    # Vérifier si l'utilisateur a saisi une adresse
    if [ -z "$ADDR" ]; then
        echo -e "_____________________________"
        echo -e "| Aucune adresse saisie. Le script va maintenant quitter. |"
        echo -e "_____________________________"
        exit 1
    fi

    # Ajouter au fichier /etc/hosts.allow
    echo "sshd: $ADDR" >> "$HOSTS_ALLOW"

    # Bloquer toutes les autres adresses IP
    echo "sshd: ALL : deny" >> "$HOSTS_ALLOW"

    echo -e "_____________________________"
    echo -e "| Le fichier $HOSTS_ALLOW a été mis à jour. |"
    echo -e "_____________________________"

    # Redémarrer le service SSH pour appliquer les changements
    systemctl restart sshd
    echo -e "_____________________________"
    echo -e "| Les adresses IP autorisées ont été appliquées. |"
    echo -e "| Le service SSH a été redémarré. |"
    echo -e "_____________________________"
}
