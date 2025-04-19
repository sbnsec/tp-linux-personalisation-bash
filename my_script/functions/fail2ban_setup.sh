# my_script/functions/fail2ban_setup.sh

setup_fail2ban() {
    systemctl start fail2ban
    systemctl enable fail2ban
        echo -e "__________________________________________"
        echo -e "| Service fail2ban activé et configuré ! |"
        echo -e "__________________________________________"
}
