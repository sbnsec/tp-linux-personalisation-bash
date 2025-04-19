# my_script/functions/log_setup.sh

setup_authenticator() {
    apt-get install -y libpam-google-authenticator
    su - $username -c google-authenticator

    echo "auth required pam_google_authenticator.so" | tee -a /etc/pam.d/sshd

    echo "ChallengeResponseAuthentication yes" | tee -a $SSH_CONFIG_FIL
    echo "AuthenticationMethods publickey" | tee -a $SSH_CONFIG_FIL
    echo "AuthenticationMethods keyboard-interactive" | tee -a $SSH_CONFIG_FIL
    systemctl restart sshd
        echo -e "______________________________________________________"
        echo -e "| Service ssh redémarré, double Authentication activé |"
        echo -e "______________________________________________________"
}

# Auto Update
setup_auto_updates() {
    apt-get install -y unattended-upgrades

    {
        echo "APT::Periodic::Update-Package-Lists "1";"
        echo "APT::Periodic::Unattended-Upgrade "1";"
    } | tee -a /etc/apt/apt.conf.d/20auto-upgrades

    systemctl restart apt-daily.timer
    systemctl restart apt-daily-upgrade.timer
        echo -e "_______________________________"
        echo -e "| Service d'auto update acitvé |"
        echo -e "_______________________________"
}
