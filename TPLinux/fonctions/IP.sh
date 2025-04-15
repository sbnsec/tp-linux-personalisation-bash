#!/bin/bash

IP(){
    while true; do
        echo "Entrez une adresse IPv4 autorisez à faire du SSH"
        read ipv4

        if [[ "$ipv4" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            break
        else
            echo "Ceci n'est pas une adresse IPv4"
        fi
    done

    # Récupère l'adresse IP et le masque CIDR de l'interface réseau active
    CIDR=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
    NETWORK=$(echo "$CIDR" | sed 's/\([0-9]*\.[0-9]*\.[0-9]*\.\)[0-9]*\/\([0-9]*\)/\10\/\2/')

    sudo sed -i '$ a sshd: ALL : deny' /etc/hosts.deny
    sudo sed -i '$ a sshd: '$ipv4','$NETWORK' : allow' /etc/hosts.allow
}
