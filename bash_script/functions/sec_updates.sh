#!/bin/bash

sec_updates () {
    figlet "SEC UPDATES"
    # Mise à jour/Install des paquets de sécurité
    apt install -y unattended-upgrades
    apt install -y debian-security-support
}