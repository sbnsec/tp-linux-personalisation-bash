#!/bin/bash

sshkeyconf(){
    # Generation d'une cle SSH chiffree en RSA et copie de cette cle dans le dossier des cles autorisees
    echo 'Generation et copie de la cle SSH dans le fichier ~/.ssh/authorized_keys'
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDhbYLpulxdE6C4p+CwV3mdhZu0eomnMUTCplDmZtXggrkvTUDTmJrCBtYvl9TkFAjSP5sYVaqSDpBrHiUJagdLKacvNMxtHoRCduO/b7aNBa7SMTxU69o9IpqgNhPoZyFuTaASdMbBO4ArxqoxaW106se5oGZIOcFUj9SWqcN+2JYIkjhT0A7GIbs2ntuEKIF4Sxkl0ZVoc8ksKVzRmGOm0UiCm9DG+Xk3b35h4Ids2pY/0dPJw5AXHRnitfQGD47DfUzEjEPKVSPTtgcR8RTi5NJdtWh3uY6r4kA058rAqrXduFsFOORF+jAj9YqyNlxjS2RWYSP4c9TPTDIwG3EuqQD2XeOf1m7CDcEIdzKhJYY5PoElqNP6yP4S77MAU/mBQ3et6Ol6fmEZylP4Eyj9Ke3TwWyrBri851kw+PYUZRm2vnhCj7dQd6KsI0r3HcDj34HjFOCkCcSNHzAfEfx/kkKiAxX5N0wUMPpHmeZFCDT6Vm+IFLuqYz4qal3KjGfp4ZdrhXQ8eRSij+emq+uGroSYCmD72DEfbrkCvTRCceVwY8z9EGcuimNizVvsv3ajhjOVrpBo/RIZ6NRDWQDHDo6+CeJa9NnXVJPDh2MJu5vmO3NnU19krhWv4oTbyEzG8zWclktZ4HSoaZe5Y57RVG+uP3EO/Qrw+jNz/KlI8w== sarah@Blackpearl" >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
}

sshdconf(){
    # Changement de la valeur du Protocol à 2
    echo "Changement de la valeur Protocol à 2 dans sshd_config"
    # Verification de l'existence du parametre Protocol dans le fichier sshd_config
    # Si le parametre n'existe pas, alors on ajoute la ligne Protocol 2 dans le fichier
    # Sinon, on modifie la ligne deja existante 
    if [ $(cat /etc/ssh/sshd_config | grep Protocol | wc -l) -eq 0 ]; 
    then echo "Protocol 2" >> /etc/ssh/sshd_config
    else sed -i -e '1,/#Protocol [a-zA-Z0-9]/s/#Protocol [a-zA-Z0-9]/Protocol 2/' /etc/ssh/sshd_config 
    sed -i -e '1,/Protocol [a-zA-Z0-9]/s/Protocol [a-zA-Z0-9]/Protocol 2/' /etc/ssh/sshd_config
    fi

    echo "Changement de la valeur MaxAuthTries à 2 dans sshd_config"
    # Verification de l'existence du parametre MaxAuthTries dans le fichier sshd_config
    # Si le parametre n'existe pas, alors on ajoute la ligne MaxAuthTries 2 dans le fichier
    # Sinon, on modifie la ligne deja existante 
    if [ $(cat /etc/ssh/sshd_config | grep MaxAuthTries | wc -l) -eq 0 ]; 
    then echo "MaxAuthTries 2" >> /etc/ssh/sshd_config
    else sed -i -e '1,/#MaxAuthTries [a-zA-Z0-9]/s/#MaxAuthTries [a-zA-Z0-9]/MaxAuthTries 2/' /etc/ssh/sshd_config 
    sed -i -e '1,/MaxAuthTries [a-zA-Z0-9]/s/MaxAuthTries [a-zA-Z0-9]/MaxAuthTries 2/' /etc/ssh/sshd_config
    fi

    # Interdire l'utilisation du login root pour SSH
    echo "Interdire l'utilisation du login root pour SSH"
    sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

    # Empecher l'authentification SSH par mots de passe et forcer l'utilisation des cles
    echo "Empecher l'authentification SSH par mots de passe"
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

    # Ajout des utilisateurs autorises à utiliser SSH
    echo 'Ajout des utilisateurs autorises à utiliser SSH'
    read -p "Choisir la liste des utilisateurs autorises a se connecter en SSH (a separer avec un espace) : " ALLOWED_USERS 
    echo "AllowUsers  $ALLOWED_USERS" >> /etc/ssh/sshd_config

    # Refuser l'utilisateur root en SSH
    echo "Refus de l'utilisateur root en SSH"
    echo 'DenyUsers root' >> /etc/ssh/sshd_config

    # Refuser le groupe root en SSH
    echo 'Refus du groupe root en SSH'
    echo 'DenyGroups root' >> /etc/ssh/sshd_config

}

sshaccess(){
    # Gestion des autorisations d'acces au fichier sshd_config
    echo "Modification des acces au fichier sshd_config"
    chmod 600 /etc/ssh/sshd_config
}

sshrestart(){
    # Redemarrage du service sshd pour que les modifications soient prises en compte
    echo "Redemarrage du service sshd"
    systemctl restart sshd
}