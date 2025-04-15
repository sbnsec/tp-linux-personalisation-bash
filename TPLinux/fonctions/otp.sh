#!/bin/bash

otp(){
    sudo sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
    sudo sed -i 's/@include common-auth/#@include common-auth/' /etc/pam.d/sshd
    sudo sed -i '$ a auth   required   pam_google_authenticator.so' /etc/pam.d/sshd
    sudo systemctl restart ssh

    # Configuration de Google Authenticator pour la 2FA avec TOTP.
    # -t : Codes basés sur le temps.
    # -d : Interdiction de réutiliser le même code.
    # -f : Forcer la configuration sans confirmation.
    # -r 3 : Limite à 3 tentatives avant blocage.
    # -R 15 : Attente de 10 secondes entre tentatives échouées.
    # -W : Désactive les avertissements de limitation.
    google-authenticator -t -d -f -r 3 -R 15 -W
}
