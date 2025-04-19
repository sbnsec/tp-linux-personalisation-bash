# my_script/functions/firewall_setup.sh

setup_ufw() {
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ssh
    ufw allow 80/tcp

    ufw enable
        echo -e "_____________________________________"
        echo -e "| Service UFW activé et configuré ! |"
        echo -e "_____________________________________"
}
